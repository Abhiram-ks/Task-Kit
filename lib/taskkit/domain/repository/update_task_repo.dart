import 'package:cloud_firestore/cloud_firestore.dart';

class TaskUpdateRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> taskUpdate({required String todoId, required String titile, required String description,required Timestamp dateTime}) async {
    try {
      final docQuary =  _firestore.collection('tasks').doc(todoId);
      docQuary.update({
       'title': titile,
       'title_lowercase': titile.toLowerCase(),
       'description': description,
       'updatedAt': FieldValue.serverTimestamp(),
       'date_time': dateTime,
       }
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}
