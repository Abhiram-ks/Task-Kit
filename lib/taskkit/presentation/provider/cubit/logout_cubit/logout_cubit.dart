import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  LogoutCubit() : super(LogoutInitial());


  void logoutConfirmation() {
    emit(LogoutConfirmation());
  }

  Future<void> logOut() async {
    emit(LogoutLoading());
    try {
      await _auth.signOut();
      emit(LogoutSuccess());
    } catch (e) {
      emit(Logoutfailure(e.toString()));
    }
  }
}
