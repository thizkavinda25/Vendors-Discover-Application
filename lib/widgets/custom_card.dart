import 'package:flutter/material.dart';
import 'package:vendors_discover/providers/vendor_state_provider.dart';
import 'package:vendors_discover/screens/vendor_details.dart';
import 'package:vendors_discover/utils/navigator_manage.dart';

class CustomCard extends StatefulWidget {
  final VendorStateProvider vendorProvider;
  final String categoryId;
  const CustomCard({
    super.key,
    required this.vendorProvider,
    required this.categoryId,
  });

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    final filteredVendors = widget.vendorProvider.vendors
        .where((vendor) => vendor.categoryId == widget.categoryId)
        .toList();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(filteredVendors.length, (index) {
          final vendorData = filteredVendors[index];
          return Container(
            margin: EdgeInsets.only(right: 20, top: 20),
            padding: EdgeInsets.only(top: 5),
            width: 180,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      vendorData.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 180,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    vendorData.name,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 18,
                        color: Colors.grey.shade900,
                      ),
                      Text(
                        vendorData.city,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star_rate,
                        color: const Color.fromARGB(247, 237, 206, 34),
                        size: 20,
                      ),
                      Text(vendorData.rating.toString()),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          NavigatorManage.goTo(context, VendorDetails(vendorModel: vendorData,));
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.pinkAccent,
                          child: Icon(Icons.add, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
