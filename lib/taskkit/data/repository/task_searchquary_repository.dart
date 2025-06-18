import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todokit/taskkit/data/model/tasks_model.dart';

class TaskSearchquaryRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<TasksModel>> streamTask({required String query}) {
    String endQuery = query.isNotEmpty
        ? query.substring(0, query.length - 1) +
            String.fromCharCode(query.codeUnitAt(query.length - 1) + 1)
        : '';

    Query taskQuery;

    if (query.isEmpty) {
      taskQuery = _firestore
          .collection('tasks')
          .orderBy('createdAt', descending: true);
    } else {
      taskQuery = _firestore
          .collection('tasks')
          .orderBy('title_lowercase')
          .startAt([query])
          .endAt([endQuery]);
    }

    return taskQuery.snapshots().map((snapshot) {
      try {
        return snapshot.docs
            .map((doc) => TasksModel.fromMap(doc.data() as Map<String, dynamic>))
            .toList();
      } catch (e) {
        return <TasksModel>[];
      }
    });
  }
}
