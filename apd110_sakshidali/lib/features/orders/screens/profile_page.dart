import 'package:apd110_sakshidali/core/constants/app_colors.dart';
import 'package:apd110_sakshidali/features/auth/screens/helpAndSupport_page.dart';
import 'package:apd110_sakshidali/features/auth/screens/home_screen.dart';
import 'package:apd110_sakshidali/features/orders/screens/my_orderPage.dart';
import 'package:apd110_sakshidali/features/orders/screens/payment_method.dart';
import 'package:apd110_sakshidali/features/orders/screens/payment_page.dart';
import 'package:apd110_sakshidali/features/orders/screens/savedAddress_page.dart';
import 'package:apd110_sakshidali/features/orders/screens/settings.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primaryTeal,
        elevation: 0,
        title: const Text(
          "My Profile",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Profile Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24),
              decoration: const BoxDecoration(
                color: AppColors.primaryTeal,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: const [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: AppColors.primaryTeal,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Sakshi Dali",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "sakshi@email.com",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// Profile Options
            _profileTile(
              context,
              icon: Icons.location_on_outlined,
              title: "Saved Addresses",
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) =>  SavedAddressPage(),
                  ),
                );
              },
            ),

            _profileTile(
              context,
              icon: Icons.receipt_long_outlined,
              title: "My Orders",
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const MyOrdersPage(),
                  ),
                );
              },
            ),

            _profileTile(
              context,
              icon: Icons.account_balance_wallet_outlined,
              title: "Payment History",
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) =>  PaymentsPage(),
                  ),
                );
              },
            ),

            _profileTile(
              context,
              icon: Icons.support_agent_outlined,
              title: "Help & Support",
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) =>  HelpSupportPage(),
                  ),
                );
              },
            ),

            _profileTile(
              context,
              icon: Icons.settings_outlined,
              title: "Settings",
             onTap: () {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (_) =>  SettingsPage()),
  );
},
            ),

            const SizedBox(height: 16),

            /// Logout Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.tealDark,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Logout",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  /// ✅ FIXED PROFILE TILE
  Widget _profileTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: ListTile(
          leading: Icon(icon, color: AppColors.primaryTeal),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap:onTap
  // Navigator.of(context).push(
  //   MaterialPageRoute(builder: (_) =>  HomePage()),
  // );
        ),
      ),
    );
  }
}
