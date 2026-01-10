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
                        'Vendor Discover',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: Text(
                      authScreenType == 'signup'
                          ? 'Sign Up for connect with Vendors'
                          : authScreenType == 'signin'
                          ? 'Login to your account'
                          : 'Enter your email to reset your password',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  if (authScreenType == 'signup')
                    CustomTextField(
                      labelText: 'Name',
                      controller: authProvider.nameController,
                    ),
                  CustomTextField(
                    labelText: 'Email Address',
                    controller: authProvider.emailController,
                  ),
                  if (authScreenType != 'forgot')
                    CustomTextField(
                      labelText: 'Password',
                      isPassword: true,
                      controller: authProvider.passwordController,
                    ),
                  if (authScreenType == 'signup')
                    CustomTextField(
                      labelText: 'Confirm Password',
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
                          style: TextStyle(color: Colors.grey.shade600),
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
                          //forgot
                        }
                      });
                    },
                  ),
                  SizedBox(height: 15),
                  if (authScreenType != 'forgot')
                    Center(
                      child: Text(
                        authScreenType != 'signin'
                            ? 'Already have an account?'
                            : "Don't have an account?",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ),
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
