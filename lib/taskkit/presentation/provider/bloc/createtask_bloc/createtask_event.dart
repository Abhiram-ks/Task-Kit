part of 'createtask_bloc.dart';

@immutable
abstract class CreatetaskEvent {}
final class CreatetaskInitialEvent extends CreatetaskEvent {
  final String titile;
  final String description;
  final DateTime dateTime;
  CreatetaskInitialEvent({
    required this.titile,
    required this.description,
    required this.dateTime,
  });
}
