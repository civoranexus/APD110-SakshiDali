import 'package:flutter/material.dart';
import 'package:apd110_sakshidali/core/constants/app_colors.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({super.key});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  String selectedFilter = "All";

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _topStats(),
            const SizedBox(height: 22),
            _filters(),
            const SizedBox(height: 16),
            const Text(
              "Transaction History",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                children: const [
                  PaymentTile(
                    title: "Order #CXR101",
                    date: "10 Jan 2026",
                    amount: "- ₹450",
                    status: PaymentStatus.success,
                  ),
                  PaymentTile(
                    title: "Order #CXR102",
                    date: "08 Jan 2026",
                    amount: "- ₹820",
                    status: PaymentStatus.success,
                  ),
                  PaymentTile(
                    title: "Refund #CXR099",
                    date: "05 Jan 2026",
                    amount: "+ ₹300",
                    status: PaymentStatus.refund,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topStats() {
    return Row(
      children: [
        _statCard("Available Balance", "₹ 3,500", Icons.account_balance_wallet),
        const SizedBox(width: 12),
        _statCard("Total Spent", "₹ 1,270", Icons.trending_down),
      ],
    );
  }

  Widget _statCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
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
            Icon(icon, color: AppColors.primaryTeal),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _filters() {
    return Row(
      children: ["All", "Paid", "Refund"].map((filter) {
        final isSelected = selectedFilter == filter;
        return GestureDetector(
          onTap: () {
            setState(() => selectedFilter = filter);
          },
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primaryTeal
                  : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              filter,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

enum PaymentStatus { success, refund }

class PaymentTile extends StatelessWidget {
  final String title;
  final String date;
  final String amount;
  final PaymentStatus status;

  const PaymentTile({
    super.key,
    required this.title,
    required this.date,
    required this.amount,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final isRefund = status == PaymentStatus.refund;

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
            backgroundColor: isRefund
                ? Colors.orange.withOpacity(0.1)
                : Colors.green.withOpacity(0.1),
            child: Icon(
              isRefund ? Icons.refresh : Icons.check_circle,
              color: isRefund ? Colors.orange : Colors.green,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(
                  date,
                  style:
                      const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: amount.startsWith("+")
                      ? Colors.green
                      : Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isRefund
                      ? Colors.orange.withOpacity(0.15)
                      : Colors.green.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  isRefund ? "Refunded" : "Paid",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isRefund ? Colors.orange : Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
