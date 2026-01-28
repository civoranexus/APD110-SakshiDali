import 'package:flutter/material.dart';
import 'package:apd110_sakshidali/core/constants/app_colors.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          "My Orders",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryTeal,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return OrderCard(
            orderId: "#CXR10${index + 1}",
            status: index.isEven ? "In Transit" : "Delivered",
            from: "Mumbai",
            to: "Pune",
            date: "10 Jan 2026",
            onTrack: () {
              // TODO: Navigate to tracking page
            },
          );
        },
      ),
    );
  }
}

/* ---------------------------------- */
/* Order Card Widget */
/* ---------------------------------- */

class OrderCard extends StatelessWidget {
  final String orderId;
  final String status;
  final String from;
  final String to;
  final String date;
  final VoidCallback onTrack;

  const OrderCard({
    super.key,
    required this.orderId,
    required this.status,
    required this.from,
    required this.to,
    required this.date,
    required this.onTrack,
  });

  @override
  Widget build(BuildContext context) {
    final bool delivered = status == "Delivered";

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Order ID & Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                orderId,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              _statusChip(delivered),
            ],
          ),

          const SizedBox(height: 14),
          const Divider(height: 1),

          const SizedBox(height: 12),

          /// Route
          Row(
            children: [
              const Icon(Icons.route_outlined, size: 18),
              const SizedBox(width: 8),
              Text(
                "$from → $to",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          /// Date
          Row(
            children: [
              const Icon(Icons.calendar_today_outlined, size: 16),
              const SizedBox(width: 8),
              Text(
                date,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// Track Button
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: onTrack,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryTeal,
                foregroundColor: Colors.white,
                elevation: 0,
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                "Track Order",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Status Chip
  Widget _statusChip(bool delivered) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: delivered
            ? Colors.green.withOpacity(0.12)
            : AppColors.primaryTeal.withOpacity(0.12),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Icon(
            delivered ? Icons.check_circle : Icons.local_shipping_outlined,
            size: 14,
            color: delivered ? Colors.green : AppColors.primaryTeal,
          ),
          const SizedBox(width: 6),
          Text(
            delivered ? "Delivered" : "In Transit",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: delivered ? Colors.green : AppColors.primaryTeal,
            ),
          ),
        ],
      ),
    );
  }
}
