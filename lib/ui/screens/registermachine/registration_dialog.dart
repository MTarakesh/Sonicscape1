import 'package:SonicScape/ui/resources/strings.dart';
import 'package:SonicScape/ui/uistates/result_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationDialog extends StatelessWidget {
  const RegistrationDialog({
    super.key,
    required this.registrationState,
  });

  final ResultState registrationState;

  @override
  Widget build(BuildContext context) {
    switch (registrationState.runtimeType) {
      case Failed:
        return AlertDialog(
          title: const Text(failed),
          content: const Text(registrationFailedMsg),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text(ok),
            ),
          ],
        );
      case Success:
      default:
        return AlertDialog(
          title: const Text(success),
          content: const Text(registrationSuccessMsg),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(result: false);
              },
              child: const Text(ok),
            ),
            TextButton(
              onPressed: () {
                Get.back(result: true);
              },
              child: const Text(addMore),
            ),
          ],
        );
    }
  }
}
