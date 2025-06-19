
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todokit/taskkit/core/common/custom_snackbar_widget.dart';
import 'package:todokit/taskkit/presentation/provider/bloc/task_delete_bloc/task_delete_bloc.dart';
import 'package:todokit/taskkit/presentation/provider/bloc/update_task_bloc/update_task_bloc.dart';
import 'package:todokit/taskkit/presentation/provider/cubit/mark_status_cubit/mark_status_cubit.dart';
import 'package:todokit/taskkit/presentation/provider/cubit/pick_datetime_cubit.dart/pick_datetime_cubit.dart';
import 'package:todokit/taskkit/presentation/widget/add_widget/date_time_picker_widget.dart';
import 'package:todokit/taskkit/presentation/widget/todo_data_widget/handle_checkmark_state.dart';
import 'package:todokit/taskkit/presentation/widget/todo_data_widget/handle_delete_state.dart';
import 'package:todokit/taskkit/presentation/widget/todo_data_widget/handle_update_state.dart';
import 'package:todokit/taskkit/presentation/widget/todo_data_widget/todo_custom_action_button.dart';

import '../../../core/common/custom_button_widget.dart';
import '../../../core/common/custom_textfiled_widget.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/validation/validation_helper.dart';
import '../../../data/model/tasks_model.dart';
import '../../../domain/usecase/date_convertion.dart';

class TodoDataSuccessWIdget extends StatelessWidget  with FormFieldMixin {
  final bool isEdit;
  final double height;
  final double width;
  final TextEditingController textEditingController;
  final TextEditingController descriptionController;
  final TasksModel todo;
   final GlobalKey<FormState> formKey;

  const TodoDataSuccessWIdget({super.key, required this.isEdit, required this.height, required this.width, required this.textEditingController, required this.descriptionController, required this.todo, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isEdit)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Task Title'),
                    Text(todo.title, style: TextStyle(color: AppPalette.grey)),
                    SizedBox(height: height * .02),
                    Text('Task Description'),
                    Text(
                      todo.description,
                      style: TextStyle(color: AppPalette.grey),
                    ),
                    SizedBox(height: height * .03),
                  ],
                ),
              if (isEdit)
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      buildTextFormField(
                        label: 'Task Title',
                        hintText: "Enter a short description about the task",
                        prefixIcon: Icons.add_task_rounded,
                        context: context,
                        controller: textEditingController,
                        validate: ValidatorHelper.validateTaskTitle,
                        height: height,
                        enabled: isEdit,
                        maxlength: isEdit ? 80 : null,
                        maxLine: 2,
                      ),

                      buildTextFormField(
                        label: 'Task Description',
                        hintText: "Enter description about task",
                        prefixIcon: Icons.info_outline_rounded,
                        context: context,
                        controller: descriptionController,
                        validate: ValidatorHelper.validateTaskDescription,
                        height: height,
                        enabled: isEdit,
                        maxlength: isEdit ? 2000 : null,
                        maxLine: 6,
                      ),
                    ],
                  ),
                ),
              if (!isEdit)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Created At : '),
                        Text(
                          '${formatDate(todo.createdAt)} At ${formatTimeRange(todo.createdAt)}',
                          style: TextStyle(color: AppPalette.grey),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Updated At : '),
                        Text(
                          '${formatDate(todo.updatedAt)} At ${formatTimeRange(todo.updatedAt)}',
                          style: TextStyle(color: AppPalette.grey),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Due date At: '),
                        Text(
                          '${formatDate(todo.dateTime)} At ${formatTimeRange(todo.dateTime)}',
                          style: TextStyle(color: AppPalette.grey),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Task Status: '),
                        Text(
                          todo.isCompleted ? 'Completed' : 'Pending',
                          style: TextStyle(
                            color:
                                todo.isCompleted
                                    ? AppPalette.green
                                    : AppPalette.orengeClr,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              SizedBox(height: height * 0.02),
              if (isEdit)
                pickedDateAndTimeWidget(dateTime: todo.dateTime),
              SizedBox(height: height * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * .02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    detailsPageActions(
                      context: context,
                      screenWidth: width,
                      icon: Icons.subdirectory_arrow_left_sharp,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      text: 'Go Back',
                    ),
                    BlocListener<TaskDeleteBloc, TaskDeleteState>(
                      listener: (context, state) {
                        handleDeleteState(
                          context: context,
                          state: state,
                          todoId: todo.todoId,
                          needPop: true,
                        );
                      },
                      child: detailsPageActions(
                        context: context,
                        screenWidth: width,
                        icon: Icons.delete_sweep_rounded,
                        onTap: () {
                          context.read<TaskDeleteBloc>().add(
                            DeletetaskRequested(),
                          );
                        },
                        text: 'Delete',
                      ),
                    ),

                    BlocListener<MarkStatusCubit, MarkStatusState>(
                      listener: (context, state) {
                        handleCheckMarkState(
                          context: context,
                          state: state,
                          val: todo.isCompleted,
                        );
                      },
                      child: detailsPageActions(
                        context: context,
                        colors: Color.fromARGB(255, 67, 142, 254),
                        screenWidth: width,
                        icon:
                            todo.isCompleted
                                ? Icons.check_box
                                : Icons.check_box_outline_blank_outlined,
                        onTap: () {
                          context.read<MarkStatusCubit>().updateStatus(
                            todoId: todo.todoId,
                            isCompleted: todo.isCompleted,
                          );
                        },
                        text: 'Mark Update',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * .02),
              if (isEdit)
                BlocListener<UpdateTaskBloc, UpdateTaskState>(
                  listener: (context, state) {
                    handleUpdateState(context: context, state: state);
                  },
                  child: ButtonComponents.actionButton(
                    screenHeight: height,
                    screenWidth: width,
                    label: 'Update Task',
                    onTap: () {
                      final currentState = context.read<PickDatetimeCubit>().state;
                      Timestamp dateTime = todo.dateTime;
                      if (!formKey.currentState!.validate() ||
                          currentState is PickedDateTimeError) {
                        showSnackBar(
                          context: context,
                          message:
                              "Oops! You missed some required fields. Please complete them before proceeding.",
                          bgColor: AppPalette.red,
                          icon: CupertinoIcons.clear_circled,
                        );
                        return;
                      }

                      if (currentState is PickedDateTimeRange) {
                        final Timestamp converter = convertDateTimeToTimestamp(
                          currentState.dateTimeRange,
                        );
                        dateTime = converter;
                      }

                      context.read<UpdateTaskBloc>().add(
                        UpdateTaskRequest(
                          todoId: todo.todoId,
                          description: descriptionController.text.trim(),
                          title: textEditingController.text.trim(),
                          dateTime: dateTime,
                        ),
                      );
                    },
                  ),
                ),
            ],
          );
  }
}
