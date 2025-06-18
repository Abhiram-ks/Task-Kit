import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todokit/taskkit/presentation/provider/cubit/logout_cubit/logout_cubit.dart';
import 'package:todokit/taskkit/presentation/screen/login_screen/login_screen.dart';

import '../../../core/themes/app_colors.dart';

void handleLogoutState({
  required BuildContext context,
  required LogoutState state,
}) {
  if (state is LogoutSuccess) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Loginscreen()),
      (route) => false,
    );
  } else if (state is LogoutConfirmation) {
    showCupertinoModalPopup(
      context: context,
      builder:
          (_) => CupertinoActionSheet(
            title: const Text(
              'Are you sure?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            message: const Text(
              'Do you really want to log out of your account? You will need to log in again to access your tasks.',
            ),
            actions: [
              CupertinoActionSheetAction(
                onPressed: () {
                  context.read<LogoutCubit>().logOut();
                },
                isDestructiveAction: true,
                child: const Text(
                  'Yes, Log Out',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 15, color: AppPalette.black),
              ),
            ),
          ),
    );
  } else if (state is Logoutfailure) {
    showCupertinoDialog(
      context: context,
      builder:
          (_) => CupertinoAlertDialog(
            title: Text('Logout Failed'),
            content: Text(state.errorMessage),
            actions: [
              CupertinoDialogAction(
                child: Text('Retry', style: TextStyle(color: AppPalette.red)),
                onPressed: () {
                  Navigator.of(context).pop();
                  context.read<LogoutCubit>().logOut();
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
  } else if (state is LogoutLoading) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => Center(
            child: CircularProgressIndicator(color: AppPalette.button),
          ),
    );
  } else {
    Navigator.pop(context);
  }
}
