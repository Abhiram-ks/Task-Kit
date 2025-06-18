import 'package:flutter/material.dart';
import 'package:todokit/taskkit/presentation/provider/bloc/splash_bloc/splash_bloc.dart';
import 'package:todokit/taskkit/presentation/screen/home_screen/home_screen.dart';

import '../../screen/login_screen/login_screen.dart';

void handleSplashState(BuildContext context, SplashState state) {
  if (state is GoToHome) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  HomeScreen()));
  } else if (state is GoToLogin) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  Loginscreen()));
  }
}