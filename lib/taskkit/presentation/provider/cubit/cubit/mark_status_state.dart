part of 'mark_status_cubit.dart';

@immutable
sealed class MarkStatusState {}

final class MarkStatusInitial extends MarkStatusState {}
final class MarkUpdateingSuccess extends MarkStatusState{}
final class MarkUpdatingFailure  extends MarkStatusState{}
