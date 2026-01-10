import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
      Timer(const Duration(seconds: 2), () {
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
      backgroundColor: Colors.black,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.villa_rounded, color: Colors.pinkAccent, size: 40),
            Text(
              'Vendor Discover',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
