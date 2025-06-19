

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todokit/taskkit/core/common/custom_snackbar_widget.dart';
import 'package:todokit/taskkit/presentation/provider/cubit/mark_status_cubit/mark_status_cubit.dart';

import '../../../core/themes/app_colors.dart';

void handleCheckMarkState({
  required BuildContext context,
  required MarkStatusState state,
  required bool val,
}) {
  if (state is MarkUpdateingSuccess) {
    showSnackBar(
      bgColor: val ? AppPalette.green : AppPalette.orengeClr,
      message: 'Task Status Update successful!',
      context: context,
      icon:val
              ? Icons.check_circle_outline_sharp
              : Icons.pending_actions_rounded,
    );
  } else if (state is MarkUpdatingFailure) {
    showSnackBar(
      bgColor: AppPalette.red,
      message: 'Task Status Update Failure!',
      context: context,
      icon: CupertinoIcons.clear_circled,
    );
  }
}
