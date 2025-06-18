
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todokit/taskkit/presentation/provider/cubit/button_progresser/button_progresser_cubit.dart';

import '../themes/app_colors.dart';

class ButtonComponents{
  static Widget actionButton({
    required double screenHeight,
    required double screenWidth,
    required String label,
    required VoidCallback onTap,
    Color? buttonColor,
    Color? textColor,
  }){
    return SizedBox(
      height: screenHeight * 0.06 ,
      width: screenWidth,
      child: Material(
        color:buttonColor ?? AppPalette.button,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          splashColor: Colors.white.withAlpha(77),
          child: Center(
            child: BlocBuilder<ButtonProgressCubit, ButtonProgressState>
            (builder: (context, state) {
              if (state is ButtonProgressLoading) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: AppPalette.white,
                        strokeWidth: 2.5,
                      ),
                    ),SizedBox(width: 10,),
                    Text(
                      'Please wait...',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppPalette.white,
                      ),
                    ),
                  ]
                  
                 );

              } else if (state is ButtonProgressDone) {
                return Center(
                  child: Icon(
                    Icons.check_circle,
                    color: AppPalette.white,
                    size: 24,
                  ),
                );
              }
              return Text(
                label,
                style: TextStyle(
                fontSize: 18,
                color:textColor ?? AppPalette.white,
                fontWeight: FontWeight.bold,
              ),
            );
            }
            )
          ),
        ),
      ),
    ); 
  }
}