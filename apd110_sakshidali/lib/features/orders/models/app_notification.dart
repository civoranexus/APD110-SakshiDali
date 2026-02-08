import 'package:cloud_firestore/cloud_firestore.dart';

class AppNotification {
  final String id;
  final String senderName;
  final String message;
  final String packageId;
  final bool isRead;
  final Timestamp timestamp;

  AppNotification({
    required this.id,
    required this.senderName,
    required this.message,
    required this.packageId,
    required this.isRead,
    required this.timestamp,
  });

  factory AppNotification.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AppNotification(
      id: doc.id,
      senderName: data['senderName'],
      message: data['message'],
      packageId: data['packageId'],
      isRead: data['isRead'],
      timestamp: data['timestamp'],
    );
  }
}
