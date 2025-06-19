import 'package:cloud_firestore/cloud_firestore.dart';

class CreatetaskRemoteDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> createTask({
    required String title,
    required String description,
    required String userId,
    required Timestamp dateTime,
  }) async {
    try {
      final docRef = _firestore.collection('tasks').doc();
      await docRef.set({
        'title':title,
        'title_lowercase': title.toLowerCase(),
        'todoId':docRef.id,
        'description': description,
        'userId':userId,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'date_time': dateTime,
        'isCompleted': false,
      });
      
      return true;
    } catch (e) {
      return false;
    }
  }
}