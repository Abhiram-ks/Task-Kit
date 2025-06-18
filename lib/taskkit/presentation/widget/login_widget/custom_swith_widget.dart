


import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todokit/taskkit/core/themes/app_colors.dart';

class CustomSwithcingCombonent {
  static Widget goToregister(
      {required String prefixText,
      required String suffixText,
      required double screenWidth,
      required double screenHeight,
      required VoidCallback onTap,
      required BuildContext context}) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 2.0),
          child: Row(
            children: [
              Expanded(
                child: Divider(
                  thickness: 0.9,
                  color: AppPalette.hint,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "Or",
                ),
              ),
              Expanded(
                child: Divider(
                  thickness: 0.9,
                  color: AppPalette.hint,
                ),
              ),
            ],
          ),
        ),
       SizedBox(height: screenHeight * .02,),
        Align(
          alignment: Alignment.topCenter,
          child: RichText(
            text: TextSpan(
              text: prefixText,
              style: TextStyle(
                color: AppPalette.black,
              ),
              children: [
                TextSpan(
                    text: suffixText,
                    style: TextStyle(
                      color: AppPalette.black,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = onTap),
              ],
            ),
          ),
        ),
     
      ],
    );
  }

}