import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todokit/taskkit/core/common/custom_appbar_widget.dart';

class AddTodoScreen extends StatelessWidget {
  final bool isEdit;
  final String? todoId;
  const AddTodoScreen({super.key,required this.isEdit, this.todoId});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
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
                        isEdit ? 'Refine Your Task' :'Organize Your Day',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    SizedBox(height: height * 0.01),
                    Text(
                       isEdit ?"Stay ahead by keeping your task details up to date. Small updates today lead to greater success tomorrow." : "Every great achievement begins with a task. Create yours, take action, and move one step closer to success."
                       
                      ),
                      SizedBox(height: height * 0.03),
                      AddTodoBodyWidget(isEdit: isEdit, todoId: todoId)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}



class AddTodoBodyWidget extends StatefulWidget {
  final bool isEdit;
  final String? todoId;
  const AddTodoBodyWidget({super.key, required this.isEdit, this.todoId});

  @override
  State<AddTodoBodyWidget> createState() => _AddTodoBodyWidgetState();
}

class _AddTodoBodyWidgetState extends State<AddTodoBodyWidget> with m{
  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: titleController,
          decoration: InputDecoration(
            labelText: 'Task Title',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
        TextField(
          controller: descriptionController,
          maxLines: 5,
          decoration: InputDecoration(
            labelText: 'Task Description',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            // Handle save action
            if (widget.isEdit) {
              // Update existing task
            } else {
              // Create new task
            }
          },
          child: Text(widget.isEdit ? 'Update Task' : 'Create Task'),
        ),
      ],
    );
  }
}