import 'package:SonicScape/data/repository/mahine_repository.dart';
import 'package:SonicScape/data/service/session_service.dart';
import 'package:SonicScape/data/models/uimodels/ui_machine.dart';


class SessionRepository {
  final SessionService _service;
  final MachineRepository _machineRepository;

  SessionRepository(this._service, this._machineRepository);

  Future<UiMachine?> fetchCurrentSelectedMachine() async {
    var machineId = _service.machineId;
    if (machineId == null) throw "machineId should not be null";
    return (await _machineRepository.fetchMachineFromId(machineId));
  }

  String? fetchSelectedSensorId() {
    return _service.deviceId;
  }

  void selectMachine(UiMachine machine) {
    _service.deviceId = machine.uuid.first;
    _service.machineId = machine.machineId;
  }

  void selectMachineWithId(String machineId, String sensorId) {
    _service.deviceId = sensorId;
    _service.machineId = machineId;
  }
}
