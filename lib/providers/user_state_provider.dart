import 'package:flutter/widgets.dart';

class UserStateProvider extends ChangeNotifier{
  final List<Map<String,dynamic>> _favorites = [];
  List<Map<String, dynamic>> get favorites => _favorites;

  void addToFavorite(Map<String,dynamic> vendor){
    _favorites.add(vendor);
    notifyListeners();
  }

  void removeFromFavorites(int index){
    _favorites.removeAt(index);
    notifyListeners();
  }
}