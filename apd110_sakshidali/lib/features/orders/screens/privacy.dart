import 'package:flutter/material.dart';
import 'package:apd110_sakshidali/core/constants/app_colors.dart';

class PrivacySecurityPage extends StatefulWidget {
  const PrivacySecurityPage({super.key});

  @override
  State<PrivacySecurityPage> createState() => _PrivacySecurityPageState();
}

class _PrivacySecurityPageState extends State<PrivacySecurityPage> {
  bool is2FAEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          "Privacy & Security",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 🔒 PRIVACY SECTION
            const Text(
              "Privacy",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _infoTile(
              icon: Icons.privacy_tip_outlined,
              title: "Privacy Policy",
              subtitle: "Understand how we collect and use your data",
              onTap: () {
                // Navigate to Privacy Policy page
              },
            ),
            _infoTile(
              icon: Icons.storage_outlined,
              title: "Data Usage",
              subtitle: "Your personal data is safely stored and encrypted",
            ),

            const SizedBox(height: 25),

            // 🔐 SECURITY SECTION
            const Text(
              "Security",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _infoTile(
              icon: Icons.lock_outline,
              title: "Change Password",
              subtitle: "Update your account password regularly",
              onTap: () {
                // Navigate to Change Password page
              },
            ),

            SwitchListTile(
              value: is2FAEnabled,
              onChanged: (value) {
                setState(() {
                  is2FAEnabled = value;
                });
              },
              activeColor: AppColors.primaryTeal,
              title: const Text("Two-Factor Authentication"),
              subtitle: const Text(
                "Add extra security to your account",
                style: TextStyle(fontSize: 13),
              ),
            ),

            const SizedBox(height: 25),

            // ⚠️ ACCOUNT SECTION
            const Text(
              "Account",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Colors.red),
              title: const Text(
                "Delete Account",
                style: TextStyle(color: Colors.red),
              ),
              subtitle: const Text(
                "Permanently remove your account and data",
              ),
              onTap: () {
                _showDeleteDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primaryTeal),
        title: Text(title),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 13),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Account"),
        content: const Text(
          "Are you sure you want to delete your account? This action cannot be undone.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              Navigator.pop(context);
              // Add delete account logic (Firebase delete)
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }
}
