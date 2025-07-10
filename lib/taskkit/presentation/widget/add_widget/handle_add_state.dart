import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todokit/taskkit/core/common/custom_snackbar_widget.dart';
import 'package:todokit/taskkit/core/themes/app_colors.dart';
import 'package:todokit/taskkit/presentation/provider/bloc/createtask_bloc/createtask_bloc.dart';
import 'package:todokit/taskkit/presentation/provider/cubit/button_progresser/button_progresser_cubit.dart';

void handleBlocListener({
  required BuildContext context,
  required CreatetaskState state,
  required TextEditingController titleController,
  required TextEditingController descriptionController,
  required DateTime dateTime,
  required GlobalKey<FormState> formKey, 
}) {
  final button = context.read<ButtonProgressCubit>();
  if (state is CreatetaskLoading) {
    button.startLoading();
  } else if (state is CreatetaskSuccess) {
    button.stopLoading();
    formKey.currentState?.reset();
    Navigator.pop(context);

    showSnackBar(
      context: context,
      message: "Task created successfully!",
      bgColor: AppPalette.green,
      icon: Icons.check_circle,
    );
  } else if (state is CreatetaskFailure) {
    button.stopLoading();
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text('Uploading Failed'),
        content: Text(state.error),
        actions: [
          CupertinoDialogAction(
            child: Text('Retry', style: TextStyle(color: AppPalette.red)),
            onPressed: () {
              Navigator.of(context).pop();
              context.read<CreatetaskBloc>().add(CreatetaskInitialEvent(
                titile: titleController.text.trim(),
                description: descriptionController.text.trim(),
                dateTime: dateTime
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
  }
}
