import 'package:cloud_firestore/cloud_firestore.dart';

class TasksModel {
  final String todoId;
  final String userId;
  final String title;
  final String description;
  final bool isCompleted;
  final Timestamp createdAt;
  final Timestamp updatedAt;
  final Timestamp dateTime;

  TasksModel({
    required this.todoId,
    required this.userId,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.createdAt,
    required this.updatedAt,
    required this.dateTime
  });

   factory TasksModel.fromMap(Map<String, dynamic> map) {
    return TasksModel(
      todoId: map['todoId'] ?? '', 
      userId: map['userId'] ?? '', 
      title: map['title'] ?? '', 
      description: map['description'] ?? '', 
      isCompleted: map['isCompleted'] ?? false, 
      dateTime: map['date_time'] ?? Timestamp.now(),
      createdAt: map['createdAt'] ?? Timestamp.now(),
      updatedAt: map['updatedAt'] ?? Timestamp.now());
   }

}