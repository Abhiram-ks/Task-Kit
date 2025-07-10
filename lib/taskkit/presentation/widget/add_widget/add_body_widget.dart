
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todokit/taskkit/core/common/custom_button_widget.dart';
import 'package:todokit/taskkit/core/common/custom_snackbar_widget.dart';
import 'package:todokit/taskkit/core/themes/app_colors.dart';
import 'package:todokit/taskkit/presentation/provider/bloc/createtask_bloc/createtask_bloc.dart';
import 'package:todokit/taskkit/presentation/provider/cubit/pick_datetime_cubit.dart/pick_datetime_cubit.dart';
import 'package:todokit/taskkit/presentation/widget/add_widget/date_time_picker_widget.dart';
import 'package:todokit/taskkit/presentation/widget/add_widget/handle_add_state.dart';

import '../../../core/common/custom_textfiled_widget.dart';
import '../../../core/validation/validation_helper.dart';

class AddTodoBodyWidget extends StatefulWidget {
  final double height;
  final double width;
  final GlobalKey<FormState> formKey;
  const AddTodoBodyWidget({
    super.key,
    required this.formKey,
    required this.height,
    required this.width,
  });

  @override
  State<AddTodoBodyWidget> createState() => _AddTodoBodyWidgetState();
}

class _AddTodoBodyWidgetState extends State<AddTodoBodyWidget>  with FormFieldMixin {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    DateTime? dateTime;
  @override
  Widget build(BuildContext context) {
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
            maxLine: 2,
          ),
          buildTextFormField(
            label: 'Task Description',
            hintText: "Enter description about task",
            prefixIcon: Icons.info_outline_rounded,
            context: context,
            controller: descriptionController,
            validate: ValidatorHelper.validateTaskDescription,
            height: widget.height,
            maxlength: 2000,
            maxLine: 6,
          ),
          SizedBox(height: widget.height * 0.01),
          pickedDateAndTimeWidget(dateTime: null),
          SizedBox(height: widget.height * 0.04),
          BlocListener<CreatetaskBloc, CreatetaskState>(
            listener: (context, state) {
              handleBlocListener(
                context: context,
                state: state,
                titleController: titleController,
                descriptionController: descriptionController,
                dateTime: dateTime ?? DateTime.now(), 
                formKey: widget.formKey
              );
            },
            child: ButtonComponents.actionButton(
              screenHeight: widget.height,
              screenWidth: widget.width,
              label: 'Create Task',
              onTap: () {
                final pickDatetimeState = context.read<PickDatetimeCubit>().state;
                if (pickDatetimeState is PickedDateTimeRange) {
                  dateTime = pickDatetimeState.dateTimeRange;
                }
                
                if (!widget.formKey.currentState!.validate() || dateTime == null) {
                
                  showSnackBar(
                    context: context,
                    message: "Oops! You missed some required fields. Please complete them before proceeding.",
                    bgColor: AppPalette.red,
                    icon: CupertinoIcons.clear_circled,
                  );
                  return;
                }
                BlocProvider.of<CreatetaskBloc>(context).add(
                  CreatetaskInitialEvent(
                    titile: titleController.text.trim(),
                    description: descriptionController.text.trim(),
                    dateTime: dateTime ?? DateTime.now(),
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
