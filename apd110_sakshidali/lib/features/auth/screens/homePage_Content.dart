import 'dart:ui';

import 'package:apd110_sakshidali/core/constants/app_colors.dart';
import 'package:apd110_sakshidali/features/orders/screens/my_orderPage.dart';
import 'package:apd110_sakshidali/features/orders/screens/payment_page.dart';
import 'package:apd110_sakshidali/features/orders/screens/send_package.dart';
import 'package:apd110_sakshidali/features/orders/screens/track_orderPage.dart';
import 'package:flutter/material.dart';

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 👋 Welcome
          const Text(
            "Welcome Back 👋",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.navyCore,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            "Smart Last-Mile Delivery Platform",
            style: TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 22),

          /// 🔍 Search Bar
          TextField(
            decoration: InputDecoration(
              hintText: "Search orders, tracking ID...",
              prefixIcon: Icon(Icons.search, color: AppColors.primaryTeal),
              filled: true,
              fillColor: AppColors.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 28),

          /// ⚡ Quick Services
          const Text(
            "Quick Services",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.navyCore,
            ),
          ),

          const SizedBox(height: 14),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _serviceCard(
                context,
                Icons.local_shipping_rounded,
                "Send\nPackage",
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SendPackagePage()),
                ),
              ),
              _serviceCard(
                context,
                Icons.track_changes_rounded,
                "Track\nOrder",
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TrackOrderPage()),
                ),
              ),
              _serviceCard(
                context,
                Icons.receipt_long_rounded,
                "My\nOrders",
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MyOrdersPage()),
                ),
              ),
              _serviceCard(
                context,
                Icons.payment_rounded,
                "Payments",
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PaymentsPage()),
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          /// 🚚 Active Delivery
          const Text(
            "Active Delivery",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.navyCore,
            ),
          ),

          const SizedBox(height: 14),

          Card(
            elevation: 5,
            shadowColor: AppColors.primaryTeal.withOpacity(0.25),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Order ID + Status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Order ID: CX-2048",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.navyCore,
                        ),
                      ),
                      Chip(
                        backgroundColor:
                            AppColors.success.withOpacity(0.15),
                        label: const Text(
                          "LIVE",
                          style: TextStyle(
                            color: AppColors.success,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: const [
                      Icon(Icons.circle,
                          size: 10, color: AppColors.success),
                      SizedBox(width: 6),
                      Text("Out for Delivery"),
                    ],
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Expected: Today at 6:30 PM",
                    style: TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 18),

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
                      onPressed: () {},
                      child: const Text(
                        "Track Order",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color:Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Service Card (CivoraX Style)
  static Widget _serviceCard(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryTeal.withOpacity(0.18),
                  AppColors.tealDark.withOpacity(0.18),
                ],
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(icon, color: AppColors.primaryTeal, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.navyCore,
            ),
          ),
        ],
      ),
    );
  }
}
 