import 'package:flutter/material.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key, required this.trackingNumber});

  final String trackingNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(trackingNumber)),
      body: const Center(child: CircularProgressIndicator()),
    );
  }
}
