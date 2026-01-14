import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/vendor_model.dart';
import '../providers/vendor_state_provider.dart';

class HomeScree extends StatefulWidget {
  const HomeScree({super.key});

  @override
  State<HomeScree> createState() => _HomeScreeState();
}

class _HomeScreeState extends State<HomeScree> {
  // @override
  // void initState() {
  //   super.initState();
  //   Future.microtask(() {
  //     context.read<VendorStateProvider>().fetchVendors();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications_active),
            ),
          ),
        ],
        iconTheme: IconThemeData(size: 30),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.villa_rounded, color: Colors.pinkAccent, size: 32),
            Text('Vendor Go', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: Consumer<VendorStateProvider>(
        builder: (context, vendorProvider, child) {
          // if (vendorProvider.isLoading) {
          //   return const Center(child: CircularProgressIndicator());
          // }
          // if (vendorProvider.vendors.isEmpty) {
          //   return const Center(child: Text('No vendor found'));
          // }
          // int length = vendorProvider.vendors.length;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(children: [
                
              ],
            ),
          );
        },
      ),
    );
  }
}
