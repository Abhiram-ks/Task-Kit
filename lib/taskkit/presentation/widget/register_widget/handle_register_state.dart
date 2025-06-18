

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todokit/taskkit/presentation/provider/bloc/register_bloc/register_bloc.dart';
import 'package:todokit/taskkit/presentation/provider/cubit/button_progresser/button_progresser_cubit.dart';
import 'package:todokit/taskkit/presentation/screen/login_screen/login_screen.dart' show Loginscreen;
import '../../../core/common/custom_snackbar_widget.dart';
import '../../../core/themes/app_colors.dart';

void handleRegistrationState({required BuildContext context,required RegisterState state,required TextEditingController emailController, required TextEditingController passwordController, required TextEditingController confirmPasswordController}) {
  final button = context.read<ButtonProgressCubit>();

  if (state is RegisterSuccess) {
    button.startButtonProgressDone();
    showSnackBar(bgColor: AppPalette.green,message: 'Registration successful!', context: context);

  } else if (state is RegisterInitial){
    button.stopLoading();
    Navigator.push(context, MaterialPageRoute(builder: (context) => Loginscreen()));
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }
  else if (state is RegisterFailure) {
   button.stopLoading();
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text('Registraction Failed'),
        content: Text(state.error),
        actions: [
          CupertinoDialogAction(
            child: Text('Retry', style: TextStyle(color: AppPalette.red)),
            onPressed: () {
              Navigator.of(context).pop();
              context.read<RegisterBloc>().add(RegisterRequest(
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
  } else if (state is RegisterLoading) {
    button.startLoading();
  }
 
}