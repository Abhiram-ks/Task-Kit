import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteRequestRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> taskDelete({required String todoId}) async {
    try {
       _firestore.collection('tasks').doc(todoId).delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}
