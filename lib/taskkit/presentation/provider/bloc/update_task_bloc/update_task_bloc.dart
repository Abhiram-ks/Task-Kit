import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todokit/taskkit/domain/repository/update_task_repo.dart';

part 'update_task_event.dart';
part 'update_task_state.dart';

class UpdateTaskBloc extends Bloc<UpdateTaskEvent, UpdateTaskState> {
  final TaskUpdateRepository _repo = TaskUpdateRepository();
  UpdateTaskBloc() : super(UpdateTaskInitial()) {
    on<UpdateTaskRequest>((event, emit) async{
      emit(UpdateTaskLoading());
      try {
        final bool response = await _repo.taskUpdate(todoId: event.todoId, titile: event.title, description: event.description, dateTime: event.dateTime);

        if (response) {
          emit(UpdateTaskSuccess());
          return;
        }else{
           emit(UpdateTaskFailure());
           return;
        }
      } catch (e) {
        emit(UpdateTaskFailure());
      }
    });
  }
}
