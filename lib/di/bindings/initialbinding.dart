import 'package:SonicScape/data/repository/mahine_repository.dart';
import 'package:get/get.dart';
import 'package:SonicScape/data/service/network_service.dart';
import 'package:SonicScape/data/service/session_service.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    final networkService = Get.find<NetworkService>();  // Get the registered NetworkService
    final sessionService = Get.find<SessionService>();  // Get the registered SessionService
    Get.put(MachineRepository(networkService, sessionService));  // Register MachineRepository
  }
}
