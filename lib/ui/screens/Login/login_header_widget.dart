import 'package:SonicScape/ui/resources/strings.dart';
import 'package:flutter/material.dart';

class LoginHeaderwidget extends StatelessWidget {
  const LoginHeaderwidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center( // Center the Column within its parent
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Center align the children horizontally
        children: [
          Image.asset(
            'assets/images/Sonic Scape logo.png',
            height: 150,
          ),
          SizedBox(height: 20),
          Text(
            loginTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          
          SizedBox(height: 40),
          Text(loginhead, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
