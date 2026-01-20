import 'package:apd110_sakshidali/core/constants/app_colors.dart';
import 'package:apd110_sakshidali/features/orders/screens/payment_method.dart';
import 'package:flutter/material.dart';

class SendPackagePage extends StatelessWidget {
  const SendPackagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text("Send Package"),
        centerTitle: true,
        backgroundColor: AppColors.primaryTeal,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            _infoCard(
              title: "Sender Details",
              children: [
                _inputField("Sender Name", Icons.person),
                _inputField("Sender Phone", Icons.phone),
              ],
            ),

            _infoCard(
              title: "Receiver Details",
              children: [
                _inputField("Receiver Name", Icons.person_outline),
                _inputField("Receiver Phone", Icons.phone_android),
              ],
            ),

            _infoCard(
              title: "Package Details",
              children: [
                _inputField("Package Weight (kg)", Icons.scale),
                _inputField(
                  "Package Type (Document / Box / Fragile)",
                  Icons.inventory_2,
                ),
              ],
            ),

            _infoCard(
              title: "Pickup Address",
              children: [
                _inputField("Pickup Location", Icons.location_on),
              ],
            ),

            _infoCard(
              title: "Drop Address",
              children: [
                _inputField("Drop Location", Icons.flag),
              ],
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const PaymentPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryTeal,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
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

  /// 🧾 Card Section
  Widget _infoCard({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 18),
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryTeal,
              ),
            ),
            const SizedBox(height: 14),
            ...children,
          ],
        ),
      ),
    );
  }

  /// ✏️ Input Field
  Widget _inputField(String hint, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: AppColors.primaryTeal),
          filled: true,
          fillColor: AppColors.background,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
