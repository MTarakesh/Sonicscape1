import 'package:SonicScape/data/repository/mahine_repository.dart';
import 'package:SonicScape/data/service/session_service.dart';
import 'package:SonicScape/ui/controllers/register_machine_screen_controller.dart';
import 'package:get/get.dart';
import 'package:SonicScape/data/service/network_service.dart';

class RegisterMachineBinding extends Bindings {
  @override
  void dependencies() {
    final networkService = Get.find<NetworkService>();  // Get the registered NetworkService
    final sessionService = Get.find<SessionService>();  // Get the registered SessionService
    Get.lazyPut<MachineRepository>(() => MachineRepository(networkService, sessionService));
    Get.lazyPut<RegisterMachineScreenController>(() => RegisterMachineScreenController());
  }
}
