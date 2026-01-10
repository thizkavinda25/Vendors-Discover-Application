import 'package:flutter/material.dart';
import 'package:vendors_discover/controllers/auth_controller.dart';

class HomeScree extends StatefulWidget {
  const HomeScree({super.key});

  @override
  State<HomeScree> createState() => _HomeScreeState();
}

class _HomeScreeState extends State<HomeScree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to the Home Screen!'),
            IconButton(
              onPressed: () {
                AuthController().signOut(context);
              },
              icon: const Icon(Icons.login, size: 30),
            ),
          ],
        ),
      ),
    );
  }
}
