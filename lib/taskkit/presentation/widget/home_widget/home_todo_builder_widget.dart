
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todokit/taskkit/presentation/widget/home_widget/home_todo_cards_widget.dart';

import '../../../core/themes/app_colors.dart';
import '../../../domain/usecase/date_convertion.dart';
import '../../provider/bloc/task_bloc/task_bloc.dart';
import '../../screen/todo_data_screen/todo_data_screen.dart';

Widget todoBuilderCard(
  BuildContext context,
  double screenHeight,
  double screenWidth,
) {
  return RefreshIndicator(
    backgroundColor: AppPalette.white,
    color: AppPalette.blue,
    onRefresh: () async {
      context.read<TaskBloc>().add(TaskEventRequest(true));
    },
    child: BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: AppPalette.grey),
                SizedBox(height: screenHeight * .02),
                Text(
                  "Please wait a moment...",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Fetching data, your request is being processed.",
                  style: TextStyle(color: AppPalette.black),
                ),
              ],
            ),
          );
        } else if (state is TaskEmpty) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.news, color: AppPalette.grey, size: 50),
                Text(
                  "You don’t have any${state.label} tasks yet.",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Start adding tasks and manage your time effectively.",
                  style: TextStyle(color: AppPalette.black),
                ),
              ],
            ),
          );
        } else if (state is TaskSuccess) {
          final tasks = state.tasks;

          return ListView.separated(
            padding: EdgeInsets.symmetric(
              horizontal:
                  screenWidth > 600 ? screenWidth * .2 : screenWidth * 0.04,
              vertical: screenHeight * .02,
            ),
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];

              final showDateLabel =
                  index == 0 ||
                  formatDate(tasks[index - 1].createdAt) !=
                      formatDate(task.createdAt);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showDateLabel)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        formatDate(task.createdAt),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  TransactionCardsWalletWidget(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TodoDataScreen(isEdit: false, todoId: task.todoId)));
                    },
                    screenHeight: screenHeight,
                    title: task.title,
                    status: task.isCompleted ? 'Completed' : 'Pending',
                    statusIcon: task.isCompleted
                            ? Icons.check_circle
                            : Icons.pending_actions_rounded,
                    stusColor:task.isCompleted ? Colors.green : AppPalette.orengeClr,
                    id: task.todoId,
                    description: task.description,
                    isMarked: task.isCompleted,
                    dateTime: 'Duedate: ${formatDate(task.dateTime)} At ${formatTimeRange(task.dateTime)} ',
                  ),
                ],
              );
            },
            separatorBuilder: (_, __) => SizedBox(height: screenHeight * .005),
          );
        }
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.cloud_off_outlined, color: AppPalette.grey, size: 50),
              Text(
                "Oop's Unable to complete the request.",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Please try again later.',
                style: TextStyle(color: AppPalette.black),
              ),
              IconButton(
                onPressed: () {
                  context.read<TaskBloc>().add(TaskEventRequest(true));
                },
                icon: Icon(Icons.refresh_rounded),
              ),
            ],
          ),
        );
      },
    ),
  );
}