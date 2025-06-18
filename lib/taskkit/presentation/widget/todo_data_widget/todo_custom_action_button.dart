import 'package:flutter/material.dart';

IconButton iconsFilledDetail(
    {required BuildContext context,
    required Color fillColor,
    required double borderRadius,
    required Color forgroudClr,
    required double padding,
    required VoidCallback onTap,
    required IconData icon}) {
  return IconButton.filled(
    onPressed: onTap,
    icon: Icon(icon),
    style: IconButton.styleFrom(
      backgroundColor: fillColor,
      foregroundColor: forgroudClr,
      padding: EdgeInsets.all(padding),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    ),
  );
}


  Column detailsPageActions(
      {required BuildContext context,
      required double screenWidth,
      required IconData icon,
      required VoidCallback onTap,
      Color ? colors,
      required String text}) {
    return Column(
      children: [
        iconsFilledDetail(
          icon: icon,
          forgroudClr:colors ?? Color.fromARGB(255, 67, 142, 254),
          context: context,
          borderRadius: 15,
          padding: screenWidth * .05,
          fillColor: Color.fromARGB(255, 216, 228, 248),
          onTap: onTap,
        ),
        Text(text)
      ],
    );
  }