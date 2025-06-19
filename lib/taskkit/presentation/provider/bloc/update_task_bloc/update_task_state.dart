part of 'update_task_bloc.dart';

@immutable
abstract class UpdateTaskState {}

final class UpdateTaskInitial extends UpdateTaskState {}
final class UpdateTaskLoading extends UpdateTaskState {}
final class UpdateTaskSuccess extends UpdateTaskState {}
final class UpdateTaskFailure extends UpdateTaskState {}
