
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todokit/taskkit/core/themes/app_colors.dart';
import 'package:todokit/taskkit/presentation/provider/bloc/specific_task/specific_task_bloc.dart';
import 'package:todokit/taskkit/presentation/widget/todo_data_widget/tododata_success_widget.dart';

class TodoDataBodyWidget extends StatefulWidget {
  final String todoId;
  final bool isEdit;
  final double height;
  final double widget;
  final GlobalKey<FormState> formKey;

  const TodoDataBodyWidget({
    super.key,
    required this.todoId,
    required this.isEdit,
    required this.height,
    required this.widget,
    required this.formKey,
  });

  @override
  State<TodoDataBodyWidget> createState() => _TodoDataBodyWidgetState();
}

class _TodoDataBodyWidgetState extends State<TodoDataBodyWidget>
   {
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
  Widget build(BuildContext context) {
    return BlocBuilder<SpecificTaskBloc, SpecificTaskState>(
      builder: (context, state) {
        if (state is SpecificTaskLoaded) {
          final todo = state.task;
          _textEditingController.text = todo.title;
          _descriptionController.text = todo.description;

          return TodoDataSuccessWIdget(isEdit: widget.isEdit, height: widget.height, width: widget.widget, textEditingController: _textEditingController, descriptionController: _descriptionController, todo: todo,formKey: widget.formKey,);
        }

        if (state is SpecificTaskFailure) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: widget.height * .05),
                Icon(
                  Icons.cloud_off_outlined,
                  color: AppPalette.black,
                  size: 50,
                ),
                Text("Oop's Unable to complete the request."),
                Text('Please try again later.'),
                IconButton(
                  onPressed: () {
                    context.read<SpecificTaskBloc>().add(
                      SpecificTaskRequest(widget.todoId),
                    );
                  },
                  icon: Icon(Icons.refresh_rounded),
                ),
              ],
            ),
          );
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: widget.height * .05),
              CircularProgressIndicator(color: AppPalette.grey),
              SizedBox(height: widget.height * .01),
              Text("Please wait a moment..."),
              Text("Your request is being processed."),
            ],
          ),
        );
      },
    );
  }
}
