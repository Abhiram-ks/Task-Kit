
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todokit/taskkit/core/themes/app_colors.dart';
import 'package:todokit/taskkit/data/repository/auth_checking_repo.dart';
import 'package:todokit/taskkit/presentation/provider/bloc/login_bloc/login_bloc.dart';
import 'package:todokit/taskkit/presentation/widget/login_widget/login_widgets.dart';

class Loginscreen extends StatelessWidget {
   final _formKey = GlobalKey<FormState>();
   Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(AuthCheckingRepoImpl()),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double height = constraints.maxHeight;
          double width = constraints.maxWidth;
          return ColoredBox(
            color: AppPalette.button,
            child: SafeArea(
              child: Scaffold(
                body: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                      children: [
                        LoginComponents.loginTopSection(height, width),
                        LoginComponents.loginBottomSection(height, width, _formKey, context),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


