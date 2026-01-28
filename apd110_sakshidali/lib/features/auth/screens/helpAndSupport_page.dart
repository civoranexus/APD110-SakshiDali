import 'package:flutter/material.dart';
import 'package:apd110_sakshidali/core/constants/app_colors.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primaryTeal,
        elevation: 0,
        title: const Text(
          "Help & Support",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.support_agent, color: AppColors.primaryTeal, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "How can we help you today?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// Options
            _supportTile(
              icon: Icons.help_outline,
              title: "FAQs",
              subtitle: "Find answers to common questions",
              onTap: () {},
            ),

            _supportTile(
              icon: Icons.chat_outlined,
              title: "Live Chat",
              subtitle: "Chat with our support team",
              onTap: () {},
            ),

            _supportTile(
              icon: Icons.email_outlined,
              title: "Email Support",
              subtitle: "Reach us via email",
              onTap: () {},
            ),

            _supportTile(
              icon: Icons.report_problem_outlined,
              title: "Report an Issue",
              subtitle: "Let us know if something isn’t right",
              onTap: () {},
            ),

            const SizedBox(height: 24),

            /// Contact Info
            Text(
              "Contact Information",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    children: [
                      Icon(Icons.email, color: AppColors.primaryTeal),
                      SizedBox(width: 8),
                      Text(
                        "support@civorax.com",
                        style: TextStyle(color: AppColors.textDark),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.phone, color: AppColors.primaryTeal),
                      SizedBox(width: 8),
                      Text(
                        "+91 98765 43210",
                        style: TextStyle(color: AppColors.textDark),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Support Tile Widget
  Widget _supportTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Icon(icon, color: AppColors.primaryTeal, size: 26),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textDark),
            ],
          ),
        ),
      ),
    );
  }
}
