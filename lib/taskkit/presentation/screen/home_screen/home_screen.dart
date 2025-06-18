import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todokit/taskkit/core/common/custom_appbar_widget.dart';
import 'package:todokit/taskkit/core/common/custom_textfiled_widget.dart';
import 'package:todokit/taskkit/core/validation/validation_helper.dart';
import 'package:todokit/taskkit/presentation/provider/bloc/task_bloc/task_bloc.dart';
import 'package:todokit/taskkit/presentation/provider/cubit/logout_cubit/logout_cubit.dart';
import 'package:todokit/taskkit/presentation/screen/add_screen/add_todo_screen.dart';
import 'package:todokit/taskkit/presentation/screen/login_screen/login_screen.dart';
import 'package:todokit/taskkit/presentation/widget/home_widget/home_filter_function_widget.dart';

import '../../../core/themes/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LogoutCubit()),
        BlocProvider(create: (context) => TaskBloc()),
      ],
      child: LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;
          double height = constraints.maxHeight;

          return BlocListener<LogoutCubit, LogoutState>(
            listener: (context, state) {
              handleLogoutState(context: context, state: state);
            },
            child: Scaffold(
              appBar: CustomAppBar(
                title: 'Log Out',
                titleColor: AppPalette.black,
                onPressed: () {
                  context.read<LogoutCubit>().logoutConfirmation();
                },
              ),
              body: HomeBodyWidget(width: width, height: height),

              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddTodoScreen(isEdit: false),
                    ),
                  );
                },
                backgroundColor: AppPalette.button,
                child: Icon(Icons.add_task_sharp, color: AppPalette.white),
              ),
            ),
          );
        },
      ),
    );
  }
}

class HomeBodyWidget extends StatefulWidget {
  const HomeBodyWidget({super.key, required this.width, required this.height});

  final double width;
  final double height;

  @override
  State<HomeBodyWidget> createState() => _HomeBodyWidgetState();
}

class _HomeBodyWidgetState extends State<HomeBodyWidget> with FormFieldMixin {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TaskBloc>().add(TaskEventRequest(true));
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal:
                  widget.width > 600 ? widget.width * .3 : widget.width * 0.05,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: buildTextFormField(
                        isLabel: false,
                        hintText: 'Search Your Task...',
                        prefixIcon: CupertinoIcons.search,
                        context: context,
                        controller: _searchController,
                        validate: ValidatorHelper.serching,
                        height: widget.height,
                      ),
                    ),
                    const SizedBox(width: 7),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppPalette.button,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: PopupMenuButton<String>(
                        icon: Icon(
                          CupertinoIcons.slider_horizontal_3,
                          color: AppPalette.white,
                        ),
                        color: Colors.white,
                        onSelected: (value) {
                          if (value == 'ascending') {
                          } else if (value == 'descending') {}
                        },
                        itemBuilder:
                            (context) => [
                              PopupMenuItem(
                                value: 'ascending',
                                child: Text('Ascending'),
                              ),
                              PopupMenuItem(
                                value: 'descending',
                                child: Text('Descending'),
                              ),
                            ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: widget.height * .01),
                MyActivityFilteringCards(
                  screenWidth: widget.width,
                  screenHeight: widget.height,
                ),
                SizedBox(height: widget.height * .03),
              ],
            ),
          ),
          Expanded(
            child: todoBuilderCard(context, widget.height, widget.width),
          ),
        ],
      ),
    );
  }
}

RefreshIndicator todoBuilderCard(
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
    child: SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth > 600 ? screenWidth * .2 : screenWidth * 0.04,
        ),
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TaskSuccess) {
              final length = state.tasks.length;
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Text('${state.label}: $length'),
                 ListView.separated(
                  itemCount: length,
                  itemBuilder: (context, index) {
                    final task = state.tasks[index];
                    final bool showDateLabel = index == 0 ||
                      (state.tasks[index-1].createdAt is DateTime && task.createdAt is DateTime
                        ? (state.tasks[index-1].createdAt as DateTime).day != (task.createdAt as DateTime).day
                        : (state.tasks[index-1].createdAt.toDate().day != task.createdAt.toDate().day));

                    return Column(
                      children: [
                        if(showDateLabel)
                        Text()
                      ],
                    );
                  } , 
                  separatorBuilder: (context, index) => SizedBox(height:screenHeight * .01,), 
                  )
                ],
              );
            }
            return Column(
              children: [
                TransactionCardsWalletWidget(
                  screenHeight: screenHeight,
                  title: 'Revise and Polish Resume for Job Applications',
                  status: 'Pending',
                  statusIcon: Icons.pending,
                  id: '',
                  stusColor: AppPalette.orengeClr,
                  dateTime: '1212024',
                  method: 'onlune',
                  description:
                      'Update your resume to highlight your latest skills, projects, and accomplishments. Tailor it to match current job opportunities, ensuring clarity, strong action words, and a clean design. A well-crafted resume increases your chances of getting noticed by recruiters.',
                  isMarked: true,
                ),
              ],
            );
          },
        ),
      ),
    ),
  );
}

class TransactionCardsWalletWidget extends StatelessWidget {
  final double screenHeight;
  final String title;
  final bool isMarked;
  final String status;
  final IconData statusIcon;
  final Color stusColor;
  final String id;
  final String dateTime;
  final String method;
  final String description;

  const TransactionCardsWalletWidget({
    super.key,
    required this.screenHeight,
    required this.title,
    required this.status,
    required this.statusIcon,
    required this.id,
    required this.stusColor,
    required this.dateTime,
    required this.method,
    required this.description,
    required this.isMarked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    decoration: isMarked ? TextDecoration.lineThrough : null,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                Text(
                  description,
                  style: TextStyle(
                    color: AppPalette.grey,
                    decoration: isMarked ? TextDecoration.lineThrough : null,
                  ),
                  maxLines: 2,
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
                  PopupMenuButton<String>(
                    icon: Icon(CupertinoIcons.bars),
                    color: AppPalette.white,
                    offset: const Offset(0, 35),
                    padding: EdgeInsets.zero,
                    onSelected: (value) {
                      if (value == 'update') {
                      } else if (value == 'view') {
                      } else if (value == 'delete') {
                      } else if (value == 'Mark') {}
                    },
                    itemBuilder:
                        (context) => [
                          const PopupMenuItem(
                            value: 'update',
                            child: Text('Update'),
                          ),
                          const PopupMenuItem(
                            value: 'view',
                            child: Text('View'),
                          ),
                          const PopupMenuItem(
                            value: 'delete',
                            child: Text('Delete'),
                          ),
                          const PopupMenuItem(
                            value: 'mark',
                            child: Text('Mark'),
                          ),
                        ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: stusColor.withOpacity(0.1),
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
    );
  }
}

void handleLogoutState({
  required BuildContext context,
  required LogoutState state,
}) {
  if (state is LogoutSuccess) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Loginscreen()),
      (route) => false,
    );
  } else if (state is LogoutConfirmation) {
    showCupertinoModalPopup(
      context: context,
      builder:
          (_) => CupertinoActionSheet(
            title: const Text(
              'Are you sure?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            message: const Text(
              'Do you really want to log out of your account? You will need to log in again to access your tasks.',
            ),
            actions: [
              CupertinoActionSheetAction(
                onPressed: () {
                  context.read<LogoutCubit>().logOut();
                },
                isDestructiveAction: true,
                child: const Text(
                  'Yes, Log Out',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 15, color: AppPalette.black),
              ),
            ),
          ),
    );
  } else if (state is Logoutfailure) {
    showCupertinoDialog(
      context: context,
      builder:
          (_) => CupertinoAlertDialog(
            title: Text('Logout Failed'),
            content: Text(state.errorMessage),
            actions: [
              CupertinoDialogAction(
                child: Text('Retry', style: TextStyle(color: AppPalette.red)),
                onPressed: () {
                  Navigator.of(context).pop();
                  context.read<LogoutCubit>().logOut();
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
  } else if (state is LogoutLoading) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => Center(
            child: CircularProgressIndicator(color: AppPalette.button),
          ),
    );
  } else {
    Navigator.pop(context);
  }
}
