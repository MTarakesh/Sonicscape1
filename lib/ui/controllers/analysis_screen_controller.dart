import 'dart:async';

import 'package:SonicScape/data/service/refresh_service.dart';
import 'package:SonicScape/ui/app_routes.dart';
import 'package:SonicScape/data/models/uimodels/ui_analysis_data_point.dart';
import 'package:SonicScape/data/models/uimodels/ui_table_data.dart';
import 'package:SonicScape/data/repository/reports_repository.dart';
import 'package:SonicScape/ui/plugins/selected_machine_plugin/selected_machine_data_plugin.dart';
import 'package:SonicScape/ui/resources/strings.dart';
import 'package:get/get.dart';

enum Sensor { vibration, temperature, audio, vibrationToAudio }

class AnalysisScreenController extends GetxController {
  final _repository = Get.find<ReportsRepository>();
  final _refreshService = Get.find<RefreshService>();
  final String currentRoute = AppRoutes.analysisScreen;
  final selectedMachineDataPlugin = SelectedMachineDataPlugin();

  int? startDate;
  int? endDate;

  var selectedSensor = Rx(Sensor.vibration);
  var machineHealthStatus = true.obs;
  var machineRawData = "".obs;
  var analysisData = <UiAnalysisDataPoint>[].obs;
  var analysisRawTableData = Rx<UiTableData>(UiTableData(columns: [
    noDataFound
  ], rows: [
    Cells(cell: [loading])
  ]));
  var isSynchronizing = false.obs;

  @override
  void onInit() {
    super.onInit();
    syncNewData(shouldShowUiIndicator: false);
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

  void updateSelection(String selection) {
    var sensor = Sensor.values.byName(selection);
    if (sensor == selectedSensor.value) return;
    selectedSensor.value = sensor;
    syncNewData();
  }

  Future<void> syncNewData({bool shouldShowUiIndicator = true}) async {
    if (shouldShowUiIndicator) isSynchronizing.value = true;
    await Future.wait([
      _fetchSelectedMachineData(),
      _fetchAnalysisData(),
    ]);
    if (shouldShowUiIndicator) isSynchronizing.value = false;
  }

  Future<void> _fetchSelectedMachineData() async {
    Sensor sensor = selectedSensor.value;
    switch (sensor) {
      case Sensor.vibration:
        {
          analysisRawTableData.value =
              await _repository.fetchVibrationTableData(
                  startTimeStamp: startDate, endTimeStamp: endDate);
          break;
        }
      case Sensor.temperature:
        {
          analysisRawTableData.value =
              await _repository.fetchTemperatureTableData(
                  startTimeStamp: startDate, endTimeStamp: endDate);
          break;
        }
      case Sensor.audio:
        {
          analysisRawTableData.value = _generateTableDataForNoDataFound();
          break;
        }
      case Sensor.vibrationToAudio:
        {
          analysisRawTableData.value = _generateTableDataForNoDataFound();
          break;
        }
      default:
        {
          analysisRawTableData.value = _generateTableDataForNoDataFound();
          return;
        }
    }
    sensor == Sensor.vibration;
  }

  Future<void> _fetchAnalysisData() async {
    Sensor sensor = selectedSensor.value;
    switch (sensor) {
      case Sensor.vibration:
        {
          var response = (await _repository.fetchVibrationAnalysis(
              startTimeStamp: startDate, endTimeStamp: endDate));
          analysisData.value = response.analysis;
          machineHealthStatus.value = response.result;
          break;
        }
      case Sensor.vibrationToAudio:
        {
          var response = await _repository.getVibrationToAudioAnalysis(
              startTimeStamp: startDate, endTimeStamp: endDate);
          analysisData.value = response.analysis;
          machineHealthStatus.value = response.result;
          break;
        }
      case Sensor.temperature:
      case Sensor.audio:
      default:
        {
          analysisData.value = [_generateNoDataFoundForAnalysis()];
          return;
        }
    }
    sensor == Sensor.vibration;
  }

  UiAnalysisDataPoint _generateNoDataFoundForAnalysis() {
    return UiAnalysisDataPoint(name: noDataFound, value: 0, percentage: 0);
  }

  UiTableData _generateTableDataForNoDataFound() {
    return UiTableData(columns: [
      noDataFound
    ], rows: [
      Cells(cell: ["----"])
    ]);
  }
}
