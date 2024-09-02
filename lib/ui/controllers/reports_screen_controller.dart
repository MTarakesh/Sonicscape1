import 'package:SonicScape/data/models/uimodels/ui_reports_data.dart';
import 'package:SonicScape/data/repository/reports_repository.dart';
import 'package:SonicScape/ui/app_routes.dart';
import 'package:SonicScape/ui/plugins/selected_machine_plugin/selected_machine_data_plugin.dart';
import 'package:get/get.dart';

class ReportsScreenController extends GetxController {
  final String currentRoute = AppRoutes.reportsScreen;
  final _repository = Get.find<ReportsRepository>();
  final selectedMachineDataPlugin =
      SelectedMachineDataPlugin(shouldShowSensorId: false);

  int? startDate;
  int? endDate;

  var isSynchronizing = false.obs;
  Rxn<UiReportsData> reports = Rxn();

  @override
  void onInit() {
    super.onInit();
    syncNewData(showUiIndicatior: false);
  }

  void syncNewData({bool showUiIndicatior = true}) async {
    if (showUiIndicatior) isSynchronizing.value = true;
    await Future.wait([_fetchReports()]);
    if (showUiIndicatior) isSynchronizing.value = false;
  }

  Future<void> _fetchReports() async {
    reports.value = await _repository.fetchReports(
        startTimeStamp: startDate, endTimeStamp: endDate);
  }
}
