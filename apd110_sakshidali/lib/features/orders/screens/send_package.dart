import 'package:apd110_sakshidali/core/constants/app_colors.dart';
import 'package:apd110_sakshidali/features/orders/screens/payment_method.dart';
import 'package:apd110_sakshidali/features/orders/screens/settings.dart';
import 'package:flutter/material.dart';


class SendPackagePage extends StatelessWidget {
  const SendPackagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Send Package"),
        centerTitle: true,
        backgroundColor: AppColors.primaryTeal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            _sectionTitle("Sender Details"),
            _inputField("Sender Name"),
            _inputField("Sender Phone"),

            const SizedBox(height: 20),

            _sectionTitle("Receiver Details"),
            _inputField("Receiver Name"),
            _inputField("Receiver Phone"),

            const SizedBox(height: 20),

            _sectionTitle("Package Details"),
            _inputField("Package Weight (kg)"),
            _inputField("Package Type (Document / Box / Fragile)"),

            const SizedBox(height: 20),

            _sectionTitle("Pickup Address"),
            _inputField("Pickup Location"),

            const SizedBox(height: 20),

            _sectionTitle("Drop Address"),
            _inputField("Drop Location"),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                 onPressed: () {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (_) =>  PaymentPage()),
  );
},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryTeal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Proceed to Payment",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryTeal,
        ),
      ),
    );
  }

  Widget _inputField(String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
