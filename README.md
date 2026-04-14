# mobile-app

CargoCloud mobile app for iOS and Android — shipment tracking and push notifications. Built with Flutter and Dart.

Customers use the app to track parcels in real time and receive delivery updates as push notifications.

## Role at CargoCloud

- Fetches shipment and tracking data from [`orders-api`](https://github.com/shipit-ai-demo-org/orders-api)
- Registers device push tokens with, and receives delivery updates from, [`notifications-service`](https://github.com/shipit-ai-demo-org/notifications-service)
- Shares the public API gateway with the web storefront ([`web-storefront`](https://github.com/shipit-ai-demo-org/web-storefront))

## Architecture

```
mobile app (Flutter)
  ├── GET  /v1/shipments/{trackingNumber}  -> orders-api
  └── POST /v1/push-tokens                 -> notifications-service (via gateway)
       <── APNs / FCM delivery updates     <- notifications-service
```

`lib/services/api_service.dart` is the single HTTP entry point; screens consume typed models from `lib/models/`.

## Usage

```bash
flutter pub get
flutter run            # pick an iOS simulator or Android emulator
flutter analyze
```

| Screen           | Purpose                              |
| ---------------- | ------------------------------------ |
| `HomeScreen`     | Enter a tracking number              |
| `TrackingScreen` | Live status, ETA and event timeline  |
