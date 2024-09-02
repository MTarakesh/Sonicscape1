import 'package:SonicScape/data/models/file_downloader_service_models/download_task_result.dart';
import 'package:SonicScape/ui/reusablewidgets/ss_data_range_picker.dart';
import 'package:SonicScape/ui/utils/graph_utils.dart';
import 'package:SonicScape/ui/controllers/data_visualisation_screen_controller.dart';
import 'package:SonicScape/ui/resources/strings.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataVisualisationScreen extends StatelessWidget {
  const DataVisualisationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(DataVisualisationScreenController());
    return Scaffold(
      appBar: AppBar(
        title: Text(strTitleDataVisualisation,
            style: Theme.of(context).textTheme.titleLarge),
        actions: [
          Obx(
            () => controller.isSynchronizing.value
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(synchonizing),
                  )
                : IconButton(
                    onPressed: () => controller.syncNewData(),
                    icon: const Icon(Icons.sync),
                  ),
          )
        ],
        backgroundColor: const Color.fromARGB(255, 247, 247, 247),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0, top: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              controller.selectedMachineDataPlugin.view(),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: SSDataRangePicker(
                  label: strReportsFromToDate,
                  onDateChanged: (fromDate, toDate) {
                    controller.startDate = fromDate.millisecondsSinceEpoch;
                    controller.endDate = toDate.millisecondsSinceEpoch;
                    controller.syncNewData();
                  },
                ),
              ),
              SensorSelector(controller: controller),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: SizedBox(
                  height: 150,
                  child: VibrationChart(controller: controller),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: SizedBox(
                  height: 150,
                  child: AudioChart(controller: controller),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: SizedBox(
                  height: 150,
                  child: TemperatureChart(controller: controller),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TemperatureChart extends StatelessWidget {
  const TemperatureChart({
    super.key,
    required this.controller,
  });

  final DataVisualisationScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => DownloadRawDataWidget(
            downloadState: controller.temperatureDownloadState.value,
            onClicked: () => controller.downloadTemperatureRawFile(),
            title: temperatureData,
          ),
        ),
        Obx(() => controller.temperatureData.value != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                child: LineChart(
                  LineChartData(
                    lineBarsData: controller.temperatureData.value!.graphLineValues,
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          getTitlesWidget: (value, metaData) {
                            var data = getPointStringFromTimeStamp(value);
                            return Text(data);
                          },
                          showTitles: true,
                          interval: controller.temperatureData.value!.intervalX,
                        ),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          getTitlesWidget: (value, metaData) {
                            return Text(value.toString());
                          },
                          showTitles: true,
                          reservedSize: 44,
                          interval: controller.temperatureData.value!.intervalY,
                        ),
                      ),
                    ),
                    minX: controller.temperatureData.value!.minX,
                    maxX: controller.temperatureData.value!.maxX,
                    minY: controller.temperatureData.value!.minY,
                    maxY: controller.temperatureData.value!.maxY,
                  ),
                ),
              )
            : const SizedBox()),
      ],
    );
  }
}

class DownloadRawDataWidget extends StatelessWidget {
  const DownloadRawDataWidget({
    super.key,
    required this.downloadState,
    required this.onClicked,
    required this.title,
  });

  final UIFileDownloadState? downloadState;
  final Function onClicked;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Builder(
            builder: (context) {
              switch (downloadState.runtimeType) {
                case UIFDLoadingState:
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(),
                    ),
                  );

                case UIFDSuccessState:
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Icon(Icons.check),
                  );

                case UIFDErrorState:
                  return Row(
                    children: [
                      Text(
                        tryAgain,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.error),
                      ),
                      IconButton(
                        onPressed: () => onClicked(),
                        icon: const Icon(Icons.refresh),
                      )
                    ],
                  );

                case UIFDStartState:
                default:
                  return IconButton(
                    onPressed: () => onClicked(),
                    icon: const Icon(Icons.file_download_rounded),
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}

class AudioChart extends StatelessWidget {
  const AudioChart({
    super.key,
    required this.controller,
  });

  final DataVisualisationScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 8, top: 16),
          alignment: Alignment.centerLeft,
          child: const Text(audioData),
        ),
        Obx(() => controller.audioGraphLink.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: controller.audioGraphLink.value == loading
                    ? const Text(loading)
                    : Image.network(controller.audioGraphLink.value),
              )
            : const SizedBox()),
      ],
    );
  }
}

class VibrationChart extends StatelessWidget {
  const VibrationChart({
    super.key,
    required this.controller,
  });

  final DataVisualisationScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => DownloadRawDataWidget(
            downloadState: controller.vibrationDownloadState.value,
            onClicked: () => controller.downloadVibrationRawFile(),
            title: vibrationData,
          ),
        ),
        Obx(() => controller.vibrationData.value != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                child: LineChart(
                  LineChartData(
                    lineBarsData: controller.vibrationData.value!.graphLineValues,
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          getTitlesWidget: (value, metaData) {
                            var data = getPointStringFromTimeStamp(value);
                            return Text(data);
                          },
                          showTitles: true,
                          interval: controller.vibrationData.value!.intervalX,
                        ),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          getTitlesWidget: (value, metaData) {
                            return Text(value.toString());
                          },
                          showTitles: true,
                          interval: controller.vibrationData.value!.intervalY,
                          reservedSize: 44,
                        ),
                      ),
                    ),
                    minX: controller.vibrationData.value!.minX,
                    maxX: controller.vibrationData.value!.maxX,
                    minY: controller.vibrationData.value!.minY,
                    maxY: controller.vibrationData.value!.maxY,
                  ),
                ),
              )
            : const SizedBox()),
      ],
    );
  }
}

class SensorSelector extends StatelessWidget {
  const SensorSelector({
    super.key,
    required this.controller,
  });

  final DataVisualisationScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 16.0),
      child: Obx(
        () => DropdownButton<String>(
          value: controller.selectedSensorId.value,
          onChanged: (String? newValue) {
            if (newValue != null) {
              controller.selectedSensorId.value = newValue;
              controller.syncNewData();
            }
          },
          items: controller.sensorIds
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
