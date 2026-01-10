import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vendors_discover/models/user_models.dart';

class UserController {
  final userCollection = FirebaseFirestore.instance.collection('Users');
  Future<bool> saveUserData(UserModels user)async{
    try {
      await userCollection.doc(user.uid).set(user.toJson());
      return true;
    } catch (error) {
      return false;
    }
  }
}
