import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:vendors_discover/utils/custom_dialogs.dart';

class AuthController {
  Future<User?> createUserAccount({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Logger().e('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use' && context.mounted) {
        CustomDialogs.showErrorSnackBar(
          context,
          'The account already exists for that email',
        );
      }
    } catch (error) {
      return null;
    }
    return null;
  }

  Future<User?> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential' && context.mounted) {
        CustomDialogs.showErrorSnackBar(
          context,
          'Please check your email and password',
        );
      }
    } catch (error) {
      return null;
    }
    return null;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
