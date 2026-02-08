import 'package:apd110_sakshidali/features/orders/screens/track_orderPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userEmail = FirebaseAuth.instance.currentUser!.email;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('notifications')
            .where('receiverEmail', isEqualTo: userEmail)
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No notifications 📭"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final doc = snapshot.data!.docs[index];
              final data = doc.data() as Map<String, dynamic>;

              return Card(
                color: data['isRead']
                    ? Colors.white
                    : Colors.blue.shade50,
                child: ListTile(
                  leading: const Icon(Icons.notifications),
                  title: Text(
                    data['title'],
                    style: TextStyle(
                      fontWeight:
                          data['isRead'] ? FontWeight.normal : FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "${data['message']}\nPackage ID: ${data['packageId']}",
                  ),
                  trailing:
                      const Icon(Icons.arrow_forward_ios, size: 14),
                  onTap: () async {
                    await FirebaseFirestore.instance
                        .collection('notifications')
                        .doc(doc.id)
                        .update({"isRead": true});

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TrackOrderPage(
                          packageId: data['packageId'],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
