import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todokit/taskkit/core/common/custom_button_widget.dart';
import 'package:todokit/taskkit/core/common/custom_snackbar_widget.dart';
import 'package:todokit/taskkit/core/validation/validation_helper.dart';
import 'package:todokit/taskkit/presentation/provider/bloc/login_bloc/login_bloc.dart';
import 'package:todokit/taskkit/presentation/widget/login_widget/handle_login_state.dart' show handleLoginState;

import '../../../core/common/custom_textfiled_widget.dart';

class LoginFormWidget extends StatefulWidget {
  final double screenHeight;
  final double screenWidth;
  final GlobalKey<FormState> formKey;
  const LoginFormWidget({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.formKey,
  });

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> with FormFieldMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          buildTextFormField(
            label: 'Email Address',
            hintText: 'example@ gmail.com',
            prefixIcon: Icons.attach_email_rounded,
            context: context,
            controller: _emailController,
            validate: ValidatorHelper.validateEmailId,
            height: widget.screenHeight,
          ),
          buildTextFormField(
            label: 'Password',
            hintText: '* * * * * *',
            prefixIcon: CupertinoIcons.padlock_solid,
            context: context,
            controller: _passwordController,
            validate: ValidatorHelper.loginValidation,
            height: widget.screenHeight,
            isPasswordField: true,
          ),
          SizedBox(height: widget.screenHeight * .02),
          BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
             handleLoginState(context: context, state: state, emailController: _emailController, passwordController: _passwordController,);
            },
            child: ButtonComponents.actionButton(
              screenHeight: widget.screenHeight,
              screenWidth: widget.screenWidth,
              label: 'Sign In',
              onTap: () {
                if (!widget.formKey.currentState!.validate()) {
                  showSnackBar(context: context, message: 'Follow the highlighted fields before proceeding.', bgColor: Colors.red, icon: CupertinoIcons.clear_circled);
                  return;
                }
                context.read<LoginBloc>().add(
                    LoginRequested(
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim(),
                    ),
                  );
              },
            ),
          ),
        ],
      ),
    );
  }
}



