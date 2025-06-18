import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todokit/taskkit/core/common/custom_appbar_widget.dart';
import 'package:todokit/taskkit/presentation/provider/cubit/logout_cubit/logout_cubit.dart';
import 'package:todokit/taskkit/presentation/screen/add_screen/add_todo_screen.dart';
import 'package:todokit/taskkit/presentation/screen/login_screen/login_screen.dart';

import '../../../core/themes/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogoutCubit(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;
          double height = constraints.maxHeight;

          return BlocListener<LogoutCubit, LogoutState>(
            listener: (context, state) {
              handleLogoutState(
                context: context,
                state: state,
              );
            },
            child: Scaffold(
              appBar: CustomAppBar(
                title: 'Log Out',
                titleColor: AppPalette.black,
                onPressed: () {
                  context.read<LogoutCubit>().logoutConfirmation();
                },
              ),
              body: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width > 600 ? width * .3 : width * 0.06,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome to the Home Screen',
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(height: height * 0.02),
                      ElevatedButton(
                        onPressed: () {
                          // Action for button
                        },
                        child: Text('Click Me'),
                      ),
                    ],
                  ),
                ),
              ),

              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddTodoScreen(isEdit: false,)),
                  );
                },
                backgroundColor: AppPalette.button,
                child: Icon(Icons.add_task_sharp, color: AppPalette.white),
              ),
            ),
          );
        },
      ),
    );
  }
}

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
    builder: (_) => CupertinoActionSheet(
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
          child: const Text('Yes, Log Out',style: TextStyle(fontSize: 15),),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancel',style: TextStyle(fontSize: 15,color: AppPalette.black),),
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
