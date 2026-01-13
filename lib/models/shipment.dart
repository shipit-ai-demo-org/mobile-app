/// Domain model for a parcel shipment as returned by orders-api.
class Shipment {
  const Shipment({
    required this.id,
    required this.trackingNumber,
    required this.status,
    required this.origin,
    required this.destination,
    required this.estimatedDelivery,
    this.events = const [],
  });

  final String id;
  final String trackingNumber;
  final String status;
  final String origin;
  final String destination;
  final DateTime estimatedDelivery;
  final List<ShipmentEvent> events;

  factory Shipment.fromJson(Map<String, dynamic> json) {
    return Shipment(
      id: json['id'] as String,
      trackingNumber: json['trackingNumber'] as String,
      status: json['status'] as String,
      origin: json['origin'] as String,
      destination: json['destination'] as String,
      estimatedDelivery: DateTime.parse(json['estimatedDelivery'] as String),
      events: (json['events'] as List<dynamic>? ?? [])
          .map((e) => ShipmentEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ShipmentEvent {
  const ShipmentEvent({
    required this.timestamp,
    required this.location,
    required this.description,
  });

  final DateTime timestamp;
  final String location;
  final String description;

  factory ShipmentEvent.fromJson(Map<String, dynamic> json) {
    return ShipmentEvent(
      timestamp: DateTime.parse(json['timestamp'] as String),
      location: json['location'] as String,
      description: json['description'] as String,
    );
  }
}
