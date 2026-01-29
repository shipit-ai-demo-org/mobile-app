import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/shipment.dart';

/// HTTP client for CargoCloud backend services.
///
/// Talks to orders-api for shipment data and registers device tokens
/// with notifications-service for push delivery updates.
class ApiService {
  ApiService({http.Client? client, String? baseUrl})
      : _client = client ?? http.Client(),
        _baseUrl = baseUrl ?? 'https://api.cargocloud.dev';

  final http.Client _client;
  final String _baseUrl;

  Future<Shipment> fetchShipment(String trackingNumber) async {
    final uri = Uri.parse('$_baseUrl/v1/shipments/$trackingNumber');
    final response = await _client.get(uri, headers: {'Accept': 'application/json'});
    if (response.statusCode != 200) {
      throw ApiException('Failed to fetch shipment', response.statusCode);
    }
    return Shipment.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  Future<void> registerPushToken(String deviceToken, String platform) async {
    final uri = Uri.parse('$_baseUrl/v1/push-tokens');
    final response = await _client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'token': deviceToken, 'platform': platform}),
    );
    if (response.statusCode != 201 && response.statusCode != 200) {
      throw ApiException('Failed to register push token', response.statusCode);
    }
  }
}

class ApiException implements Exception {
  const ApiException(this.message, this.statusCode);

  final String message;
  final int statusCode;

  @override
  String toString() => 'ApiException($statusCode): $message';
}
