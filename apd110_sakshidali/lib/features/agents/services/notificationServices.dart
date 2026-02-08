import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendPackageNotification({
    required String receiverId,
    required String senderId,
    required String senderName,
    required String packageId,
  }) async {
    await _firestore.collection('notifications').add({
      'receiverId': receiverId,
      'senderId': senderId,
      'senderName': senderName,
      'packageId': packageId,
      'message': '$senderName sent you a package',
      'timestamp': FieldValue.serverTimestamp(),
      'isRead': false,
    });
  }

  Future<void> markAsRead(String notificationId) async {
    await _firestore
        .collection('notifications')
        .doc(notificationId)
        .update({'isRead': true});
  }
}
