
import 'package:flutter/material.dart';

import '../themes/app_colors.dart';

void showSnackBar({
  required BuildContext context,
  required String message,
  required Color bgColor,
  IconData? icon,
}) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  final snackBar = SnackBar(
    content: Row(
      children: [
        Icon(
          icon ?? Icons.check_circle,
          color: AppPalette.white,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            message,
            style: const TextStyle(color: AppPalette.white),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    ),
    backgroundColor: bgColor,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 3),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
