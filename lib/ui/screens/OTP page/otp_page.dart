import 'package:SonicScape/ui/screens/Reset_password/reset_passwordpage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Ensure this import is correct


class OTPPage extends StatefulWidget {
  final String uniqueId;

  OTPPage({required this.uniqueId});

  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final _otpController = TextEditingController();
  bool _isLoading = false;

  Future<void> _verifyOTP() async {
    setState(() {
      _isLoading = true;
    });

    final url = 'https://jpgg7kp57h.execute-api.ap-south-1.amazonaws.com/sonicscape/organisations/${widget.uniqueId}/otpVerification';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'otp': _otpController.text.trim()}),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        // If the response body is an int, compare directly
        if (responseBody == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangePasswordPage(uniqueId: widget.uniqueId),
            ),
          );
        } else {
          _showErrorDialog('Invalid OTP');
        }
      } else {
        _showErrorDialog('Failed to verify OTP');
      }
    } catch (e) {
      print('Error verifying OTP: $e');
      _showErrorDialog('Error verifying OTP: $e');
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
        title: Text('OTP Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _otpController,
              decoration: InputDecoration(
                labelText: 'Enter OTP',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _verifyOTP,
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text('Verify OTP'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
