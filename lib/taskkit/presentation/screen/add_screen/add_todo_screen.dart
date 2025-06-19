import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todokit/taskkit/core/common/custom_appbar_widget.dart';
import 'package:todokit/taskkit/presentation/provider/bloc/createtask_bloc/createtask_bloc.dart';
import 'package:todokit/taskkit/presentation/provider/cubit/pick_datetime_cubit.dart/pick_datetime_cubit.dart';
import 'package:todokit/taskkit/presentation/widget/add_widget/add_body_widget.dart';

class AddTodoScreen extends StatelessWidget {
   AddTodoScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CreatetaskBloc()),
        BlocProvider(create: (context) => PickDatetimeCubit()),
        ],
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
                    horizontal: width > 600 ? width * .3 : width * 0.05,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Organize Your Day',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      Text(
                        "Every great achievement begins with a task. Create yours, take action, and move one step closer to success.",
                      ),
                      SizedBox(height: height * 0.03),
                      AddTodoBodyWidget(
                        height: height,
                        width: width,
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


