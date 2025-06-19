 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todokit/taskkit/core/themes/app_colors.dart';
import 'package:todokit/taskkit/domain/usecase/date_convertion.dart';
import 'package:todokit/taskkit/core/common/common_date_timepicker.dart';
import 'package:todokit/taskkit/presentation/provider/cubit/pick_datetime_cubit.dart/pick_datetime_cubit.dart';

Row pickedDateAndTimeWidget({Timestamp? dateTime}) {
    return Row(
          children: [
            const Text('Pickup Date & Time:'),
            const SizedBox(width: 8),
            BlocBuilder<PickDatetimeCubit, PickDatetimeState>(
              builder: (context, state) {
                String displayDateTime = dateTime != null
                    ? '${formatDate(dateTime)} At ${formatTimeRange(dateTime)}'
                    : 'Tap to Choose';
                if (state is PickedDateTimeRange) {
                  final DateTime pickedDate = state.dateTimeRange;
                  final Timestamp converter = convertDateTimeToTimestamp(pickedDate);
                  displayDateTime = '${formatDate(converter)} At ${formatTimeRange(converter)}';
                }
                if (state is PickedDateTimeError) {
                  displayDateTime = state.error;
                }
                return InkWell(
                  onTap: () async {
                    final DateTime? picked = await showDateAndTime(context);
                    if (!context.mounted) return;
                    context.read<PickDatetimeCubit>().dateTImePicked(picked);
                  },
                  child: Text(
                    displayDateTime,
                    style: TextStyle(
                      color: AppPalette.blue,
                      decoration: TextDecoration.underline,
                      decorationColor: AppPalette.blue,
                    ),
                  ),
                );
              },
            ),
          ],
        );
  }