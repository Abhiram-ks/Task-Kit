import 'package:flutter/material.dart';
import 'package:todokit/taskkit/core/themes/app_colors.dart';

Future<DateTime?> showDateAndTime(BuildContext context) async {
  final DateTime? pickedDate = await showDatePicker(
    context:  context,
    firstDate: DateTime.now(),
    lastDate:  DateTime(2222),
    initialDate: DateTime.now(),
    builder: (BuildContext context, Widget? child) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ColorScheme.light(
          primary: AppPalette.button,        
          onPrimary: AppPalette.white,  
          onSurface: AppPalette.black,   
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
              if (states.contains(WidgetState.pressed)) {
                return AppPalette.button;
              }
              return  AppPalette.black; 
            }),
          ),
        ), dialogTheme: DialogThemeData(backgroundColor: AppPalette.white),
      ),
      child: child!,
    );
  },
  );

  if (pickedDate == null)  return null;

  final TimeOfDay? pickedTime = await showTimePicker(
    
    // ignore: use_build_context_synchronously
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (BuildContext context, Widget? child) {
    return Theme(
      data: Theme.of(context).copyWith(
        timePickerTheme: TimePickerThemeData(
          backgroundColor: AppPalette.white, 
          hourMinuteTextColor:AppPalette.black,
          hourMinuteColor: WidgetStateColor.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? Colors.blue.shade200
                : Colors.grey.shade200,
          ),
          dayPeriodTextColor: AppPalette.black,
          dialHandColor: AppPalette.button,
          dialBackgroundColor: AppPalette.white,
          entryModeIconColor: AppPalette.button,
          dialTextColor: WidgetStateColor.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? AppPalette.white
                :  AppPalette.black,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
              if (states.contains(WidgetState.pressed)) {
                return AppPalette.blue;
              }
              return AppPalette.black; 
            }),
          ),
        ),
      ),
      child: child!,
    );
  },
 );

   
    if (pickedTime == null) return null;

    return DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

}