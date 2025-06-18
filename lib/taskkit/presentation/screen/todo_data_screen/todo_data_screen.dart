import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todokit/taskkit/core/common/custom_appbar_widget.dart';
import 'package:todokit/taskkit/core/common/custom_button_widget.dart';
import 'package:todokit/taskkit/core/common/custom_snackbar_widget.dart';
import 'package:todokit/taskkit/core/common/custom_textfiled_widget.dart';
import 'package:todokit/taskkit/core/themes/app_colors.dart' show AppPalette;
import 'package:todokit/taskkit/domain/usecase/date_convertion.dart';
import 'package:todokit/taskkit/presentation/provider/bloc/specific_task/specific_task_bloc.dart';
import 'package:todokit/taskkit/presentation/provider/cubit/cubit/mark_status_cubit.dart';
import 'package:todokit/taskkit/presentation/widget/todo_data_widget/todo_custom_action_button.dart';

import '../../../core/validation/validation_helper.dart';

class TodoDataScreen extends StatelessWidget {
  final bool isEdit;
  final String todoId;
  const TodoDataScreen({super.key, required this.isEdit, required this.todoId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SpecificTaskBloc()),
        BlocProvider(create: (context) => MarkStatusCubit()),
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

class TodoDataBodyWidget extends StatefulWidget {
  final String todoId;
  final bool isEdit;
  final double height;
  final double widget;

  const TodoDataBodyWidget({
    super.key,
    required this.todoId,
    required this.isEdit,
    required this.height,
    required this.widget,
  });

  @override
  State<TodoDataBodyWidget> createState() => _TodoDataBodyWidgetState();
}

class _TodoDataBodyWidgetState extends State<TodoDataBodyWidget>
    with FormFieldMixin {
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SpecificTaskBloc>().add(SpecificTaskRequest(widget.todoId));
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpecificTaskBloc, SpecificTaskState>(
      builder: (context, state) {
        if (state is SpecificTaskLoaded) {
          final todo = state.task;
          _textEditingController.text = todo.title;
          _descriptionController.text = todo.description;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextFormField(
                label: 'Task Title',
                hintText: "Enter a short description about the task",
                prefixIcon: Icons.add_task_rounded,
                context: context,
                controller: _textEditingController,
                validate: ValidatorHelper.validateTaskTitle,
                height: widget.height,
                enabled: widget.isEdit,
                maxlength: widget.isEdit ? 80 : null,
                maxLine: 2,
              ),
              buildTextFormField(
                label: 'Task Description',
                hintText: "Enter description about task",
                prefixIcon: Icons.info_outline_rounded,
                context: context,
                controller: _descriptionController,
                validate: ValidatorHelper.validateTaskDescription,
                height: widget.height,
                enabled: widget.isEdit,
                maxlength: widget.isEdit ? 2000 : null,
                maxLine: 6,
              ),
              SizedBox(height: widget.height * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: widget.widget * .02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    detailsPageActions(
                      context: context,
                      screenWidth: widget.widget,
                      icon: Icons.subdirectory_arrow_left_sharp,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      text: 'Go Back',
                    ),
                    detailsPageActions(
                      context: context,
                      screenWidth: widget.widget,
                      icon: Icons.delete_sweep_rounded,
                      onTap: () {},
                      text: 'Delete',
                    ),

                    BlocListener<MarkStatusCubit, MarkStatusState>(
                      listener: (context, state) {
                      handleCheckMarkState(context: context, state: state, val: todo.isCompleted);
                      },
                      child: detailsPageActions(
                        context: context,
                        colors:
                            todo.isCompleted
                                ? AppPalette.black
                                : Color.fromARGB(255, 67, 142, 254),
                        screenWidth: widget.widget,
                        icon: Icons.check_box,
                        onTap: () {
                          context.read<MarkStatusCubit>().updateStatus(todoId: todo.todoId, isCompleted: todo.isCompleted);
                        },
                        text: 'Mark Update',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: widget.height * .02),
              if (widget.isEdit)
                ButtonComponents.actionButton(
                  screenHeight: widget.height,
                  screenWidth: widget.widget,
                  label: 'Update Task',
                  onTap: () {},
                ),
              if (!widget.isEdit)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Created At : ${formatDate(todo.createdAt)} At ${formatTimeRange(todo.createdAt)}',
                    ),
                    Text(
                      'Updated At : ${formatDate(todo.updatedAt)} At ${formatTimeRange(todo.updatedAt)}',
                    ),
                    Text(
                      'Task Status: ${todo.isCompleted ? 'Completed' : 'Pending'}',
                    ),
                  ],
                ),
            ],
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}


void handleCheckMarkState({required BuildContext context,required MarkStatusState state,required bool val}) {

  if (state is MarkUpdateingSuccess) {
    showSnackBar(bgColor:val ? AppPalette.green : AppPalette.orengeClr,message: 'Task Status Update successful!', context: context, icon: val ? Icons.check_circle_outline_sharp : Icons.pending_actions_rounded   );

  } else if (state is MarkUpdatingFailure){
     showSnackBar(bgColor: AppPalette.red,message: 'Task Status Update Failure!', context: context, icon: CupertinoIcons.clear_circled);
  }

 
}