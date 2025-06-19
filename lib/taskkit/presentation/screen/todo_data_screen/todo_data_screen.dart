
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todokit/taskkit/core/common/custom_appbar_widget.dart';
import 'package:todokit/taskkit/presentation/provider/bloc/specific_task/specific_task_bloc.dart';
import 'package:todokit/taskkit/presentation/provider/bloc/task_delete_bloc/task_delete_bloc.dart';
import 'package:todokit/taskkit/presentation/provider/bloc/update_task_bloc/update_task_bloc.dart';
import 'package:todokit/taskkit/presentation/provider/cubit/mark_status_cubit/mark_status_cubit.dart';
import 'package:todokit/taskkit/presentation/widget/todo_data_widget/tododata_body_widget.dart';
import '../../provider/cubit/pick_datetime_cubit.dart/pick_datetime_cubit.dart';

class TodoDataScreen extends StatelessWidget {
  final bool isEdit;
  final String todoId;
  TodoDataScreen({super.key, required this.isEdit, required this.todoId});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SpecificTaskBloc()),
        BlocProvider(create: (context) => MarkStatusCubit()),
        BlocProvider(create: (context) => TaskDeleteBloc()),
        BlocProvider(create: (context) => PickDatetimeCubit()),
        BlocProvider(create: (context) => UpdateTaskBloc()),
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
                        isEdit ? 'Refine your task' : 'Task Overview',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      Text(
                        isEdit
                            ? "Stay ahead by keeping your task details up to date. Small updates today lead to greater success tomorrow."
                            : "This section provides detailed information about your task and helps you track your progress effectively.",
                      ),
                      SizedBox(height: height * 0.03),
                      TodoDataBodyWidget(
                        todoId: todoId,
                        isEdit: isEdit,
                        height: height,
                        widget: width,
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


