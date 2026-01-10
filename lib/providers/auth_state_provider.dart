import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:vendors_discover/controllers/auth_controller.dart';
import 'package:vendors_discover/models/user_models.dart';
import 'package:vendors_discover/utils/custom_dialogs.dart';

class AuthStateProvider extends ChangeNotifier {
  final TextEditingController _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;

  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  final TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  final TextEditingController _confirmPasswordController =
      TextEditingController();
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;

  Future<void> signUp(BuildContext context) async {
    if (_nameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty ||
        _confirmPasswordController.text.trim().isEmpty) {
      CustomDialogs.showErrorSnackBar(context, 'Please fill in all fields');
      return;
    } else if (RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(_emailController.text) ==
        false) {
      CustomDialogs.showErrorSnackBar(
        context,
        'Please enter a valid email address',
      );
    } else if (_passwordController.text.trim().length < 6) {
      CustomDialogs.showErrorSnackBar(context, 'Password too weak');
      return;
    }

    if (_confirmPasswordController.text.trim() !=
        _passwordController.text.trim()) {
      CustomDialogs.showErrorSnackBar(context, "Password doesn't match");
      return;
    }

    EasyLoading.show(status: 'Creating Account...');

    final user = await AuthController().createUserAccount(
      context: context,
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    EasyLoading.dismiss();
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();

    if (user != null) {
      UserModels(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        uid: user.uid,
      );
    }
  }

  Future<void> signIn(BuildContext context) async {
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      CustomDialogs.showErrorSnackBar(
        context,
        'Please enter email and password',
      );
    } else if (RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(_emailController.text) ==
        false) {
      CustomDialogs.showErrorSnackBar(
        context,
        'Please enter a valid email address',
      );
    } else {
      EasyLoading.show();

      await AuthController().signIn(
        context: context,
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      EasyLoading.dismiss();
      _emailController.clear();
      _passwordController.clear();
    }
  }
}
