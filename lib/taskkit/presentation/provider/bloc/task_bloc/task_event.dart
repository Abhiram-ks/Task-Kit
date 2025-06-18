part of 'task_bloc.dart';

@immutable
abstract class TaskEvent {}

final class TaskEventRequest extends TaskEvent {
  final bool orderBy;
  TaskEventRequest(this.orderBy);
}
