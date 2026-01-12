import 'package:apd110_sakshidali/features/orders/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:apd110_sakshidali/core/constants/app_colors.dart';
import 'package:apd110_sakshidali/features/orders/screens/my_orderPage.dart';
import 'package:apd110_sakshidali/features/orders/screens/payment_page.dart';
import 'package:apd110_sakshidali/features/orders/screens/send_package.dart';
import 'package:apd110_sakshidali/features/orders/screens/track_orderPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  late final List<Widget> _pages = [
    const HomePageContent(),
    const MyOrdersPage(),
    const AlertsPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // appBar: AppBar(
      //   backgroundColor: AppColors.navyCore,
      //   elevation: 0,
      //   title: const Text(
      //     "CivoraX – MarketReach",
      //     style: TextStyle(fontWeight: FontWeight.bold),
      //   ),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.notifications_outlined),
      //       onPressed: () {
      //         setState(() => _currentIndex = 2);
      //       },
      //     ),
      //     IconButton(
      //       icon: const Icon(Icons.person_outline),
      //       onPressed: () {
      //         setState(() => _currentIndex = 3);
      //       },
      //     ),
      //   ],
      // ),

      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primaryTeal,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: "Orders"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Alerts"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

/* ================= HOME CONTENT ================= */

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Welcome Back 👋",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "Smart Last-Mile Delivery Platform",
            style: TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 20),

          TextField(
            decoration: InputDecoration(
              hintText: "Search orders or deliveries",
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: AppColors.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            "Quick Services",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _serviceCard(
                context,
                Icons.local_shipping,
                "Send\nPackage",
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SendPackagePage()),
                ),
              ),
              _serviceCard(
                context,
                Icons.track_changes,
                "Track\nOrder",
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TrackOrderPage()),
                ),
              ),
              _serviceCard(
                context,
                Icons.receipt_long,
                "My\nOrders",
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MyOrdersPage()),
                ),
              ),
              _serviceCard(
                context,
                Icons.payment,
                "Payments",
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PaymentsPage()),
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          const Text(
            "Active Delivery",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),

          const SizedBox(height: 12),

          Card(
            color: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Order ID: CX-2048",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: const [
                      Icon(Icons.circle, size: 10, color: AppColors.success),
                      SizedBox(width: 6),
                      Text("Out for Delivery"),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Expected: Today, 6:30 PM",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 14),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.tealDark,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text("Track Order"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _serviceCard(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: AppColors.primaryTeal.withOpacity(0.15),
            child: Icon(icon, color: AppColors.primaryTeal),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: AppColors.textDark),
          ),
        ],
      ),
    );
  }
}

/* ================= PLACEHOLDER PAGES ================= */

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Alerts Page"));
  }
}

