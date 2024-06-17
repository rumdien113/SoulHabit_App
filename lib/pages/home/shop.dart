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
        child: Text(
            'Tính năng này đang được phát triển và sẽ ra mắt trong thời gian tới! Bạn vui lòng quay lại sau nhé!',
            style: TextStyle(fontSize: 20, color: Colors.white),
            textAlign: TextAlign.center),
      ),
    );
  }
}
