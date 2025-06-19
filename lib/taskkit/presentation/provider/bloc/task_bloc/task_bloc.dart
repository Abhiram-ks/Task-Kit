
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todokit/taskkit/data/model/tasks_model.dart';
import 'package:todokit/taskkit/data/repository/task_filter_repository.dart';
import 'package:todokit/taskkit/data/repository/task_repository.dart';
import 'package:todokit/taskkit/data/repository/task_searchquary_repository.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TaskRepository _repo = TaskRepository();
  final TaskFileterRepository _filter = TaskFileterRepository();
  final TaskSearchquaryRepository _search = TaskSearchquaryRepository();
  TaskBloc() : super(TaskInitial()) {
    on<TaskEventRequest>(_fetchAllTaskState);
    on<TaskEventFilterRequest>(_fetchFilterTaskState); 
    on<TaskEventSearchingRequst>(_searchQuary); 
  }

  Future<void> _fetchAllTaskState(
    TaskEventRequest event,
    Emitter<TaskState> emit,
  ) async {
    emit(TaskLoading());
    try {
      final String userId = _auth.currentUser?.uid ?? '';
      if (userId.isEmpty) {
        emit(TaskFailure());
        return;
      }
      await emit.forEach(
        _repo.streamTask(val:event.orderBy,userId: userId ), 
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


  Future<void> _fetchFilterTaskState(
    TaskEventFilterRequest event,
    Emitter<TaskState> emit,
  ) async {
    emit(TaskLoading());
    try {
      final String userId = _auth.currentUser?.uid ?? '';
      if (userId.isEmpty) {
        emit(TaskFailure());
        return;
      }
      await emit.forEach(
        _filter.streamTask(val:event.isCompleted, userId:  userId), 
        onData:(tasks) {
          if (tasks.isEmpty) {
            return TaskEmpty(label: event.isCompleted ? ' Completed' : ' Pending');
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

  
  Future<void> _searchQuary(
    TaskEventSearchingRequst event,
    Emitter<TaskState> emit,
  ) async {
    emit(TaskLoading());
    try {
        final String userId = _auth.currentUser?.uid ?? '';
      if (userId.isEmpty) {
        emit(TaskFailure());
        return;
      }
      await emit.forEach(
        _search.streamTask(query:event.searchQuary.toLowerCase(), userId: userId), 
        onData:(tasks) {
          if (tasks.isEmpty) {
            return TaskEmpty(label:' ');
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
