import 'package:apd110_sakshidali/core/constants/app_colors.dart';
import 'package:apd110_sakshidali/features/orders/screens/payment_method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SendPackagePage extends StatefulWidget {
  const SendPackagePage({super.key});

  @override
  State<SendPackagePage> createState() => _SendPackagePageState();
}

class _SendPackagePageState extends State<SendPackagePage> {
  final _formKey = GlobalKey<FormState>();

  final _senderName = TextEditingController();
  final _senderPhone = TextEditingController();
  final _receiverName = TextEditingController();
  final _receiverPhone = TextEditingController();
  final _packageWeight = TextEditingController();
  final _packageType = TextEditingController();
  final _pickupLocation = TextEditingController();
  final _dropLocation = TextEditingController();

  bool isLoading = false;

  /// 🚀 Save package to Firestore
  Future<void> _createPackage() async {
    setState(() => isLoading = true);

    final user = FirebaseAuth.instance.currentUser;
    final docRef =
        FirebaseFirestore.instance.collection('send_packages').doc();

    await docRef.set({
      "packageId": docRef.id,

      "senderId": user!.uid,
      "senderName": _senderName.text.trim(),
      "senderPhone": _senderPhone.text.trim(),

      "receiverName": _receiverName.text.trim(),
      "receiverPhone": _receiverPhone.text.trim(),

      "packageDetails": {
        "weight": _packageWeight.text.trim(),
        "type": _packageType.text.trim(),
      },

      "pickupAddress": {
        "location": _pickupLocation.text.trim(),
      },

      "dropAddress": {
        "location": _dropLocation.text.trim(),
      },

      "status": "pending",
      "createdAt": FieldValue.serverTimestamp(),
    });

    setState(() => isLoading = false);

    /// ➡️ Navigate to payment page
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PaymentPage(packageId: docRef.id),
      ),
    );
  }

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

      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              _infoCard(
                title: "Sender Details",
                children: [
                  _inputField("Sender Name", Icons.person, _senderName),
                  _inputField("Sender Phone", Icons.phone, _senderPhone),
                ],
              ),

              _infoCard(
                title: "Receiver Details",
                children: [
                  _inputField("Receiver Name", Icons.person_outline, _receiverName),
                  _inputField("Receiver Phone", Icons.phone_android, _receiverPhone),
                ],
              ),

              _infoCard(
                title: "Package Details",
                children: [
                  _inputField("Package Weight (kg)", Icons.scale, _packageWeight),
                  _inputField(
                    "Package Type (Document / Box / Fragile)",
                    Icons.inventory_2,
                    _packageType,
                  ),
                ],
              ),

              _infoCard(
                title: "Pickup Address",
                children: [
                  _inputField("Pickup Location", Icons.location_on, _pickupLocation),
                ],
              ),

              _infoCard(
                title: "Drop Address",
                children: [
                  _inputField("Drop Location", Icons.flag, _dropLocation),
                ],
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            _createPackage();
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryTeal,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
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

  /// ✏️ Input Field with Validation
  Widget _inputField(
    String hint,
    IconData icon,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return '$hint is required';
          }
          return null;
        },
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
