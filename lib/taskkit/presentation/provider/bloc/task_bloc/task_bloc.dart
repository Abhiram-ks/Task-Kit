import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todokit/taskkit/data/model/tasks_model.dart';
import 'package:todokit/taskkit/data/repository/task_repository.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository _repo = TaskRepository();
  TaskBloc() : super(TaskInitial()) {
    on<TaskEventRequest>(_fetchAllTaskState);
  }

  Future<void> _fetchAllTaskState(
    TaskEventRequest event,
    Emitter<TaskState> emit,
  ) async {
    emit(TaskLoading());
    try {
      await emit.forEach(
        _repo.streamTask(val:event.orderBy ), 
        onData:(tasks) {
          if (tasks.isEmpty) {
            return TaskEmpty(label: '');
          }else {
            return TaskSuccess(label: "All Todos", tasks: tasks);
          }
        },
        onError: (error, stackTrace) {
          return TaskFailure();
        },
      );
    } catch (e) {
      emit(TaskFailure());
    }
  }
}
