import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todokit/taskkit/core/error/registraction_error.dart';
import 'package:todokit/taskkit/domain/repository/auth_checking_repo.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthCheckingRepoImpl _repo;
  LoginBloc(this._repo) : super(LoginInitial()) {
   on<LoginRequested>(_onLoginRequested);
  }

  void _onLoginRequested(LoginRequested event, Emitter<LoginState> emit) async {
   emit(LoginLoading());
   try {
     final bool response = await _repo.isAuthenticated(emailId: event.email, password: event.password);

     if (response) {
       emit(LoginSuccess());
       await Future.delayed(const Duration(seconds: 1));
       emit(LoginInitial());
       return;
     } else {
       emit(LoginFailure(errorMessage: 'Login failed. Please try again.'));
       return;
     }
   } catch (e) {
    final String errorMessage = FirebaseErrorHelper.getErrorMessage(e);
     emit(LoginFailure(errorMessage: errorMessage));

   }
  }
}
