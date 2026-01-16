import 'package:flutter/material.dart';
import 'package:vendors_discover/models/vendor_model.dart';
import 'package:vendors_discover/utils/navigator_manage.dart';

class VendorDetails extends StatefulWidget {
  final VendorModel vendorModel;
  const VendorDetails({super.key, required this.vendorModel});

  @override
  State<VendorDetails> createState() => _VendorDetailsState();
}

class _VendorDetailsState extends State<VendorDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
              image: DecorationImage(
                image: NetworkImage(widget.vendorModel.imageUrl),
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
            child: Stack(
              children: [
                _backgroundOverlay(),
                _topRowButtons(context),
                _vendorInfoCover(widget.vendorModel),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _topRowButtons(BuildContext context) {
  return Align(
    alignment: Alignment.topCenter,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40, left: 20),
          child: CircleAvatar(
            backgroundColor: Colors.black.withOpacity(0.5),
            child: IconButton(
              onPressed: () {
                NavigatorManage.popContext(context);
              },
              icon: Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40, right: 20),
          child: CircleAvatar(
            backgroundColor: Colors.black.withOpacity(0.5),
            child: IconButton(
              icon: Icon(Icons.favorite_border, color: Colors.white),
              onPressed: () {},
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _backgroundOverlay() {
  return Container(
    width: double.infinity,
    height: 400,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
      color: Colors.black.withOpacity(0.25),
    ),
  );
}

Widget _vendorInfoCover(VendorModel vendor) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.only(left: 10, top: 5),
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              vendor.name,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              vendor.categoryName,
              style: TextStyle(color: Colors.grey.shade200, fontSize: 12),
            ),
            Row(
              children: [
                Icon(
                  Icons.star,
                  size: 14,
                  color: const Color.fromARGB(247, 237, 206, 34),
                ),
                SizedBox(width: 3),
                Text(
                  vendor.rating.toString(),
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade300),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.white, size: 16),
                SizedBox(width: 3),
                Text(
                  vendor.city,
                  style: TextStyle(color: Colors.grey.shade300, fontSize: 13),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
