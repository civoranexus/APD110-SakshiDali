import 'package:flutter/material.dart';
import 'package:apd110_sakshidali/core/constants/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SavedAddressPage extends StatefulWidget {
  const SavedAddressPage({super.key});

  @override
  State<SavedAddressPage> createState() => _SavedAddressPageState();
}

class _SavedAddressPageState extends State<SavedAddressPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? _user = FirebaseAuth.instance.currentUser;

  /// 🔥 Save address to Firestore
  Future<void> _saveAddress({
    required String tag,
    required String name,
    required String address,
    required String phone,
  }) async {
    await _firestore
        .collection('users')
        .doc(_user!.uid)
        .collection('addresses')
        .add({
      'tag': tag,
      'name': name,
      'address': address,
      'phone': phone,
      'createdAt': Timestamp.now(),
    });
  }

  /// ❌ Delete address from Firestore
  Future<void> _deleteAddress(String docId) async {
    await _firestore
        .collection('users')
        .doc(_user!.uid)
        .collection('addresses')
        .doc(docId)
        .delete();
  }

  /// ➕ Bottom Sheet (Add Address)
  void _showAddAddressPopup() {
    final tagController = TextEditingController();
    final nameController = TextEditingController();
    final addressController = TextEditingController();
    final phoneController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Add Address",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 20),

              _input(tagController, "Tag (Home / Work)"),
              _input(nameController, "Name"),
              _input(addressController, "Full Address", maxLines: 3),
              _input(phoneController, "Phone Number"),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryTeal,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () async {
                    if (tagController.text.isEmpty ||
                        nameController.text.isEmpty ||
                        addressController.text.isEmpty ||
                        phoneController.text.isEmpty) {
                      return;
                    }

                    await _saveAddress(
                      tag: tagController.text.trim(),
                      name: nameController.text.trim(),
                      address: addressController.text.trim(),
                      phone: phoneController.text.trim(),
                    );

                    Navigator.pop(context);
                  },
                  child: const Text("Save Address",style:TextStyle(
                    color: Colors.white
                  )),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primaryTeal,
        title: const Text(
          "Saved Addresses",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryTeal,
        onPressed: _showAddAddressPopup,
        child: const Icon(Icons.add, color: Colors.white),
      ),

      /// 📡 Firestore Stream
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('users')
            .doc(_user!.uid)
            .collection('addresses')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No saved addresses"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final doc = snapshot.data!.docs[index];
              final data = doc.data() as Map<String, dynamic>;
              return _addressCard(data, doc.id);
            },
          );
        },
      ),
    );
  }

  /// 📦 Address Card
  Widget _addressCard(Map<String, dynamic> a, String docId) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primaryTeal.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  a['tag'],
                  style: TextStyle(
                    color: AppColors.primaryTeal,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () => _deleteAddress(docId),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            a['name'],
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Text(a['address']),
          const SizedBox(height: 6),
          Text(a['phone']),
        ]),
      ),
    );
  }

  /// ✏️ Input Field
  Widget _input(
    TextEditingController controller,
    String label, {
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}