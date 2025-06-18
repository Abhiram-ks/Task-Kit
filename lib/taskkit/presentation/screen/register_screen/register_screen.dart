
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todokit/taskkit/core/common/custom_appbar_widget.dart';
import 'package:todokit/taskkit/data/datasource/auth_remote_datasource.dart';
import 'package:todokit/taskkit/presentation/provider/bloc/register_bloc/register_bloc.dart';
import '../../widget/register_widget/register_credential_widget.dart';

class RegisterScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(AuthRemoteDatasourceImpl()),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;
          double height = constraints.maxHeight;
          return Scaffold(
            appBar: CustomAppBar(),
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width > 600 ? width * .3 : width * 0.06,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Join Us Today',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      Text(
                        'Create your account and unlock a world of possibilities.',
                      ),
                      SizedBox(height: height * 0.02),
                      RegisterCredentialFiled(
                        width: width,
                        height: height,
                        formKey: _formKey,
                      ),
                    ],
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



