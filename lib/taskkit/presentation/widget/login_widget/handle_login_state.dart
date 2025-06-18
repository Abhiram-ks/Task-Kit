import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todokit/taskkit/presentation/provider/bloc/login_bloc/login_bloc.dart';
import 'package:todokit/taskkit/presentation/screen/home_screen/home_screen.dart';

import '../../../core/themes/app_colors.dart';
import '../../provider/cubit/button_progresser/button_progresser_cubit.dart';

void handleLoginState({required BuildContext context,required LoginState state,required TextEditingController emailController, required TextEditingController passwordController}) {
  final button = context.read<ButtonProgressCubit>();

  if (state is LoginSuccess) {
    button.startButtonProgressDone();

  } else if (state is LoginInitial){
    button.stopLoading();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }
  else if (state is LoginFailure) {
   button.stopLoading();
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text('Login Failed'),
        content: Text(state.errorMessage),
        actions: [
          CupertinoDialogAction(
            child: Text('Retry', style: TextStyle(color: AppPalette.red)),
            onPressed: () {
              Navigator.of(context).pop();
              context.read<LoginBloc>().add(
                LoginRequested(  
                  email: emailController.text.trim(),
                  password: passwordController.text.trim(),
                ));
            },
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Cancel',
              style: TextStyle(color: AppPalette.black),
            ),
          ),
        ],
      ),
    );
  } else if (state is LoginLoading) {
    button.startLoading();
  }
 
}