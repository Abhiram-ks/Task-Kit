import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todokit/taskkit/core/themes/app_colors.dart';
import 'package:todokit/taskkit/presentation/provider/bloc/splash_bloc/splash_bloc.dart';
import 'package:todokit/taskkit/presentation/widget/splash_widget/splash_state_handle.dart';

class SplashBodyWidget extends StatelessWidget {
  const SplashBodyWidget({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        handleSplashState(context, state);
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 170,
                height: 170,
                child: Image.asset('assets/taskkit.png', fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: height * 0.02),
            BlocBuilder<SplashBloc, SplashState>(
              builder: (context, state) {
                double animationValue = 0.0;

                if (state is SplashAnimating) {
                  animationValue = state.animationValue;
                }
                return ShaderMask(
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      colors: [AppPalette.blue, AppPalette.white],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [animationValue, animationValue + 0.3],
                    ).createShader(bounds);
                  },
                  child: Text(
                    'T Λ S K  K I T',
                    style: GoogleFonts.poppins(
                      color: AppPalette.white,
                      fontSize: 33,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                );
              },
            ),
            Text(
              'Innovate, Execute, Succeed',
              style: GoogleFonts.poppins(
                color: AppPalette.black,
                fontWeight: FontWeight.w200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


