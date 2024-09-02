import 'package:SonicScape/data/service/network_service.dart';
import 'package:SonicScape/data/service/session_service.dart';
import 'package:SonicScape/data/models/network_service_models/machine.dart';
import 'package:SonicScape/data/models/network_service_models/machine_request.dart';
import 'package:SonicScape/data/models/network_service_models/update_issue_request.dart';
import 'package:SonicScape/data/models/uimodels/ui_machine_issue.dart';
import 'package:SonicScape/data/models/uimodels/ui_machine.dart';
import 'package:SonicScape/data/utils/extensions.dart';
import 'package:get/get.dart';

class MachineRepository {
  final NetworkService _service;
  final SessionService _sessionService;
  List<Machine>? _machineMasterCache = [];

  MachineRepository(this._service, this._sessionService);

  Future<void> registerMachine(MachineRequest machine) async {
    final orgId = _sessionService.orgId;

    try {
      await _service.registerMachine(orgId, machine);
    } catch (e) {
      // Handle error or log
      print('Failed to register machine: $e');
      rethrow;
    }
  }

  Future<List<UiMachine>> fetchMachines({bool fromCache = false}) async {
    if (fromCache && _machineMasterCache != null) {
      return _machineMasterCache!.map((e) => e.toUiMachine()).toList();
    }

    final orgId = _sessionService.orgId;

    try {
      final response = await _service.fetchMachines(orgId);
      final machines = response.data?.machines ?? [];
      _machineMasterCache = machines
          .where((machine) => machine.machineId != null)
          .toList();
      return _machineMasterCache!.map((e) => e.toUiMachine()).toList();
    } catch (e) {
      // Handle error or log
      print('Failed to fetch machines: $e');
      return [];
    }
  }

  Future<List<UiMachine>> searchForMachineMaster({required String searchText}) async {
    final data = _machineMasterCache?.where((machine) {
      final machineIdMatches = RegExp(".*$searchText.*", caseSensitive: false).hasMatch(machine.machineId ?? "");
      final machineNameMatches = RegExp(".*$searchText.*", caseSensitive: false).hasMatch(machine.name ?? "");
      final uuidsMatch = (machine.uuids ?? []).any((uuid) => RegExp(".*$searchText.*", caseSensitive: false).hasMatch(uuid));
      return machineIdMatches || machineNameMatches || uuidsMatch;
    }).map((e) => e.toUiMachine()).toList() ?? [];
    return data;
  }

  Future<UiMachine?> fetchMachineFromId(String machineId) async {
    try {
      return (await fetchMachines(fromCache: true))
          .firstWhereOrNull((machine) => machine.machineId == machineId);
    } catch (e) {
      // Handle error or log
      print('Failed to fetch machine from ID: $e');
      return null;
    }
  }

  Future<List<UiMachineIssue>> fetchIssuesForDevice({int? startTimeStamp, int? endTimeStamp}) async {
    final deviceId = _sessionService.deviceId;
    if (deviceId == null) {
      throw Exception("Device ID is not set in the session service");
    }

    try {
      final response = await _service.fetchIssues(
        deviceId,
        startTimeStamp ?? defaultStartTimestamp,
        endTimeStamp ?? defaultEndTimestamp,
      );
      return response.data?.toUiMachineIssue() ?? [];
    } catch (e) {
      // Handle error or log
      print('Failed to fetch issues for device: $e');
      return [];
    }
  }

  Future<void> updateMachineIssue(UpdateIssueRequest request) async {
    try {
      await _service.updateIssue(request.id, request);
    } catch (e) {
      // Handle error or log
      print('Failed to update machine issue: $e');
      rethrow;
    }
  }

  int get defaultStartTimestamp =>
      DateTime.now().subtract(const Duration(days: 15)).millisecondsSinceEpoch;

  int get defaultEndTimestamp => DateTime.now().millisecondsSinceEpoch;
}
