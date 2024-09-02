import 'package:SonicScape/data/models/uimodels/ui_machine.dart';
import 'package:SonicScape/data/repository/session_repository.dart';
import 'package:get/get.dart';

class SelectedMachinePluginController extends GetxController {
  final _sessionRepository = Get.find<SessionRepository>();
  Rxn<UiMachine> currentSelectedDevice = Rxn();
  String? get selectedSensorId => _sessionRepository.fetchSelectedSensorId();

  @override
  void onInit() {
    super.onInit();
    syncData();
  }

  void syncData() {
    _getCurrentSelectedDevice();
  }

  Future<void> _getCurrentSelectedDevice() async {
    currentSelectedDevice.value =
        await _sessionRepository.fetchCurrentSelectedMachine();
  }
}
