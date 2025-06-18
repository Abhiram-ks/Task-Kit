import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todokit/taskkit/data/model/tasks_model.dart';

class SpecificTaskRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<TasksModel> streamTask({required String todoId}) {
    final taskDocRef = _firestore.collection('tasks').doc(todoId);
    try {
      return taskDocRef.snapshots().map((docSnapshot) {
      if (docSnapshot.exists) {
        return TasksModel.fromMap(docSnapshot.data()!);
      } else {
        throw Exception('Task not found');
      }
    });
    } catch (e) {
        throw Exception(e);
    }
  }
}
