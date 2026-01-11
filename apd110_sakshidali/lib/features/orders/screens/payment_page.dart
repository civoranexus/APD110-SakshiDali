import 'package:flutter/material.dart';
import 'package:apd110_sakshidali/core/constants/app_colors.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          "Payments",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryTeal,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _balanceCard(),
            const SizedBox(height: 20),
            _sectionTitle("Recent Transactions"),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                children: const [
                  PaymentTile(
                    title: "Order #CXR101",
                    date: "10 Jan 2026",
                    amount: "- ₹450",
                    success: true,
                  ),
                  PaymentTile(
                    title: "Order #CXR102",
                    date: "08 Jan 2026",
                    amount: "- ₹820",
                    success: true,
                  ),
                  PaymentTile(
                    title: "Refund #CXR099",
                    date: "05 Jan 2026",
                    amount: "+ ₹300",
                    success: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _balanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryTeal,
            AppColors.primaryTeal.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Total Spent",
            style: TextStyle(color: Colors.white70),
          ),
          SizedBox(height: 8),
          Text(
            "₹ 1,270",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class PaymentTile extends StatelessWidget {
  final String title;
  final String date;
  final String amount;
  final bool success;

  const PaymentTile({
    super.key,
    required this.title,
    required this.date,
    required this.amount,
    required this.success,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: success
                ? Colors.green.withOpacity(0.1)
                : Colors.orange.withOpacity(0.1),
            child: Icon(
              success ? Icons.check_circle : Icons.refresh,
              color: success ? Colors.green : Colors.orange,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: amount.startsWith("+")
                  ? Colors.green
                  : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
