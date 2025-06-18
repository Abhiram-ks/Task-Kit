import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todokit/taskkit/core/common/custom_appbar_widget.dart';
import 'package:todokit/taskkit/core/common/custom_button_widget.dart';
import 'package:todokit/taskkit/core/common/custom_snackbar_widget.dart';
import 'package:todokit/taskkit/core/common/custom_textfiled_widget.dart';
import 'package:todokit/taskkit/core/themes/app_colors.dart';
import 'package:todokit/taskkit/core/validation/validation_helper.dart';
import 'package:todokit/taskkit/presentation/provider/bloc/createtask_bloc/createtask_bloc.dart';
import 'package:todokit/taskkit/presentation/provider/cubit/button_progresser/button_progresser_cubit.dart';

class AddTodoScreen extends StatelessWidget {
  final bool isEdit;
  final String? todoId;
  AddTodoScreen({super.key, required this.isEdit, this.todoId});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => CreatetaskBloc())],
      child: LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;
          double height = constraints.maxHeight;

          return Scaffold(
            appBar: CustomAppBar(),
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),

              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width > 600 ? width * .3 : width * 0.05,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isEdit ? 'Refine Your Task' : 'Organize Your Day',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      Text(
                        isEdit
                            ? "Stay ahead by keeping your task details up to date. Small updates today lead to greater success tomorrow."
                            : "Every great achievement begins with a task. Create yours, take action, and move one step closer to success.",
                      ),
                      SizedBox(height: height * 0.03),
                      AddTodoBodyWidget(
                        isEdit: isEdit,
                        todoId: todoId,
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

class AddTodoBodyWidget extends StatefulWidget {
  final bool isEdit;
  final String? todoId;
  final double height;
  final double width;
  final GlobalKey<FormState> formKey;
  const AddTodoBodyWidget({
    super.key,
    required this.isEdit,
    required this.formKey,
    this.todoId,
    required this.height,
    required this.width,
  });

  @override
  State<AddTodoBodyWidget> createState() => _AddTodoBodyWidgetState();
}

class _AddTodoBodyWidgetState extends State<AddTodoBodyWidget>
    with FormFieldMixin {
  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTextFormField(
            label: 'Task Title',
            hintText: "Enter a short description about task",
            prefixIcon: Icons.add_task_rounded,
            context: context,
            controller: titleController,
            validate: ValidatorHelper.validateTaskTitle,
            height: widget.height,
            maxlength: 80,
          ),
          buildTextFormField(
            label: 'Task Description',
            hintText: "Enter a description about task",
            prefixIcon: Icons.info_outline_rounded,
            context: context,
            controller: descriptionController,
            validate: ValidatorHelper.validateTaskDescription,
            height: widget.height,
            maxlength: 2000,
            maxLine: 6,
          ),
          SizedBox(height: widget.height * 0.04),
          BlocListener<CreatetaskBloc, CreatetaskState>(
            listener: (context, state) {
              handleBlocListener(context: context, state: state, titleController: titleController, descriptionController: descriptionController);
            },
            child: ButtonComponents.actionButton(
              screenHeight: widget.height,
              screenWidth: widget.width,
              label: widget.isEdit ? 'Update Task' : 'Create Task',
              onTap: () {
                if (widget.isEdit) {
                } else {
                  if (!widget.formKey.currentState!.validate()) {
                    showSnackBar(
                      context: context,
                      message:
                          "Oops! You missed some required fields. Please complete them before proceeding.",
                      bgColor: AppPalette.red,
                      icon: CupertinoIcons.clear_circled,
                    );
                    return;
                  }
                  BlocProvider.of<CreatetaskBloc>(context).add(
                    CreatetaskInitialEvent(
                      titile: titleController.text.trim(),
                      description: descriptionController.text.trim(),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

void handleBlocListener({
  required BuildContext context,
  required CreatetaskState state,
  required TextEditingController titleController,
  required TextEditingController descriptionController,
}) {
  final button = context.read<ButtonProgressCubit>();
  log('reponse is state: $state');
  if (state is CreatetaskLoading) {
    button.startLoading();
  } else if (state is CreatetaskSuccess) {
    button.stopLoading();
      titleController.clear();
    descriptionController.clear();
    showSnackBar(
      context: context,
      message: "Task created successfully!",
      bgColor: AppPalette.green,
      icon: Icons.check_circle,
    );
  } else if (state is CreatetaskFailure) {
    button.stopLoading();
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text('Uploading Failed'),
        content: Text(state.error),
        actions: [
          CupertinoDialogAction(
            child: Text('Retry', style: TextStyle(color: AppPalette.red)),
            onPressed: () {
              Navigator.of(context).pop();
              context.read<CreatetaskBloc>().add(CreatetaskInitialEvent(
                titile: titleController.text.trim(),
                description: descriptionController.text.trim(),
              ));
            },
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Cancel',
              style: TextStyle(color: AppPalette.black),
            ),
          ),
        ],
      ),
    );
  }
}
