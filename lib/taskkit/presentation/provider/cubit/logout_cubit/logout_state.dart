part of 'logout_cubit.dart';

@immutable
abstract class LogoutState {}

final class LogoutInitial extends LogoutState {}
final class LogoutConfirmation extends LogoutState {}
final class LogoutLoading extends LogoutState {}
final class LogoutSuccess extends LogoutState {}
final class Logoutfailure extends LogoutState {
  final String errorMessage;

  Logoutfailure(this.errorMessage);
}
