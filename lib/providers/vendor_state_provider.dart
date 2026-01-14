import 'package:flutter/material.dart';
import '../controllers/vendor_controller.dart';
import '../models/vendor_model.dart';

class VendorStateProvider extends ChangeNotifier {
  final VendorController _vendorController = VendorController();

  List<VendorModel> _vendors = [];
  List<VendorModel> get vendors => _vendors;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  
  void fetchVendors() {
    _vendorController.fetchActiveVendors().listen((vendorList) {
      _vendors = vendorList;
      _isLoading = false;
      notifyListeners();
    });
  }
}
