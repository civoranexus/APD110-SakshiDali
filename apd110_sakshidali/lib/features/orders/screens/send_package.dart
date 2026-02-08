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
  final _receiverEmail = TextEditingController();

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
    final time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (time != null) setState(() => scheduledTime = time);
  }

  Future<void> _createPackage() async {
    setState(() => isLoading = true);

    try {
      final user = FirebaseAuth.instance.currentUser!;
      final senderEmail = user.email;

      final packageRef =
          FirebaseFirestore.instance.collection('send_packages').doc();

      await packageRef.set({
        "packageId": packageRef.id,
        "senderId": user.uid,

        "sender": {
          "name": _senderName.text,
          "phone": _senderPhone.text,
          "email": senderEmail,
        },

        "receiver": {
          "name": _receiverName.text,
          "phone": _receiverPhone.text,
          "email": _receiverEmail.text,
        },

        "package": {
          "weight": _packageWeight.text,
          "type": _packageType.text,
        },

        "pickup": {"location": _pickupLocation.text},
        "drop": {"location": _dropLocation.text},

        "schedule": {
          "isScheduled": scheduleLater,
          "date": scheduledDate,
          "time": scheduledTime?.format(context),
        },

        "status": "pending",
        "createdAt": FieldValue.serverTimestamp(),
      });

      /// 🔔 NOTIFICATION STORED HERE
      await FirebaseFirestore.instance.collection('notifications').add({
        "receiverEmail": _receiverEmail.text.trim(),
        "title": "📦 New Package Incoming",
        "message":
            "Sender: ${_senderName.text}\nPhone: ${_senderPhone.text}",
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
              _card("Sender Details", [
                _field("Sender Name", _senderName),
                _field("Sender Phone", _senderPhone),
              ]),
              _card("Receiver Details", [
                _field("Receiver Name", _receiverName),
                _field("Receiver Phone", _receiverPhone),
                _field("Receiver Email", _receiverEmail),
              ]),
              _card("Package Details", [
                _field("Weight (kg)", _packageWeight),
                _field("Package Type", _packageType),
              ]),
              _card("Pickup Address", [
                _field("Pickup Location", _pickupLocation),
              ]),
              _card("Drop Address", [
                _field("Drop Location", _dropLocation),
              ]),
              _card("Schedule", [
                SwitchListTile(
                  value: scheduleLater,
                  title: const Text("Schedule Later"),
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
                      const SizedBox(width: 10),
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
                  )
              ]),
              const SizedBox(height: 20),
              SizedBox(
                height: 55,
                width: double.infinity,
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
                      : const Text("Proceed to Payment",
                          style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _card(String title, List<Widget> children) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryTeal)),
          const SizedBox(height: 10),
          ...children
        ]),
      ),
    );
  }

  Widget _field(String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        validator: (v) => v!.isEmpty ? "$hint required" : null,
        decoration: InputDecoration(
          hintText: hint,
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
