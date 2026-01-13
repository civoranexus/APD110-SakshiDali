import 'package:apd110_sakshidali/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.primaryTeal,
        title: const Text(
          'Alerts',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          AlertTile(
            icon: Icons.local_shipping_rounded,
            title: 'Order Dispatched',
            message: 'Your package has been dispatched successfully.',
            time: '2 mins ago',
          ),
          AlertTile(
            icon: Icons.check_circle_rounded,
            title: 'Delivery Completed',
            message: 'Order #MR1023 has been delivered.',
            time: '1 hour ago',
          ),
          AlertTile(
            icon: Icons.payment_rounded,
            title: 'Payment Successful',
            message: '₹450 payment received for your order.',
            time: 'Yesterday',
          ),
          AlertTile(
            icon: Icons.warning_amber_rounded,
            title: 'Delay Notice',
            message: 'Your order may be delayed due to weather.',
            time: '2 days ago',
          ),
        ],
      ),
    );
  }
}

class AlertTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String time;

  const AlertTile({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.8,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(14),

        leading: CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.primaryTeal.withOpacity(0.15),
          child: Icon(
            icon,
            color: AppColors.primaryTeal,
          ),
        ),

        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            message,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 13,
            ),
          ),
        ),

        trailing: Text(
          time,
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 11,
          ),
        ),
      ),
    );
  }
}
