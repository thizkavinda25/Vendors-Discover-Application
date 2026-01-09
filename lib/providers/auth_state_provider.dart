import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:vendors_discover/controllers/auth_controller.dart';
import 'package:vendors_discover/utils/custom_dialogs.dart';

class AuthStateProvider extends ChangeNotifier {
  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  final TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  final TextEditingController _confirmPasswordController =
      TextEditingController();
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;

  Future<void> signUp(BuildContext context) async {
    if (_emailController.text.trim().length < 3) {
      CustomDialogs.showErrorSnackBar(context, 'Please enter a valid email');
      return;
    }

    if (_passwordController.text.trim().length < 6) {
      CustomDialogs.showErrorSnackBar(context, 'Password too weak');
      return;
    }

    if (_confirmPasswordController.text.trim() !=
        _passwordController.text.trim()) {
      CustomDialogs.showErrorSnackBar(context, "Password doesn't match");
      return;
    }

    EasyLoading.show(status: 'Creating Account...');

    await AuthController().createUserAccount(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    EasyLoading.dismiss();

    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
  }
}
