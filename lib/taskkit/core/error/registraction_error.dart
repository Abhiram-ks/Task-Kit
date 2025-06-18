
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseErrorHelper {
  static String getErrorMessage(Object error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'email-already-in-use':
          return 'This email is already in use.';
        case 'invalid-email':
          return 'The email address is not valid.';
        case 'weak-password':
          return 'The password is too weak.';
        case 'operation-not-allowed':
          return 'This operation is not allowed.';
        case 'user-not-found':
          return 'No user found with this email.';
        case 'wrong-password':
          return 'The password is incorrect.';
        case 'too-many-requests':
          return 'Too many attempts. Please try again later.';
        case 'user-disabled':
          return 'This user account has been disabled.';
        case 'network-request-failed':
          return 'Network error. Please check your internet connection.';
        default:
          return 'Something went wrong. Please try again.';
      }
    }
    return 'An unexpected error occurred.';
  }
}
