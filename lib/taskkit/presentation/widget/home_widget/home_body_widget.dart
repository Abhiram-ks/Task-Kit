

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todokit/taskkit/core/common/custom_textfiled_widget.dart';
import 'package:todokit/taskkit/core/themes/app_colors.dart';
import 'package:todokit/taskkit/presentation/widget/home_widget/home_todo_builder_widget.dart';
import '../../../core/utils/debouncer/debouncer.dart';
import '../../../core/validation/validation_helper.dart';
import '../../provider/bloc/task_bloc/task_bloc.dart';
import 'home_filter_function_widget.dart';

class HomeBodyWidget extends StatefulWidget {
  const HomeBodyWidget({super.key, required this.width, required this.height});

  final double width;
  final double height;

  @override
  State<HomeBodyWidget> createState() => _HomeBodyWidgetState();
}

class _HomeBodyWidgetState extends State<HomeBodyWidget> with FormFieldMixin {
  final TextEditingController _searchController = TextEditingController();
  final Debouncer _run = Debouncer(milliseconds: 250);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TaskBloc>().add(TaskEventRequest(true));
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _run.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                      onChanged: (query) {
                        _run.run(() {
                          context.read<TaskBloc>().add( TaskEventSearchingRequst(query));
                        });
                      },
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
                      color: AppPalette.white,
                      onSelected: (value) {
                        if (value == 'ascending') {
                          context.read<TaskBloc>().add(
                            TaskEventRequest(false),
                          );
                        } else if (value == 'descending') {
                          context.read<TaskBloc>().add(
                            TaskEventRequest(true),
                          );
                        }
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
              SizedBox(height: widget.height * .01),
            ],
          ),
        ),
        Expanded(
          child: todoBuilderCard(context, widget.height, widget.width),
        ),
      ],
    );
  }
}
