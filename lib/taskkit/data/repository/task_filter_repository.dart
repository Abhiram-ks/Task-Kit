import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todokit/taskkit/data/model/tasks_model.dart' show TasksModel;

class TaskFileterRepository{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<TasksModel>> streamTask({required bool val, required String userId}) {
    final taskQuary = _firestore
         .collection('tasks')
         .where('userId', isEqualTo:userId )
         .where('isCompleted', isEqualTo: val)
         .orderBy('createdAt', descending:  true);

    return taskQuary.snapshots().map((snapshot) {
      try {
        final tasks = snapshot.docs.map((doc){
          final task = TasksModel.fromMap(doc.data());
          return task;
        }).toList();

        return tasks;
      } catch (e) {
        return <TasksModel> [];
      }
    });
  }
}