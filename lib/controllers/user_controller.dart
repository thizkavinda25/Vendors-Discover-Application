import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vendors_discover/models/user_models.dart';
import 'package:vendors_discover/models/vendor_model.dart';

class UserController {
  final userCollection = FirebaseFirestore.instance.collection('Users');
  final favCollection = FirebaseFirestore.instance.collection('Favorites');
  final vendorCollection = FirebaseFirestore.instance.collection('vendors');

  Future<bool> saveUserData(UserModels user) async {
    try {
      await userCollection.doc(user.uid).set(user.toJson());
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> saveFavoriteVendor(String uid, String vendorId) async {
    try {
      await favCollection.doc(uid).set({
        'vendorIds': FieldValue.arrayUnion([vendorId]),
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      return true;
    } catch (e) {}
    return false;
  }

  Future<List<String>> getFavoriteVendorIds(String uid) async {
    try {
      final doc = await favCollection.doc(uid).get();
      if (!doc.exists) return [];
      return List<String>.from(doc.data()?['vendorIds'] ?? []);
    } catch (e) {
      print('Error fetching favorite IDs: $e');
      return [];
    }
  }

  Future<List<VendorModel>> getVendorsByIds(List<String> vendorIds) async {
    if (vendorIds.isEmpty) return [];

    final query = await vendorCollection
        .where(FieldPath.documentId, whereIn: vendorIds)
        .get();

    return query.docs.map((doc) => VendorModel.fromDocument(doc)).toList();
  }

  Future<bool> removeFavoriteVendor(String uid, String vendorId) async {
    try {
      await favCollection.doc(uid).update({
        'vendorIds': FieldValue.arrayRemove([vendorId]),
      });
      return true;
    } catch (e) {
      print('Error removing favorite: $e');
      return false;
    }
  }
}
