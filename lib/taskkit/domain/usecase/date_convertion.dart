
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String formatDate(Timestamp dateTime) {
  final dateFormat = DateFormat('dd MMM yyyy');
  return dateFormat.format(dateTime.toDate());
}

String formatTimeRange(Timestamp startTime) {
  final String time = DateFormat.jm().format(startTime.toDate());
  return time;
}
