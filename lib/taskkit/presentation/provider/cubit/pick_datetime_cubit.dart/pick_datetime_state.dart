part of 'pick_datetime_cubit.dart';

@immutable
abstract class PickDatetimeState {}

final class PickDatetimeInitial extends PickDatetimeState {}
final class PickedDateTimeRange extends PickDatetimeState {
  final DateTime dateTimeRange;

  PickedDateTimeRange(this.dateTimeRange);
}

final class PickedDateTimeError extends PickDatetimeState {
  final String error;
  PickedDateTimeError(this.error);
}