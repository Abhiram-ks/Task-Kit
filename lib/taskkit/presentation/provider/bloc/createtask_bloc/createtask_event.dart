part of 'createtask_bloc.dart';

@immutable
abstract class CreatetaskEvent {}
final class CreatetaskInitialEvent extends CreatetaskEvent {
  final String titile;
  final String description;

  CreatetaskInitialEvent({
    required this.titile,
    required this.description,
  });
}
