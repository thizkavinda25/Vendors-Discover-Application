import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/vendor_model.dart';

class VendorController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// Fetch all active vendors
  Stream<List<VendorModel>> fetchActiveVendors() {
    return firestore
        .collection('vendors')
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => VendorModel.fromDocument(doc))
          .toList();
    });
  }
}
