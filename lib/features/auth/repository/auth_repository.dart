import 'package:farm_wise_ai/features/auth/view/loginScreen.dart';
import 'package:farm_wise_ai/features/auth/view/signUpScreen.dart';
import 'package:flutter/material.dart';


class AuthRepository extends StatefulWidget {
  const AuthRepository({super.key});

  @override
  State<AuthRepository> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthRepository> {
  bool showLogin = true;

  @override
  Widget build(BuildContext context) {
    return showLogin
        ? LoginScreen()
        : SignUpScreen();
  }

  void navigateToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) =>  LoginScreen()),
    );
  }

  void navigateToSignup(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) =>  SignUpScreen()),
    );
  }
}