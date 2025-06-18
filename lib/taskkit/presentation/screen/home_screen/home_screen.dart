
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todokit/taskkit/core/common/custom_appbar_widget.dart';
import 'package:todokit/taskkit/presentation/provider/bloc/task_bloc/task_bloc.dart';
import 'package:todokit/taskkit/presentation/provider/cubit/logout_cubit/logout_cubit.dart';
import 'package:todokit/taskkit/presentation/screen/add_screen/add_todo_screen.dart';
import 'package:todokit/taskkit/presentation/widget/home_widget/handle_logout_state.dart';
import 'package:todokit/taskkit/presentation/widget/home_widget/home_body_widget.dart';
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
                      builder: (context) => AddTodoScreen(),
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



