import 'package:almoda/core/text_style.dart';
import 'package:flutter/material.dart';

class Wishlist extends StatelessWidget {
  const Wishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Wishlist',
        style: Poppins.w700.getStyle(fontSize: 20, color: Colors.black),
      ),
    );
  }
}
