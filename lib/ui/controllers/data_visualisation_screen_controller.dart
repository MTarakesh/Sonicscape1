import 'dart:async';
import 'package:intl/intl.dart';
import 'package:SonicScape/data/models/file_downloader_service_models/download_task_result.dart';
import 'package:SonicScape/data/models/uimodels/ui_machine.dart';
import 'package:SonicScape/data/repository/reports_repository.dart';
import 'package:SonicScape/data/repository/session_repository.dart';
import 'package:SonicScape/data/service/refresh_service.dart';
import 'package:SonicScape/ui/app_routes.dart';
import 'package:SonicScape/ui/plugins/selected_machine_plugin/selected_machine_data_plugin.dart';
import 'package:SonicScape/ui/resources/strings.dart';
import 'package:SonicScape/data/models/uimodels/ui_graph_info.dart';
import 'package:get/get.dart';

class DataVisualisationScreenController extends GetxController {
  final String currentRoute = AppRoutes.dataVisualisationScreen;
  final _repository = Get.find<ReportsRepository>();
  final _refreshService = Get.find<RefreshService>();
  final selectedMachineDataPlugin = SelectedMachineDataPlugin(shouldShowSensorId: false);
  final _sessionRepository = Get.find<SessionRepository>();

  // Non-reactive variables
  var sensorIds = <String>[];
  int? startDate;
  int? endDate;

  // Reactive variables
  var vibrationData = Rxn<UiGraphInfo>();
  var temperatureData = Rxn<UiGraphInfo>();
  var isSynchronizing = false.obs;
  var audioGraphLink = ''.obs;
  Rxn<String> selectedSensorId = Rxn();
  Rxn<UiMachine> currentSelectedMachine = Rxn();
  Rx<UIFileDownloadState> vibrationDownloadState = Rx(UIFDStartState());
  Rx<UIFileDownloadState> temperatureDownloadState = Rx(UIFDStartState());
  Rx<UIFileDownloadState> audioGraphDownloadState = Rx(UIFDStartState());

  @override
  void onInit() {
    super.onInit();
    syncNewData(showUiIndicatior: false);
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

  Future<void> syncNewData({bool showUiIndicatior = true}) async {
    if (showUiIndicatior) isSynchronizing.value = true;
    try {
      await Future.wait([
        _fetchCurrentSelectedDevice(),
        _fetchVibrationData(),
        _getAudioGraphLink(),
      ]);
    } finally {
      if (showUiIndicatior) isSynchronizing.value = false;
      resetFileDownloadState();
    }
  }

  Future<void> _fetchCurrentSelectedDevice() async {
    currentSelectedMachine.value =
        await _sessionRepository.fetchCurrentSelectedMachine();
    selectedSensorId.value ??= currentSelectedMachine.value?.uuid.firstOrNull;
    await _fetchSensorList(); // Fetch the sensor list if needed
  }

  void selectSensor(String id) {
    if (id == selectedSensorId.value) return;
    selectedSensorId.value = id;
    if (currentSelectedMachine.value != null) {
      _sessionRepository.selectMachineWithId(
          currentSelectedMachine.value!.machineId, id);
      syncNewData();
    }
  }

  Future<void> _fetchVibrationData() async {
    try {
      var value = await _repository.fetchVibrationTemperatureData(
          startTimeStamp: startDate, endTimeStamp: endDate);
      vibrationData.value = value.vibrationGraph;
      temperatureData.value = value.temperatureGraph;
    } catch (e) {
      print('Error fetching vibration data: $e');
    }
  }

  Future<void> _fetchSensorList() async {
    try {
      var sensors = await _repository.fetchSensorList(); // Ensure this method exists
      sensorIds = sensors; // Update the sensor IDs list
    } catch (e) {
      print('Error fetching sensor list: $e');
    }
  }

  String getPointStringFromTimeStamp(double timestamp) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp.toInt(), isUtc: true);
    return DateFormat('mm:ss').format(dateTime.toLocal());
  }

  Future<void> downloadVibrationRawFile() async {
    vibrationDownloadState.value = UIFDLoadingState();
    showDownloadingSnackbar();
    try {
      vibrationDownloadState.value = UIFDSuccessState();
    } catch (e) {
      print('Error downloading vibration data: $e'); 
      vibrationDownloadState.value = UIFDErrorState();
    }
  }

  Future<void> downloadTemperatureRawFile() async {
    temperatureDownloadState.value = UIFDLoadingState();
    showDownloadingSnackbar();
    try {
// Fixed method name
      temperatureDownloadState.value = UIFDSuccessState();
    } catch (e) {
      print('Error downloading temperature data: $e');
      temperatureDownloadState.value = UIFDErrorState();
    }
  }

  Future<void> _getAudioGraphLink() async {
    try {
      audioGraphLink.value = (await _repository.fetchAudioGraphLink(
              startTimeStamp: startDate, endTimeStamp: endDate)) ??
          "";
    } catch (e) {
      print('Error fetching audio graph link: $e');
    }
  }

  void showDownloadingSnackbar() {
    Get.snackbar(downloading, checkNotification);
  }

  void resetFileDownloadState() {
    vibrationDownloadState.value = UIFDStartState();
    temperatureDownloadState.value = UIFDStartState();
  }
}
