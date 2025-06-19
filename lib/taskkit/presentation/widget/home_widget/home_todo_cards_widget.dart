import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todokit/taskkit/presentation/provider/cubit/mark_status_cubit/mark_status_cubit.dart';
import 'package:todokit/taskkit/presentation/screen/todo_data_screen/todo_data_screen.dart';
import 'package:todokit/taskkit/presentation/widget/todo_data_widget/handle_checkmark_state.dart';
import 'package:todokit/taskkit/presentation/widget/todo_data_widget/handle_delete_state.dart';

import '../../../core/themes/app_colors.dart';
import '../../provider/bloc/task_delete_bloc/task_delete_bloc.dart';

class TransactionCardsWalletWidget extends StatelessWidget {
  final double screenHeight;
  final String title;
  final bool isMarked;
  final String status;
  final IconData statusIcon;
  final VoidCallback onTap;
  final Color stusColor;
  final String id;
  final String description;
  final String dateTime;

  const TransactionCardsWalletWidget({
    super.key,
    required this.screenHeight,
    required this.title,
    required this.status,
    required this.statusIcon,
    required this.id,
    required this.stusColor,
    required this.description,
    required this.isMarked,
    required this.onTap,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MarkStatusCubit()),
        BlocProvider(create: (context) => TaskDeleteBloc()),
      ],
      child: Builder(
        builder: (context) {
          return GestureDetector(
            onTap: onTap,
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppPalette.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration:
                                isMarked ? TextDecoration.lineThrough : null,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        Text(
                          description,
                          style: TextStyle(
                            color: AppPalette.grey,
                            decoration:  isMarked ? TextDecoration.lineThrough : null,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),Text(
                          dateTime,
                          style: TextStyle(
                            color:AppPalette.grey,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          BlocListener<TaskDeleteBloc, TaskDeleteState>(
                            listener: (context, state) {
                              handleDeleteState(context: context, state: state, todoId: id, needPop: false);
                            },
                            child:
                                BlocListener<MarkStatusCubit, MarkStatusState>(
                                  listener: (context, state) {
                                    handleCheckMarkState(
                                      context: context,
                                      state: state,
                                      val: isMarked,
                                    );
                                  },
                                  child: PopupMenuButton<String>(
                                    icon: Icon(CupertinoIcons.bars),
                                    color: AppPalette.white,
                                    offset: const Offset(0, 35),
                                    padding: EdgeInsets.zero,
                                    onSelected: (value) {
                                      if (value == 'update') {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => TodoDataScreen(
                                                  isEdit: true,
                                                  todoId: id,
                                                ),
                                          ),
                                        );
                                      } else if (value == 'delete') {
                                        context.read<TaskDeleteBloc>().add(DeletetaskRequested());
                                      } else if (value == 'mark') {
                                        context .read<MarkStatusCubit>()
                                            .updateStatus(
                                              todoId: id,
                                              isCompleted: isMarked,
                                            );
                                      }
                                    },
                                    itemBuilder:
                                        (context) => [
                                          PopupMenuItem(
                                            value: 'mark',
                                            child: Text(
                                              isMarked
                                                  ? 'Pending'
                                                  : "Completed",
                                            ),
                                          ),
                                          const PopupMenuItem(
                                            value: 'update',
                                            child: Text('Update'),
                                          ),
                                          const PopupMenuItem(
                                            value: 'delete',
                                            child: Text('Delete'),
                                          ),
                                        ],
                                  ),
                                ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: stusColor.withAlpha((0.1 * 255).toInt()),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: stusColor),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(statusIcon, color: stusColor, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  status,
                                  style: TextStyle(
                                    color: stusColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
