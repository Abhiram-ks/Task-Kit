import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
part 'pick_datetime_state.dart';

class PickDatetimeCubit extends Cubit<PickDatetimeState> {
  PickDatetimeCubit() : super(PickDatetimeInitial());

   void dateTImePicked(DateTime? dateTime) async {
    if (dateTime == null) {
      emit(PickedDateTimeError('Tap to Pick Date & Time'));
      return;
    }else{
      emit(PickedDateTimeRange(dateTime));
      return;
    }
   }
}
