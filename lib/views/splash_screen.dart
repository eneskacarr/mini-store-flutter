import 'dart:async';
import 'package:day4/services/local_storage.dart';
import 'package:day4/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:day4/views/product_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final LocalStorageServices storage = LocalStorageServices();

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {
    await Future.delayed(const Duration(seconds: 2));

    final username = await storage.getData();

    if (!mounted) return;

    if (username != null && username.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ProductScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                size: 60,
                color: Color(0xFF4F46E5),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Mini Store",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(
              "Simple Shopping Experience",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
            ),

            const SizedBox(height: 40),

            const CircularProgressIndicator(color: Color(0xFF4F46E5)),
          ],
        ),
      ),
    );
  }
}
