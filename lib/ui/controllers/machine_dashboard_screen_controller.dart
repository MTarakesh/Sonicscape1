import 'package:SonicScape/data/repository/session_repository.dart';
import 'package:SonicScape/data/service/refresh_service.dart';
import 'package:SonicScape/ui/app_routes.dart';
import 'package:SonicScape/ui/enums/menu_option.dart';
import 'package:SonicScape/data/models/uimodels/ui_machine.dart';
import 'package:SonicScape/data/models/uimodels/ui_machine_status.data.dart';
import 'package:SonicScape/data/repository/mahine_repository.dart';
import 'package:SonicScape/ui/screens/signout/signout_dialog.dart';
import 'package:SonicScape/ui/controllers/signout_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MachineDashboardScreenController extends GetxController {
  final _repository = Get.find<MachineRepository>();
  final RefreshService _refreshService = Get.find<RefreshService>();
  final SessionRepository _sessionRepository = Get.find<SessionRepository>();
  final currentRoute = AppRoutes.machineDashboardScreen;

  var machineMasterData = <UiMachine>[].obs;
  var machineStatusData = <UiMachineStatusData>[].obs;
  var isSynchronizing = false.obs;

  var textController = TextEditingController();
  var focusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    syncNewData(shouldUiIndicator: false);
    _listenForRefresh();
  }
  

  @override
  void onClose() {
    _refreshService.unRegisterForRefresh(currentRoute);
    super.onClose();
  }

  void _listenForRefresh() {
    _refreshService.registerForRefresh(currentRoute, () {
      if (Get.currentRoute == currentRoute) {
        syncNewData();
      }
    });
  }

  void stopSearching() {
    focusNode.unfocus();
  }

  void selectMachine(UiMachine item) {
    _sessionRepository.selectMachine(item);
  }

  Future<void> clearSearch() async {
    textController.clear();
    machineMasterData.value = (await _repository.fetchMachines()) ?? [];
  }

  Future<void> syncNewData({bool shouldUiIndicator = true}) async {
    if (shouldUiIndicator) isSynchronizing.value = true;
    await Future.wait([_getMachineMasterData(), _getMachineStatusData()]);
    if (shouldUiIndicator) isSynchronizing.value = false;
    return;
  }

  Future<void> _getMachineMasterData() async {
    machineMasterData.value = (await _repository.fetchMachines()) ?? [];
  }

  Future<void> searchForMachine(String searchText) async {
    machineMasterData.value =
        await _repository.searchForMachineMaster(searchText: searchText);
  }

  Future<void> _getMachineStatusData() async {
    machineStatusData.value = [
      UiMachineStatusData(
          status: false, machineId: "1", machineName: "Furnace 2"),
      UiMachineStatusData(
          status: true, machineId: "2", machineName: "Furnace 2")
    ];
  }

  void handleMenu(MenuOption option) {
    switch (option) {
      case MenuOption.signOut:
      default:
        {
          Get.put(SignoutController());
          Get.dialog(const SignOutDialog(), barrierDismissible: false);
        }
    }
  }
}