part of 'password_cubit.dart';


sealed class IconState {

  
  const IconState();
}

final class IconInitial extends IconState {}

class ColorUpdated extends IconState {
  final Color color;

  const ColorUpdated({required this.color});
}


class PasswordVisibilityUpdated extends IconState {
  final bool isVisible;

  const PasswordVisibilityUpdated({required this.isVisible});
}