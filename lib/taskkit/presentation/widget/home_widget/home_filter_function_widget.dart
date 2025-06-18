import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todokit/taskkit/presentation/provider/bloc/task_bloc/task_bloc.dart';
import 'package:todokit/taskkit/presentation/widget/home_widget/home_fileter_customcard.dart';

import '../../../core/themes/app_colors.dart';

class MyActivityFilteringCards extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const MyActivityFilteringCards({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight * 0.042,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            MyFilteringCards(
              widgth: screenWidth,
              label: 'All Todos',
              icon: Icons.history_rounded,
              colors: Colors.black,
              onTap: () {
               context.read<TaskBloc>().add(TaskEventRequest(true));
              },
            ),
            VerticalDivider(color: AppPalette.hint),
            MyFilteringCards(
               widgth: screenWidth,
              label: 'Pending',
              icon: Icons.pending_actions_rounded,
              colors: AppPalette.orengeClr,
              onTap: () {
                 context.read<TaskBloc>().add(TaskEventFilterRequest(false));
              },
            ),
            VerticalDivider(color: AppPalette.hint),
            MyFilteringCards(
               widgth: screenWidth,
              label: 'Completed',
              icon: Icons.check_circle_outline_sharp,
              colors: Colors.green,
              onTap: () {
              context.read<TaskBloc>().add(TaskEventFilterRequest(true));
              },
            ),
          
          ],
        ),
      ),
    );
  }
}
