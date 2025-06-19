part of 'update_task_bloc.dart';

@immutable
abstract class UpdateTaskEvent {}

final class UpdateTaskRequest extends UpdateTaskEvent{
  final String todoId;
  final String title;
  final String description;
  final Timestamp dateTime;

  UpdateTaskRequest({required this.todoId, required this.description, required this.title, required this.dateTime});
}
