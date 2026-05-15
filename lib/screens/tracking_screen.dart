import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/shipment.dart';
import '../services/api_service.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key, required this.trackingNumber});

  final String trackingNumber;

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  final _api = ApiService();
  late Future<Shipment> _shipmentFuture;

  @override
  void initState() {
    super.initState();
    _shipmentFuture = _api.fetchShipment(widget.trackingNumber);
  }

  Future<void> _refresh() async {
    final future = _api.fetchShipment(widget.trackingNumber);
    setState(() {
      _shipmentFuture = future;
    });
    await future;
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat.yMMMd().add_jm();
    return Scaffold(
      appBar: AppBar(title: Text(widget.trackingNumber)),
      body: FutureBuilder<Shipment>(
        future: _shipmentFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Could not load shipment: ${snapshot.error}'));
          }
          final shipment = snapshot.data!;
          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: ListTile(
                  title: Text('${shipment.origin} → ${shipment.destination}'),
                  subtitle: Text(
                    'ETA ${dateFormat.format(shipment.estimatedDelivery)}',
                  ),
                  trailing: Chip(label: Text(shipment.status)),
                ),
              ),
              const SizedBox(height: 8),
              for (final event in shipment.events)
                ListTile(
                  leading: const Icon(Icons.local_shipping_outlined),
                  title: Text(event.description),
                  subtitle: Text(
                    '${event.location} — ${dateFormat.format(event.timestamp)}',
                  ),
                ),
            ],
            ),
          );
        },
      ),
    );
  }
}
