part of 'task_bloc.dart';

@immutable
sealed class TaskState {}

final class TaskInitial extends TaskState {}

final class TaskLoading extends TaskState {}

final class TaskEmpty extends TaskState {
  final String label;
  TaskEmpty({required this.label});
}

final class TaskSuccess extends TaskState {
  final String label;
  final List<TasksModel> tasks;
  TaskSuccess({required this.label, required this.tasks});
}

final class TaskFailure extends TaskState {}
