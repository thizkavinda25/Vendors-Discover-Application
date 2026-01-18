import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:provider/provider.dart';
import 'package:vendors_discover/models/vendor_model.dart';
import 'package:vendors_discover/providers/user_state_provider.dart';
import 'package:vendors_discover/utils/custom_dialogs.dart';
import 'package:vendors_discover/utils/navigator_manage.dart';

class VendorDetails extends StatefulWidget {
  final VendorModel vendorModel;
  const VendorDetails({super.key, required this.vendorModel});

  @override
  State<VendorDetails> createState() => _VendorDetailsState();
}

class _VendorDetailsState extends State<VendorDetails> {
  String aboutType = 'desc';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(25),
                ),
                image: DecorationImage(
                  image: NetworkImage(widget.vendorModel.imageUrl),
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
              child: Stack(
                children: [
                  _backgroundOverlay(),
                  SafeArea(child: _topRowButtons(context, widget.vendorModel)),
                  _vendorInfoCover(widget.vendorModel),
                ],
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _customChip(
                        aboutType,
                        'Description',
                        () => setState(() {
                          aboutType = 'desc';
                        }),
                      ),
                      _customChip(
                        aboutType,
                        'Reviews',
                        () => setState(() {
                          aboutType = 'rev';
                        }),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  aboutType == 'desc'
                      ? _vendorDescription(widget.vendorModel)
                      : _vendorReviews(),
                  if (aboutType == 'desc') _bookNowButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _topRowButtons(BuildContext context, VendorModel vendor) {
  return Align(
    alignment: Alignment.topCenter,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.black.withOpacity(0.5),
            child: IconButton(
              onPressed: () {
                NavigatorManage.popContext(context);
              },
              icon: Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          Consumer<UserStateProvider>(
            builder: (context, userProvider, child) {
              bool isFavorite = userProvider.isFavorite(vendor.id);
              return CircleAvatar(
                backgroundColor: Colors.black.withOpacity(0.5),
                child: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.white,
                  ),
                  onPressed: () async {
                    if (isFavorite) {
                      await userProvider.removeFavorite(vendor.id);
                      CustomDialogs.showErrorSnackBar(
                        context,
                        'Remove From Favorites',
                      );
                    } else {
                      await userProvider.addFavorite(vendor.id);
                      CustomDialogs.showSuccessSnackBar(
                        context,
                        'Added To Favorites',
                      );
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
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

Widget _customChip(String aboutType, String labelText, VoidCallback onTap) {
  bool isActive =
      (labelText == 'Description' && aboutType == 'desc') ||
      (labelText == 'Reviews' && aboutType == 'rev');
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 120,
      height: 35,
      decoration: BoxDecoration(
        color: isActive
            ? const Color.fromARGB(255, 23, 23, 23)
            : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          labelText,
          style: TextStyle(color: isActive ? Colors.white : Colors.black),
        ),
      ),
    ),
  );
}

Widget _vendorDescription(VendorModel vendor) {
  return SingleChildScrollView(
    child: Container(
      padding: EdgeInsets.all(12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About',
            style: TextStyle(
              color: Colors.pink,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Hi, Im ${vendor.name} ${vendor.description}.',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 5),
          Divider(color: Colors.grey.shade300),
          SizedBox(height: 5),
          Text(
            'Contact',
            style: TextStyle(
              color: Colors.pink,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 5),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.phone, color: Colors.green, size: 18),
                  SizedBox(width: 5),
                  Flexible(
                    child: Text(vendor.phone, overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.mail, color: Colors.red, size: 18),
                  SizedBox(width: 5),
                  Flexible(
                    child: Text(vendor.email, overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 5),
          Divider(color: Colors.grey.shade300),
          SizedBox(height: 5),
          Text(
            'Ratings',
            style: TextStyle(
              color: Colors.pink,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: const Color.fromARGB(247, 237, 206, 34),
                  ),
                  SizedBox(width: 5),
                  Text(vendor.rating.toString()),
                ],
              ),
              Flexible(
                child: Text(
                  'Joined: ${DateFormat('yyyy-MM-dd').format(vendor.createdAt.toDate())}',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _vendorReviews() {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.comment, size: 30),
        SizedBox(height: 10),
        Text(
          'No Reviews Yet',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

Widget _bookNowButton() {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      margin: EdgeInsets.only(top: 30, bottom: 20),
      width: double.infinity,
      height: 45,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 215, 25, 88),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.bookmark_add, color: Colors.white),
            SizedBox(width: 5),
            Text(
              'Book Now',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
