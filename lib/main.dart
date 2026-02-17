import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const CargoCloudApp());
}

class CargoCloudApp extends StatelessWidget {
  const CargoCloudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CargoCloud',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0B2545)),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
