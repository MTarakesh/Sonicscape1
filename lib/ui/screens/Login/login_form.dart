import 'dart:convert';
import 'package:SonicScape/data/models/uimodels/ui_login_data.dart';
import 'package:SonicScape/ui/app_routes.dart';
import 'package:SonicScape/ui/resources/strings.dart';
import 'package:SonicScape/ui/screens/forgotpassword/forgot_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';


class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _signIn() async {
    setState(() {
      _isLoading = true;
    });

    final token = await FirebaseMessaging.instance.getToken();
    print('FCM Token: $token');

    final url = 'https://jpgg7kp57h.execute-api.ap-south-1.amazonaws.com/sonicscape/login';
    final body = jsonEncode({
      'uniqueId': _usernameController.text.trim(),
      'password': _passwordController.text.trim(),
      'deviceToken': token, // Send the device token to your backend
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        print('Response body decoded: $responseBody');

        if (responseBody['message'] == 'Login successful') {
          Get.offAllNamed(AppRoutes.navigationScreen,
            arguments: UiLoginData(orgId: _usernameController.text));
        } else {
          _showErrorDialog('Wrong username or password');
        }
      } else {
        _showErrorDialog('Failed to sign in');
      }
    } catch (e) {
      print('Sign in failed: $e');
      _showErrorDialog('Error signing in: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showForgotPasswordDialog(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ForgotPasswordScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.input),
                labelText: uniqueID,
                hintText: uniqueID,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.password),
                labelText: password,
                hintText: password,
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: null,
                  icon: Icon(Icons.remove_red_eye_sharp),
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  _showForgotPasswordDialog(context);
                },
                child: Text(forgetpassword),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _signIn,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  backgroundColor: Colors.black,
                ),
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        login.toUpperCase(),
                        style: TextStyle(color: Color.fromARGB(255, 249, 249, 249)),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
