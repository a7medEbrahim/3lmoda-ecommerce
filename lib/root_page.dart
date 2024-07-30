import 'package:almoda/core/service/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Perform the redirect here based on the authentication status.
    final userResponse = CacheHelper.getData('userResponse');
    if (userResponse == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        GoRouter.of(context).go('/login');
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        GoRouter.of(context).go('/home');
      });
    }

    // Return a splash screen or loading indicator while performing the redirect.
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
