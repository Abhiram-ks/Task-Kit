
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todokit/taskkit/presentation/screen/todo_data_screen/todo_data_screen.dart';

import '../../../core/themes/app_colors.dart';

class TransactionCardsWalletWidget extends StatelessWidget {
  final double screenHeight;
  final String title;
  final bool isMarked;
  final String status;
  final IconData statusIcon;
  final Color stusColor;
  final String id;
  final String description;

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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TodoDataScreen(isEdit: true, todoId: id)));
                      } else if (value == 'view') {
                         Navigator.push(context, MaterialPageRoute(builder: (context) => TodoDataScreen(isEdit: false, todoId: id)));
                      } else if (value == 'delete') {
                      } else if (value == 'Mark') {}
                    },
                    itemBuilder:
                        (context) => [
                          const PopupMenuItem(
                            value: 'mark',
                            child: Text('Mark'),
                          ),
                          const PopupMenuItem(
                            value: 'view',
                            child: Text('View'),
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
    );
  }
}