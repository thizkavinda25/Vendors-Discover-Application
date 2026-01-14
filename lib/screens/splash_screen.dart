import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vendors_discover/screens/auth_screen.dart';
import 'package:vendors_discover/screens/home_scree.dart';
import 'package:vendors_discover/utils/navigator_manage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    if (FirebaseAuth.instance.currentUser == null) {
      Timer(const Duration(seconds: 5), () {
        NavigatorManage.goPushReplace(context, const AuthScreen());
      });
    } else {
      Timer(const Duration(seconds: 0), () {
        NavigatorManage.goPushReplace(context, const HomeScree());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              'assets/lottie/splash.json',
              width: 300,
              height: 300,
              fit: BoxFit.cover,
              repeat: true,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.villa_rounded, color: Colors.pinkAccent, size: 40),
                  Text(
                    'Vendo Go',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Discover local favorites near you',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
