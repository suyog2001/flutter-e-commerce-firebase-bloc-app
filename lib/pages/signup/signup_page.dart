import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  static const String route = '/signup';
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
        centerTitle: true,
      ),
    );
  }
}
