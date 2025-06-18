part of 'splash_bloc.dart';

@immutable
sealed class SplashState {}

final class SplashInitial extends SplashState {}
final class SplashAnimating extends SplashState {
  final double animationValue;
  SplashAnimating  (this.animationValue);
}

final class SplashAnimatingCompleted extends SplashState {}

final class GoToHome extends SplashState {}
final class GoToLogin extends SplashState {}
