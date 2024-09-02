import 'dart:convert';
import 'package:SonicScape/ui/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
 // Make sure this import is correct

class ChangePasswordPage extends StatefulWidget {
  final String uniqueId;

  ChangePasswordPage({required this.uniqueId});

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _changePassword() async {
    if (_newPasswordController.text.trim() != _confirmPasswordController.text.trim()) {
      // Show error if passwords do not match
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Passwords do not match'),
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
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final url = 'https://jpgg7kp57h.execute-api.ap-south-1.amazonaws.com/sonicscape/organisations/${widget.uniqueId}/resetPassword';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'newPassword': _newPasswordController.text.trim()}),
      );

      if (response.statusCode == 200) {
        print('Password changed successfully');
        print('Response: ${response.body}');

        // Show success message or navigate to next screen
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Password Changed'),
            content: Text('Password changed successfully.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen()// Navigate to login page
                    ),
                    (Route<dynamic> route) => false, // Remove all previous routes
                  );
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        print('Failed to change password');
        print('Response: ${response.body}');
        _showErrorDialog('Failed to change password');
      }
    } catch (e) {
      print('Error changing password: $e');
      _showErrorDialog('Error changing password: $e');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _newPasswordController,
              decoration: InputDecoration(
                labelText: 'Enter New Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _changePassword,
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text('Save Password'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
