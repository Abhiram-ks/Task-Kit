
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todokit/taskkit/data/datasource/createtask_remote_datasource.dart';
import 'package:todokit/taskkit/domain/usecase/date_convertion.dart';

part 'createtask_event.dart';
part 'createtask_state.dart';

class CreatetaskBloc extends Bloc<CreatetaskEvent, CreatetaskState> {
  final CreatetaskRemoteDatasource _createtaskRemoteDatasource = CreatetaskRemoteDatasource();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CreatetaskBloc() : super(CreatetaskInitial()) {
    on<CreatetaskInitialEvent>(_createTask);
  }

  Future<void> _createTask(  CreatetaskInitialEvent event, Emitter<CreatetaskState> emit) async {
    emit(CreatetaskLoading());
    try {
      final String? uid = _auth.currentUser?.uid;
      if (uid == null) {
        emit(CreatetaskFailure(error: "User not authenticated"));
        return;
      }
      
      final Timestamp dateTime = convertDateTimeToTimestamp(event.dateTime);
      final bool response = await _createtaskRemoteDatasource.createTask(
        title: event.titile,
        description: event.description,
        userId: uid,
        dateTime: dateTime,
      );
      if (response) {
        emit(CreatetaskSuccess());
      } else {
        emit(CreatetaskFailure(error: "Failed to create task"));
      }
    } catch (e) {
      emit(CreatetaskFailure(error: e.toString()));
    }
  }
}
