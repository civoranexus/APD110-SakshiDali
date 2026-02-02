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

  // Controllers
  final _senderName = TextEditingController();
  final _senderPhone = TextEditingController();
  final _receiverName = TextEditingController();
  final _receiverPhone = TextEditingController();
  final _packageWeight = TextEditingController();
  final _packageType = TextEditingController();
  final _pickupLocation = TextEditingController();
  final _dropLocation = TextEditingController();

  bool isLoading = false;

  // Schedule delivery
  bool scheduleLater = false;
  DateTime? scheduledDate;
  TimeOfDay? scheduledTime;

  // ---------------- Date Picker ----------------
  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );

    if (date != null) {
      setState(() => scheduledDate = date);
    }
  }

  // ---------------- Time Picker ----------------
  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      setState(() => scheduledTime = time);
    }
  }

  // ---------------- Save to Firestore ----------------
  Future<void> _createPackage() async {
    setState(() => isLoading = true);

    try {
      final user = FirebaseAuth.instance.currentUser;
      final docRef =
          FirebaseFirestore.instance.collection('send_packages').doc();

      await docRef.set({
        "packageId": docRef.id,
        "senderId": user!.uid,

        "sender": {
          "name": _senderName.text.trim(),
          "phone": _senderPhone.text.trim(),
        },

        "receiver": {
          "name": _receiverName.text.trim(),
          "phone": _receiverPhone.text.trim(),
        },

        "package": {
          "weight": _packageWeight.text.trim(),
          "type": _packageType.text.trim(),
        },

        "pickup": {
          "location": _pickupLocation.text.trim(),
        },

        "drop": {
          "location": _dropLocation.text.trim(),
        },

        "schedule": {
          "isScheduled": scheduleLater,
          "date": scheduleLater ? scheduledDate : null,
          "time": scheduleLater ? scheduledTime?.format(context) : null,
        },

        "status": "pending",
        "createdAt": FieldValue.serverTimestamp(),
      });

      // Navigate to payment page
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => PaymentPage(packageId: docRef.id),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }

    setState(() => isLoading = false);
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

              // ---------------- Schedule ----------------
              _infoCard(
                title: "Delivery Schedule",
                children: [
                  SwitchListTile(
                    value: scheduleLater,
                    title: const Text("Schedule for Later"),
                    onChanged: (value) {
                      setState(() => scheduleLater = value);
                    },
                  ),

                  if (scheduleLater) ...[
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _pickDate,
                            child: Text(
                              scheduledDate == null
                                  ? "Select Date"
                                  : "${scheduledDate!.day}/${scheduledDate!.month}/${scheduledDate!.year}",
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _pickTime,
                            child: Text(
                              scheduledTime == null
                                  ? "Select Time"
                                  : scheduledTime!.format(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
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
                            if (scheduleLater &&
                                (scheduledDate == null ||
                                    scheduledTime == null)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Please select date & time"),
                                ),
                              );
                              return;
                            }
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

  // ---------------- UI Helpers ----------------
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
