import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:apd110_sakshidali/core/constants/app_colors.dart';

class PaymentPage extends StatefulWidget {
  final String packageId;

  const PaymentPage({
    super.key,
    required this.packageId,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedPayment = 'UPI';
  bool isLoading = false;

  /// 🔥 Update payment info in Firestore
  Future<void> _confirmPayment() async {
    setState(() => isLoading = true);

    try {
      await FirebaseFirestore.instance
          .collection('send_packages')
          .doc(widget.packageId)
          .update({
        "paymentStatus": "paid",
        "paymentMethod": selectedPayment,
        "status": "paid",
        "paidAt": FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Payment successful")),
      );

      /// Go back to Home
      Navigator.popUntil(context, (route) => route.isFirst);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Payment failed")),
      );
    }

    setState(() => isLoading = false);
  }

  Widget paymentOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required String value,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPayment = value;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selectedPayment == value
                ? AppColors.primaryTeal
                : Colors.grey.shade300,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 18,
              width: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selectedPayment == value
                    ? AppColors.primaryTeal
                    : Colors.transparent,
                border: Border.all(
                  color: AppColors.primaryTeal,
                  width: 2,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Icon(icon, color: AppColors.primaryTeal, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: AppColors.primaryTeal,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose Payment Method',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            paymentOption(
              title: 'UPI',
              subtitle: 'Google Pay, PhonePe, Paytm',
              icon: Icons.qr_code,
              value: 'UPI',
            ),

            paymentOption(
              title: 'Debit / Credit Card',
              subtitle: 'Visa, MasterCard, RuPay',
              icon: Icons.credit_card,
              value: 'Card',
            ),

            paymentOption(
              title: 'Wallet',
              subtitle: 'Paytm, Amazon Pay',
              icon: Icons.account_balance_wallet,
              value: 'Wallet',
            ),

            paymentOption(
              title: 'Cash on Delivery',
              subtitle: 'Pay when package arrives',
              icon: Icons.payments,
              value: 'COD',
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryTeal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: isLoading ? null : _confirmPayment,
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Proceed to Pay',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
