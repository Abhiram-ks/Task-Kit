part of 'task_delete_bloc.dart';

@immutable
abstract class TaskDeleteState {}

final class TaskDeleteInitial extends TaskDeleteState {}
final class TaskDeleteConfirmation extends TaskDeleteState {}
final class TaskDeleteLoading extends TaskDeleteState {}
final class TaskDeleteSuccess extends TaskDeleteState {}
final class TaskDeleteFailure extends TaskDeleteState {}
