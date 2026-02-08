import 'package:flutter/material.dart';

class TrackOrder extends StatelessWidget {
  const TrackOrder({super.key});

  final int currentStep = 2; // 0 to 5

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delivery Tracking"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _deliveryStatus(),
            const SizedBox(height: 30),
            _trackingStepper(),
          ],
        ),
      ),
    );
  }

  // ---------------- STATUS HEADER ----------------
  Widget _deliveryStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "In Transit · On Schedule",
          style: TextStyle(
            color: Colors.orange,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 6),
        Text(
          "Expected delivery: Monday, 6 January 2026",
          style: TextStyle(color: Colors.black54),
        ),
      ],
    );
  }

  // ---------------- TRACKING STEPPER ----------------
  Widget _trackingStepper() {
    final steps = [
      "Dispatching soon",
      "Dispatched",
      "In transit",
      "Out for delivery",
      "Delivered",
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        steps.length,
        (index) => Expanded(
          child: Column(
            children: [
              _stepIndicator(index),
              const SizedBox(height: 8),
              Text(
                steps[index],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: index <= currentStep
                      ? Colors.black
                      : Colors.grey,
                  fontWeight:
                      index == currentStep ? FontWeight.w600 : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- STEP ICON + LINE ----------------
  Widget _stepIndicator(int index) {
    Color color;
    Widget icon;

    if (index < currentStep) {
      color = Colors.orange;
      icon = const Icon(Icons.check, color: Colors.white, size: 16);
    } else if (index == currentStep) {
      color = Colors.blue;
      icon = const Icon(Icons.local_shipping,
          color: Colors.white, size: 16);
    } else {
      color = Colors.grey.shade300;
      icon = const SizedBox.shrink();
    }

    return Row(
      children: [
        CircleAvatar(
          radius: 14,
          backgroundColor: color,
          child: icon,
        ),
        if (index != 4)
          Expanded(
            child: Container(
              height: 4,
              color: index < currentStep
                  ? Colors.orange
                  : Colors.grey.shade300,
            ),
          ),
      ],
    );
  }
}
