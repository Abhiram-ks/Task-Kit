import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todokit/taskkit/data/model/tasks_model.dart';
import 'package:todokit/taskkit/data/repository/specific_task_repository.dart';
part 'specific_task_event.dart';
part 'specific_task_state.dart';

class SpecificTaskBloc extends Bloc<SpecificTaskEvent, SpecificTaskState> {
  final SpecificTaskRepository _repo = SpecificTaskRepository();
  SpecificTaskBloc() : super(SpecificTaskInitial()) {
    on<SpecificTaskRequest>(_todoTask);
  }


    Future<void> _todoTask(
    SpecificTaskRequest event,
    Emitter<SpecificTaskState> emit,
  ) async {
    emit(SpecificTaskLoading());
    try {
      await emit.forEach(
        _repo.streamTask(todoId:event.todoId ), 
        onData:(tasks) {
            return SpecificTaskLoaded(tasks);
        },
        onError: (error, stackTrace) {
          return SpecificTaskFailure();
        },
      );
    } catch (e) {
      emit(SpecificTaskFailure());
    }
  }
}
