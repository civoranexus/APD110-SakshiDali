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
          return _orderCard(
            orderId: "#CXR10${index + 1}",
            status: index.isEven ? "In Transit" : "Delivered",
            from: "Mumbai",
            to: "Pune",
            date: "10 Jan 2026",
          );
        },
      ),
    );
  }

  Widget _orderCard({
    required String orderId,
    required String status,
    required String from,
    required String to,
    required String date,
  }) {
    final bool delivered = status == "Delivered";

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order ID & Status
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
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: delivered
                      ? Colors.green.withOpacity(0.1)
                      : AppColors.primaryTeal.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: delivered
                        ? Colors.green
                        : AppColors.primaryTeal,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Route
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 18),
              const SizedBox(width: 6),
              Text(
                "$from → $to",
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Date
          Row(
            children: [
              const Icon(Icons.calendar_today_outlined, size: 16),
              const SizedBox(width: 6),
              Text(
                date,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Track Button
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryTeal,
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
}
