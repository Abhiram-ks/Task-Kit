part of 'task_delete_bloc.dart';

@immutable
abstract class TaskDeleteEvent {}
final class DeletetaskRequested extends TaskDeleteEvent {
 
}

final class DeletetaskProced extends TaskDeleteEvent {
   final String todoId;
  DeletetaskProced(this.todoId);
}