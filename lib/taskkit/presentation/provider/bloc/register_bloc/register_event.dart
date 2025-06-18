part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class RegisterRequest extends RegisterEvent {
  final String email;
  final String password;

  RegisterRequest({required this.email, required this.password});
}
