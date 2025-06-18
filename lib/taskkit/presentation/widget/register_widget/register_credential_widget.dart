
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todokit/taskkit/core/common/custom_button_widget.dart';
import 'package:todokit/taskkit/core/common/custom_snackbar_widget.dart';
import 'package:todokit/taskkit/core/common/custom_textfiled_widget.dart';
import 'package:todokit/taskkit/core/validation/validation_helper.dart';
import 'package:todokit/taskkit/presentation/provider/bloc/register_bloc/register_bloc.dart';
import 'package:todokit/taskkit/presentation/widget/register_widget/handle_register_state.dart';
import 'package:todokit/taskkit/presentation/widget/login_widget/custom_swith_widget.dart';

import '../../screen/login_screen/login_screen.dart';

class RegisterCredentialFiled extends StatefulWidget {
  final double width;
  final double height;
  final GlobalKey<FormState> formKey;
  const RegisterCredentialFiled({
    super.key,
    required this.width,
    required this.height,
    required this.formKey,
  });

  @override
  State<RegisterCredentialFiled> createState() =>
      _RegisterCredentialFiledState();
}

class _RegisterCredentialFiledState extends State<RegisterCredentialFiled>  with FormFieldMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
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
            height: widget.height,
          ),
          buildTextFormField(
            label: ' Create Password',
            hintText: '* * * * * *',
            prefixIcon: CupertinoIcons.padlock_solid,
            context: context,
            controller: _passwordController,
             isPasswordField: true,
            validate: ValidatorHelper.validatePassword,
            height: widget.height,
            maxlength: 15,
          ),
          buildTextFormField(
            label: 'Confirm Password',
            hintText: '* * * * * *',
            prefixIcon: CupertinoIcons.padlock_solid,
            context: context,
            isPasswordField: true,
            controller: _confirmPasswordController,
            validate:
                (value) => ValidatorHelper.validatePasswordMatch(
                  _passwordController.text,
                  value,
                ),
            height: widget.height,
          ),
          SizedBox(height: widget.height * 0.02),
          BlocListener<RegisterBloc, RegisterState>(
            listener: (context, state) {
              handleRegistrationState(context: context, state: state, emailController: _emailController, passwordController: _passwordController, confirmPasswordController: _confirmPasswordController);
            },
            child: ButtonComponents.actionButton(
              screenHeight: widget.height,
              screenWidth: widget.width,
              label: 'Register',
              onTap: () {
                if (!widget.formKey.currentState!.validate()) {
                  showSnackBar(context: context, message: 'Follow the highlighted fields before proceeding.', bgColor: Colors.red, icon: CupertinoIcons.clear_circled);
                  return;
                }
                context.read<RegisterBloc>().add(RegisterRequest(
                  email: _emailController.text.trim(),
                  password: _passwordController.text.trim(),
                ));
              },
            ),
          ),
          SizedBox(height: widget.height * .03),
          CustomSwithcingCombonent.goToregister(
            prefixText: "Already have an account?",
            suffixText: ' Sign In',
            screenWidth: widget.width,
            screenHeight: widget.height,
            onTap: () => Navigator.push( context, MaterialPageRoute(builder: (context) => Loginscreen()) ),
            context: context,
          ),
        ],
      ),
    );
  }
}
