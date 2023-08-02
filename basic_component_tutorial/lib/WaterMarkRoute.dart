import 'package:flutter/material.dart';

class WaterMarkRoute extends StatefulWidget {
  const WaterMarkRoute({super.key});

  @override
  _WaterMarkRouteState createState() => _WaterMarkRouteState();
}

class _WaterMarkRouteState extends State<WaterMarkRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('水印'),
      ),
      body: const Center(
        child: Text('To-do'),
      ),
    );
  }
}