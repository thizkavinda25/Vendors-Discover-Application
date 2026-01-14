import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendors_discover/providers/auth_state_provider.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String authScreenType = 'signup';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<AuthStateProvider>(
        builder: (context, authProvider, child) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.villa_rounded,
                        color: Colors.pinkAccent,
                        size: 40,
                      ),
                      Text(
                        'Vendo Go',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      authScreenType == 'signup'
                          ? 'Sign Up for connect with Vendors'
                          : authScreenType == 'signin'
                          ? 'Login to your account'
                          : 'Enter your email to reset your password',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  if (authScreenType == 'signup')
                    CustomTextField(
                      hintText: 'Name',
                      icon: Icon(Icons.person, color: Colors.grey.shade500),
                      controller: authProvider.nameController,
                    ),
                  CustomTextField(
                    hintText: 'Email Address',
                    icon: Icon(
                      CupertinoIcons.mail_solid,
                      color: Colors.grey.shade500,
                    ),
                    controller: authProvider.emailController,
                  ),
                  if (authScreenType != 'forgot')
                    CustomTextField(
                      hintText: 'Password',
                      icon: Icon(
                        CupertinoIcons.padlock_solid,
                        color: Colors.grey.shade500,
                      ),
                      isPassword: true,
                      controller: authProvider.passwordController,
                    ),
                  if (authScreenType == 'signup')
                    CustomTextField(
                      hintText: 'Confirm Password',
                      icon: Icon(
                        CupertinoIcons.padlock_solid,
                        color: Colors.grey.shade500,
                      ),
                      isPassword: true,
                      controller: authProvider.confirmPasswordController,
                    ),
                  if (authScreenType == 'signin')
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            authScreenType = 'forgot';
                          });
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.pink),
                        ),
                      ),
                    ),
                  SizedBox(height: 30),
                  CustomButton(
                    text: authScreenType == 'signup'
                        ? 'Create Account'
                        : authScreenType == 'signin'
                        ? 'Login'
                        : 'Send',
                    onTap: () {
                      setState(() {
                        if (authScreenType == 'signup') {
                          authProvider.signUp(context);
                        } else if (authScreenType == 'signin') {
                          authProvider.signIn(context);
                        } else {
                          authProvider.resetPasswordLink(context);
                        }
                      });
                    },
                  ),
                  SizedBox(height: 15),
                  _orDivider(authScreenType),
                  SizedBox(height: 15),
                  CustomButton(
                    text: authScreenType == 'signup'
                        ? 'Sign In'
                        : authScreenType == 'signin'
                        ? 'Sign Up'
                        : 'Sign In',
                    isOutlineBorder: true,
                    onTap: () {
                      setState(() {
                        if (authScreenType == 'signin') {
                          authScreenType = 'signup';
                        } else {
                          authScreenType = 'signin';
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget _orDivider(String authScreenType) {
  return Row(
    children: [
      Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        child: Text(
          authScreenType == 'signup'
              ? 'Already have an account?'
              : authScreenType == 'signin'
              ? 'Don\'t have an account?'
              : 'Remember Me?',
          style: TextStyle(color: Colors.grey.shade500),
        ),
      ),
      Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
    ],
  );
}
