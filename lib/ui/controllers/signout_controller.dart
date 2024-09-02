import 'package:SonicScape/ui/resources/strings.dart';
import 'package:SonicScape/ui/screens/login/login_screen.dart';
import 'package:SonicScape/ui/enums/signout_state.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:get/get.dart';

class SignoutController extends GetxController {
  var signoutState = Rx(SignoutState.confirmation);

  Future<void> signOut() async {
    signoutState.value = SignoutState.loading;
    var result = await Amplify.Auth.signOut();
    if (result is CognitoCompleteSignOut) {
      Get.offAll(() => const LoginScreen());
      signoutState.value = SignoutState.completed;
    } else if (result is CognitoFailedSignOut) {
      Get.back();
      Get.snackbar(
          signOutErrorTitle, '$signOutErrorMsg: ${result.exception.message}',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
