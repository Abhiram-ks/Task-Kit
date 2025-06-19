
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todokit/taskkit/core/common/custom_snackbar_widget.dart';
import 'package:todokit/taskkit/core/themes/app_colors.dart';
import 'package:todokit/taskkit/presentation/provider/bloc/task_delete_bloc/task_delete_bloc.dart';

void handleDeleteState({
  required BuildContext context,
  required TaskDeleteState state,
  required String todoId,
  required bool needPop,
}) {
  if (state is TaskDeleteSuccess) {
    if (needPop) {
      Navigator.pop(context);
    } else {
      showSnackBar(
        bgColor: AppPalette.green,
        message: "Task deletion completed.",
        context: context,
        icon: Icons.delete_sweep_rounded,
      );
    }
  } else if (state is TaskDeleteFailure) {
    showCupertinoDialog(
      context: context,
      builder:
          (_) => CupertinoAlertDialog(
            title: Text('Deletion Failed'),
            content: Text(
              'The task could not be deleted due to an unexpected error. Please try again.',
            ),
            actions: [
              CupertinoDialogAction(
                child: Text('Retry', style: TextStyle(color: AppPalette.red)),
                onPressed: () {
                  Navigator.pop(context);
                  context.read<TaskDeleteBloc>().add(DeletetaskProced(todoId));
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
  } else if (state is TaskDeleteConfirmation) {
    showCupertinoModalPopup(
      context: context,
      builder:
          (_) => CupertinoActionSheet(
            title: const Text(
              "Are you sure? you want to delete this task?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            message: const Text(
              "Once confirmed, this task will be permanently deleted from the database. This action cannot be undone.",
            ),
            actions: [
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                  context.read<TaskDeleteBloc>().add(DeletetaskProced(todoId));
                },
                isDestructiveAction: true,
                child: const Text(
                  'Yes, Proceed',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                isDestructiveAction: true,
                child: const Text(
                  "Maybe Later",
                  style: TextStyle(fontSize: 15, color: AppPalette.black),
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
  }
}
