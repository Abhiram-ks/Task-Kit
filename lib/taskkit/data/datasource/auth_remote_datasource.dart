import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todokit/taskkit/core/hash_function/hash_function.dart';

abstract class AuthRemoteDatasourceRepo {
  Future<bool> register({required String email, required String password});
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasourceRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<bool> register({
    required String email,
    required String password,
  }) async {
    try {
      QuerySnapshot emailQuery = await _firestore
              .collection('users')
              .where('email', isEqualTo: email)
              .get();

      //!Check if the email already exists
      if (emailQuery.docs.isNotEmpty) {
        return false;
      }
      final String hashedPassword = Hashfunction.generateHash(password);
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: email,
            password: hashedPassword,
          );

      if (userCredential.user != null) {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'email': email,
          'uid': userCredential.user!.uid,
          'createdAt': FieldValue.serverTimestamp(),
        });
        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }
}
