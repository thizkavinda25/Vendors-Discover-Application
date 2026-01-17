import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendors_discover/controllers/auth_controller.dart';
import 'package:vendors_discover/widgets/custom_card.dart';

import '../providers/vendor_state_provider.dart';
import '../widgets/category_row.dart';

class HomeScree extends StatefulWidget {
  const HomeScree({super.key});

  @override
  State<HomeScree> createState() => _HomeScreeState();
}

class _HomeScreeState extends State<HomeScree> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<VendorStateProvider>().fetchVendors();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(),

      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {
                AuthController().signOut(context);
              },
              icon: Icon(Icons.notifications_none),
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
          if (vendorProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (vendorProvider.vendors.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      text: 'Hello, Thisara',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: '\nwhat are you looking for?',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  SizedBox(height: 20),
                  CategoryRow(categoryName: 'Photographers', onPressed: () {}),
                  CustomCard(
                    vendorProvider: vendorProvider,
                    categoryId: 'photo',
                  ),
                  SizedBox(height: 20),
                  CategoryRow(
                    categoryName: 'Food & Beverage',
                    onPressed: () {},
                  ),
                  CustomCard(
                    vendorProvider: vendorProvider,
                    categoryId: 'food',
                  ),
                  SizedBox(height: 20),
                  CategoryRow(categoryName: 'Wholesalers', onPressed: () {}),
                  CustomCard(
                    vendorProvider: vendorProvider,
                    categoryId: 'wholesaler',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
