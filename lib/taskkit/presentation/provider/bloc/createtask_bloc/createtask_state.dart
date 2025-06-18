part of 'createtask_bloc.dart';

@immutable
sealed class CreatetaskState {}

final class CreatetaskInitial extends CreatetaskState {}
final class CreatetaskLoading extends CreatetaskState {}
final class CreatetaskSuccess extends CreatetaskState {}
final class CreatetaskFailure extends CreatetaskState {
  final String error;

  CreatetaskFailure({required this.error});
}