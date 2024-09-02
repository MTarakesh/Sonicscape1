import 'package:SonicScape/ui/screens/OTP%20page/otp_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
 // Add this import for jsonEncode

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController _uniqueIdController = TextEditingController();

  Future<void> _sendUniqueId(BuildContext context, String uniqueId) async {
    final url = 'https://jpgg7kp57h.execute-api.ap-south-1.amazonaws.com/sonicscape/organisations/$uniqueId/forgotPassword';

    try {
      final response = await http.post(Uri.parse(url));

      if (response.statusCode == 200) {
        print('Unique ID sent successfully: $uniqueId');
        print('Response: ${response.body}');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OTPPage(uniqueId: uniqueId),
          ),
        );
      } else {
        print('Failed to send Forgot Password request');
        print('Response: ${response.body}');
        _showErrorDialog(context, 'Failed to send Forgot Password request');
      }
    } catch (e) {
      print('Error sending unique ID: $e');
      _showErrorDialog(context, 'Error sending unique ID: $e');
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
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
        title: Text('Contact Admin'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _uniqueIdController,
              decoration: InputDecoration(
                labelText: 'Unique ID',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final uniqueId = _uniqueIdController.text.trim();
                  if (uniqueId.isNotEmpty) {
                    _sendUniqueId(context, uniqueId);
                  } else {
                    _showErrorDialog(context, 'Please enter a Unique ID');
                  }
                },
                child: Text('Send'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
