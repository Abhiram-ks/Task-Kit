import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todokit/taskkit/core/error/registraction_error.dart';
import 'package:todokit/taskkit/data/datasource/auth_remote_datasource.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRemoteDatasourceRepo _repo;
  RegisterBloc(this._repo) : super(RegisterInitial()) {
    on<RegisterRequest>(_onRegisterRequest);
  }

  Future<void> _onRegisterRequest(
    RegisterRequest event,
    Emitter<RegisterState> emit,
  ) 
  async {
    emit(RegisterLoading());
    try {
      final bool response = await _repo.register(
        email: event.email,
        password: event.password,
      );
      if (response) {
        emit(RegisterSuccess());
        await Future.delayed(const Duration(seconds: 1));
        emit(RegisterInitial());
        return;
      } else {
        emit(RegisterFailure(error: 'Registration failed. Please try again.'));
        return;
      }
    } catch (e) {
      final String getErrorMessage = FirebaseErrorHelper.getErrorMessage(e);
      emit(RegisterFailure(error: getErrorMessage));
    }
  }
}
