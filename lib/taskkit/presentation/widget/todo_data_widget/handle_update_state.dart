
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todokit/taskkit/core/common/custom_snackbar_widget.dart';
import 'package:todokit/taskkit/core/themes/app_colors.dart';
import 'package:todokit/taskkit/presentation/provider/bloc/update_task_bloc/update_task_bloc.dart';
import 'package:todokit/taskkit/presentation/provider/cubit/button_progresser/button_progresser_cubit.dart';

void handleUpdateState({
  required BuildContext context,
  required UpdateTaskState state,
}) {
  final button = context.read<ButtonProgressCubit>();
  if (state is UpdateTaskSuccess) {
    button.stopLoading;
    showSnackBar(
      bgColor: AppPalette.green,
      message: 'Task Status Update successful!',
      context: context,
    );
  } else if (state is UpdateTaskLoading) {
    button.startLoading;
  } else if (state is UpdateTaskFailure) {
    button.stopLoading;
    showSnackBar(
      bgColor: AppPalette.red,
      message: 'Task Status Update Failure!',
      context: context,
      icon: CupertinoIcons.clear_circled,
    );
  }
}
