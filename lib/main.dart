import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vendors_discover/providers/user_state_provider.dart';
import 'package:vendors_discover/screens/splash_screen.dart';

import 'firebase_options.dart';
import 'providers/auth_state_provider.dart';
import 'providers/vendor_state_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthStateProvider()),
        ChangeNotifierProvider(
          create: (context) {
            final provider = VendorStateProvider();
            provider.fetchVendors();
            return provider;
          },
        ),
        ChangeNotifierProvider(create: (context) => UserStateProvider()),
      ],
      child: DevicePreview(enabled: true, builder: (context) => const MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vendor Discover',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      builder: EasyLoading.init(),
      home: SplashScreen(),
    );
  }
}
