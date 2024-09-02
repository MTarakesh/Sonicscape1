import 'package:SonicScape/ui/screens/login/login_form.dart';
import 'package:SonicScape/ui/screens/login/login_header_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoginHeaderwidget(),
                const SizedBox(height: 10),
                LoginForm(),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
