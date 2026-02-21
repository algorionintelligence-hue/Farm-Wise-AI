import 'package:farm_wise_ai/features/auth/view/loginScreen.dart';
import 'package:farm_wise_ai/features/auth/view/signup.dart';
import 'package:flutter/material.dart';


class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLogin = true;

  @override
  Widget build(BuildContext context) {
    return showLogin
        ? LoginScreen()
        : SignUpScreen();
  }
}