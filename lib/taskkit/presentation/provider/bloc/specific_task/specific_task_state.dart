part of 'specific_task_bloc.dart';

@immutable
sealed class SpecificTaskState {}

final class SpecificTaskInitial extends SpecificTaskState {}
final class SpecificTaskLoading extends SpecificTaskState {}
final class SpecificTaskLoaded  extends SpecificTaskState {
  final TasksModel task;
  SpecificTaskLoaded(this.task);
}

final class SpecificTaskFailure extends SpecificTaskState {}
