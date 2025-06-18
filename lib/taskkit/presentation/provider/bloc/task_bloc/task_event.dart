part of 'task_bloc.dart';

@immutable
abstract class TaskEvent {}

final class TaskEventRequest extends TaskEvent {
  final bool orderBy;
  TaskEventRequest(this.orderBy);
}

final class TaskEventFilterRequest extends TaskEvent {
  final bool isCompleted;
  TaskEventFilterRequest(this.isCompleted);
}

final class TaskEventSearchingRequst extends TaskEvent {
  final String searchQuary;
  TaskEventSearchingRequst(this.searchQuary);
}