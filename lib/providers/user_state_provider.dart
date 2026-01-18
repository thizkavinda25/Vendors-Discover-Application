import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:vendors_discover/controllers/user_controller.dart';
import 'package:vendors_discover/models/vendor_model.dart';

class UserStateProvider extends ChangeNotifier {
  final UserController _userController = UserController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  StreamSubscription<User?>? _authSub;

  List<String> _favoriteVendorIds = [];
  List<VendorModel> _favoriteVendors = [];
  bool _isLoading = false;

  List<String> get favoriteVendorIds => _favoriteVendorIds;
  List<VendorModel> get favoriteVendors => _favoriteVendors;
  bool get isLoading => _isLoading;

  String? get currentUserId => _firebaseAuth.currentUser?.uid;

  UserStateProvider() {
    _authSub = _firebaseAuth.authStateChanges().listen((user) {
      if (user != null) {
        loadFavorites(); 
      } else {
        _favoriteVendorIds.clear();
        _favoriteVendors.clear();
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _authSub?.cancel();
    super.dispose();
  }

 
  Future<void> addFavorite(String vendorId) async {
    if (currentUserId == null) return;

    if (!_favoriteVendorIds.contains(vendorId)) {
      _favoriteVendorIds.add(vendorId);
      notifyListeners();
    }

    await _userController.saveFavoriteVendor(currentUserId!, vendorId);
    await _reloadVendorData();
  }

  
  Future<void> removeFavorite(String vendorId) async {
    if (currentUserId == null) return;

    _favoriteVendorIds.remove(vendorId);
    _favoriteVendors.removeWhere((v) => v.id == vendorId);
    notifyListeners();

    await _userController.removeFavoriteVendor(currentUserId!, vendorId);
  }

  bool isFavorite(String vendorId) {
    return _favoriteVendorIds.contains(vendorId);
  }

  
  Future<void> loadFavorites() async {
    if (currentUserId == null) return;

    _isLoading = true;
    notifyListeners();

    _favoriteVendorIds =
        await _userController.getFavoriteVendorIds(currentUserId!);

    await _reloadVendorData();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> _reloadVendorData() async {
    _favoriteVendors =
        await _userController.getVendorsByIds(_favoriteVendorIds);
    notifyListeners();
  }
}
