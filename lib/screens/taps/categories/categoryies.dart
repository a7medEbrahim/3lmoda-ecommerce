import 'package:almoda/core/text_style.dart';
import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Categories',
        style: Poppins.w700.getStyle(fontSize: 20, color: Colors.black),
      ),
    );
  }
}
