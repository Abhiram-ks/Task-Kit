part of 'specific_task_bloc.dart';

@immutable
abstract class SpecificTaskEvent {}

final class SpecificTaskRequest extends SpecificTaskEvent{
  final String todoId;
  SpecificTaskRequest(this.todoId);
}
