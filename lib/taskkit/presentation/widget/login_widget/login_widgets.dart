import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todokit/taskkit/core/themes/app_colors.dart';
import 'package:todokit/taskkit/presentation/screen/register_screen/register_screen.dart';
import 'package:todokit/taskkit/presentation/widget/login_widget/custom_swith_widget.dart';
import 'package:todokit/taskkit/presentation/widget/login_widget/login_credential.dart';

class LoginComponents {
  static Widget loginTopSection(double screenHeight, double screenWidth) {
    return Container(
      height: screenHeight * 0.28,
      width: screenWidth,
      color: AppPalette.button,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 70,
              height: 70,
              child: Image.asset('assets/taskkit.png', fit: BoxFit.cover),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              'T Λ S K  K I T',
              style: GoogleFonts.poppins(
                color: AppPalette.white,
                fontSize: 33,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              'Innovate, Execute, Succeed',
              style: GoogleFonts.poppins(
                color: AppPalette.white,
                fontWeight: FontWeight.w200,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget loginBottomSection(double screenHeight, double screenWidth, GlobalKey<FormState> formKey, BuildContext context){
    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight:Radius.circular(30),
        ),
        color: AppPalette.white
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal:screenWidth > 600 ? screenWidth *.3 : screenWidth * 0.08, vertical: screenHeight * .03),
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
             mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Welcome back!',
                  style: GoogleFonts.plusJakartaSans(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: screenHeight * .02,),
           Text( "Please enter your login information below to access your account. Join now.",style: TextStyle(color: AppPalette.grey),),
            SizedBox(height: screenHeight * .01,),
           LoginFormWidget(screenHeight: screenHeight, screenWidth: screenWidth, formKey: formKey),
           CustomSwithcingCombonent.goToregister(prefixText: "Don't have an account?", suffixText: ' Register', screenWidth: screenWidth, screenHeight:screenHeight, onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) =>  RegisterScreen()),), context: context),
          ],
        ),
        )
    );
  }
}