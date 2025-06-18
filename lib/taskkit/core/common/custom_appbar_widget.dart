import 'package:flutter/material.dart';

import '../themes/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  
  @override
  final Size preferredSize;
  final String? title;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final bool? isTitle;
  final Color? titleColor;
  final Color? iconColor;

  const CustomAppBar({
    super.key,
    this.title,
    this.backgroundColor,
    this.titleColor,
    this.iconColor,
    this.isTitle = false,
    this.onPressed,
  })
      : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:backgroundColor ?? AppPalette.white,
      iconTheme: IconThemeData(color:iconColor ?? AppPalette.black),
      elevation: 0,
      scrolledUnderElevation: 0,
      actions: title != null 
              ? [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: TextButton(
                    onPressed: onPressed, 
                    child: Text(title!,style: TextStyle(color:titleColor, fontWeight: FontWeight.bold),
                    ))
                )
              ] : []
    );
  }
}
