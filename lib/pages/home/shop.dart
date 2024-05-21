import 'package:flutter/material.dart';

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF1C1C1C),
      body: Center(
        child: Text('Shop screen',
            style: TextStyle(fontSize: 40, color: Colors.white)),
      ),
    );
  }
}
