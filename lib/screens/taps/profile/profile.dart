import 'package:almoda/core/text_style.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Profile',
        style: Poppins.w700.getStyle(fontSize: 20, color: Colors.black),
      ),
    );
  }
}
