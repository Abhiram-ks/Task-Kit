import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

part 'mark_status_state.dart';

class MarkStatusCubit extends Cubit<MarkStatusState> {
  final FirebaseFirestore  _firestore = FirebaseFirestore.instance;

  MarkStatusCubit() : super(MarkStatusInitial());

  Future<void> updateStatus({
    required String todoId,
    required bool isCompleted,
  }) async {
    final taskRef = _firestore
      .collection('tasks')
      .doc(todoId);

      final bool isMark = isCompleted ? false : true;


     try {
       await taskRef.update({
        'isCompleted': isMark,
        'updatedAt': FieldValue.serverTimestamp(),
       });
       emit(MarkUpdateingSuccess());
     } catch (e) {
        emit(MarkUpdatingFailure());
     }
  }
}