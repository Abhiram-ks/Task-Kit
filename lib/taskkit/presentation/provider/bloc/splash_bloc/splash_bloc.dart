
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  SplashBloc() : super(SplashInitial()) {
   on<SplashEventStart>(_onStartSplash);
  }

  Future<void> _onStartSplash(SplashEventStart event, Emitter<SplashState> emit) async {
    try {
      const duration = Duration(milliseconds: 2000);
      final stopwatch = Stopwatch()..start();

      while (stopwatch.elapsed < duration) {
        for (double progress = 0.0; progress <= 1.0; progress += 0.01) {
          emit(SplashAnimating(progress));
          await Future.delayed(const Duration(milliseconds: 10));
        }
      }
   if (_auth.currentUser != null) {
      emit(GoToHome());
      return;
   } else {
      emit(GoToLogin());
      return;
   }
   } catch (e) {
     emit(GoToLogin());
   } finally {
    emit(SplashAnimatingCompleted());
   }
  }
}
