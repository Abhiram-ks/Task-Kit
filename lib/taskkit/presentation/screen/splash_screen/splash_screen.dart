import 'package:flutter/material.dart';
import 'package:todokit/taskkit/presentation/widget/splash_widget/splash_body_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double height = constraints.maxHeight;

        return Scaffold(
          body: SplashBodyWidget(height: height),
        );
      },
    );
  }
}
