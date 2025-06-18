
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todokit/taskkit/core/hash_function/hash_function.dart';

abstract class AuthCheckingRepository {
  Future<bool> isAuthenticated({required String emailId, required String password});
}

class AuthCheckingRepoImpl implements AuthCheckingRepository {
  final FirebaseAuth _auth =FirebaseAuth.instance;

  @override
  Future<bool> isAuthenticated({required String emailId, required String password}) async {
    try {
      final String hashPassword = Hashfunction.generateHash(password);
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: emailId,
        password: hashPassword,
      );
      return userCredential.user != null;

    } catch (e) {
      return false;
    }
  }
}