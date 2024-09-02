import 'package:SonicScape/ui/resources/strings.dart';
import 'package:flutter/material.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
        ),
        TextButton(
            onPressed: () {},
            child: Text.rich(TextSpan(
                text: donthaveaccount,
                style: Theme.of(context).textTheme.bodySmall,
                children: const [
                  TextSpan(text: signup, style: TextStyle(color: Colors.blue))
                ])))
      ],
    );
  }
}
