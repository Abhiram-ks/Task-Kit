
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todokit/taskkit/domain/repository/delete_request_repo.dart';
part 'task_delete_event.dart';
part 'task_delete_state.dart';

class TaskDeleteBloc extends Bloc<TaskDeleteEvent, TaskDeleteState> {
  final DeleteRequestRepository _repo = DeleteRequestRepository();
  TaskDeleteBloc() : super(TaskDeleteInitial()) {
    on<DeletetaskRequested>((event, emit) {
      emit(TaskDeleteConfirmation());
    });

    on<DeletetaskProced>((event, emit)async {
      emit(TaskDeleteLoading());
      try {
          final bool response = await _repo.taskDelete(todoId: event.todoId);
          
          if(response){
            emit(TaskDeleteSuccess());
            return;
          }else {
            emit(TaskDeleteFailure());
            return;
          }
      } catch (e) {
        emit(TaskDeleteFailure());
      }
    });
  }
}
