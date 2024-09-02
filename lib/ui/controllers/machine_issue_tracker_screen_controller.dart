import 'package:SonicScape/data/models/uimodels/ui_machine.dart';
import 'package:SonicScape/data/models/uimodels/ui_machine_issue.dart';
import 'package:SonicScape/data/repository/mahine_repository.dart';
import 'package:SonicScape/data/service/refresh_service.dart';
import 'package:SonicScape/ui/app_routes.dart';
import 'package:SonicScape/ui/plugins/selected_machine_plugin/selected_machine_data_plugin.dart';
import 'package:get/get.dart';

class MachineIssuesTrasckerScreenController extends GetxController {
  final _refreshService = Get.find<RefreshService>();
  final _repository = Get.find<MachineRepository>();
  final selectedMachineDataPlugin = SelectedMachineDataPlugin();

  int? startDate;
  int? endDate;

  var isSynchronizing = false.obs;
  Rxn<UiMachine> currentSelectedDevice = Rxn();
  var machineIssues = <UiMachineIssue>[].obs;

  var currentRoute = AppRoutes.machineIssueTrackerScreen;

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

  Future<void> syncNewData({bool shouldUiIndicator = true}) async {
    if (shouldUiIndicator) isSynchronizing.value = true;
    await Future.wait([_fetchMachineIssues()]);
    if (shouldUiIndicator) isSynchronizing.value = false;
    return;
  }

  Future<void> _fetchMachineIssues() async {
    machineIssues.value = await _repository.fetchIssuesForDevice(
        startTimeStamp: startDate, endTimeStamp: endDate);
  }
}
