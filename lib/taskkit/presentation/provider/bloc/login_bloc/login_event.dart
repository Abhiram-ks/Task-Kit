part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}
final class LoginRequested extends LoginEvent {
  final String email;
  final String password;

  LoginRequested({required this.email, required this.password});
}