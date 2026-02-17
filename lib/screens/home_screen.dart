import 'package:flutter/material.dart';

import 'tracking_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _track() {
    final trackingNumber = _controller.text.trim();
    if (trackingNumber.isEmpty) return;
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => TrackingScreen(trackingNumber: trackingNumber),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CargoCloud')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Track a parcel',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Tracking number',
                hintText: 'CC-2026-000123',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _track(),
            ),
            const SizedBox(height: 16),
            FilledButton(onPressed: _track, child: const Text('Track shipment')),
          ],
        ),
      ),
    );
  }
}
