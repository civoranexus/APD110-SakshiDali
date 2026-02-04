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

  // Sender
  final _senderName = TextEditingController();
  final _senderPhone = TextEditingController();

  // Receiver
  final _receiverName = TextEditingController();
  final _receiverPhone = TextEditingController();
  final _receiverEmail = TextEditingController();

  // Package
  final _packageWeight = TextEditingController();
  final _packageType = TextEditingController();
  final _pickupLocation = TextEditingController();
  final _dropLocation = TextEditingController();

  bool isLoading = false;
  bool scheduleLater = false;
  DateTime? scheduledDate;
  TimeOfDay? scheduledTime;

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (date != null) setState(() => scheduledDate = date);
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) setState(() => scheduledTime = time);
  }

  // ---------------- SAVE PACKAGE + NOTIFICATION ----------------
  Future<void> _createPackage() async {
    setState(() => isLoading = true);

    try {
      final user = FirebaseAuth.instance.currentUser!;
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      final senderEmail = userDoc['email'];

      final packageRef =
          FirebaseFirestore.instance.collection('send_packages').doc();

      await packageRef.set({
        "packageId": packageRef.id,
        "senderId": user.uid,

        "sender": {
          "name": _senderName.text.trim(),
          "phone": _senderPhone.text.trim(),
          "email": senderEmail,
        },

        "receiver": {
          "name": _receiverName.text.trim(),
          "phone": _receiverPhone.text.trim(),
          "email": _receiverEmail.text.trim(),
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

      // 🔔 Notification for receiver
      await FirebaseFirestore.instance.collection('notifications').add({
        "receiverEmail": _receiverEmail.text.trim(),
        "title": "📦 New Package Incoming",
        "message":
            "Sender: ${_senderName.text}\nEmail: $senderEmail\nPhone: ${_senderPhone.text}",
        "packageId": packageRef.id,
        "isRead": false,
        "createdAt": FieldValue.serverTimestamp(),
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PaymentPage(packageId: packageRef.id),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
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
              _infoCard("Sender Details", [
                _inputField("Sender Name", Icons.person, _senderName),
                _inputField("Sender Phone", Icons.phone, _senderPhone),
              ]),

              _infoCard("Receiver Details", [
                _inputField("Receiver Name", Icons.person_outline, _receiverName),
                _inputField("Receiver Phone", Icons.phone_android, _receiverPhone),
                _inputField("Receiver Email", Icons.email, _receiverEmail),
              ]),

              _infoCard("Package Details", [
                _inputField("Package Weight (kg)", Icons.scale, _packageWeight),
                _inputField(
                    "Package Type", Icons.inventory_2, _packageType),
              ]),

              _infoCard("Pickup Address", [
                _inputField(
                    "Pickup Location", Icons.location_on, _pickupLocation),
              ]),

              _infoCard("Drop Address", [
                _inputField("Drop Location", Icons.flag, _dropLocation),
              ]),

              _infoCard("Delivery Schedule", [
                SwitchListTile(
                  value: scheduleLater,
                  title: const Text("Schedule for Later"),
                  onChanged: (v) => setState(() => scheduleLater = v),
                ),
                if (scheduleLater)
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
              ]),

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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Proceed to Payment",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoCard(String title, List<Widget> children) {
    return Card(
      margin: const EdgeInsets.only(bottom: 18),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryTeal)),
          const SizedBox(height: 14),
          ...children,
        ]),
      ),
    );
  }

  Widget _inputField(
      String hint, IconData icon, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        validator: (v) => v == null || v.isEmpty ? "$hint required" : null,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: AppColors.primaryTeal),
          filled: true,
          fillColor: AppColors.background,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
