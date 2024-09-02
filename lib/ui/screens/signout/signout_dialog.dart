import 'package:SonicScape/ui/resources/strings.dart';
import 'package:SonicScape/ui/enums/signout_state.dart';
import 'package:SonicScape/ui/controllers/signout_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignOutDialog extends GetView<SignoutController> {
  const SignOutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.signoutState.value) {
        case SignoutState.confirmation:
          {
            return AlertDialog(
              title: const Text(confirmSignOut),
              content: const Text(confirmSignOutMsg),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text(cancel),
                ),
                TextButton(
                  onPressed: () {
                    controller.signOut();
                  },
                  child: const Text(signOut),
                ),
              ],
            );
          }
        case SignoutState.loading:
          {
            return const AlertDialog(
              title: Text(signOut),
              content: Row(
                children: [
                  Text(signOutLoading),
                  SizedBox(
                    width: 16,
                  ),
                  CircularProgressIndicator(),
                ],
              ),
            );
          }
        case SignoutState.completed:
        default:
          return const Text(signOut);
      }
    });
  }
}
