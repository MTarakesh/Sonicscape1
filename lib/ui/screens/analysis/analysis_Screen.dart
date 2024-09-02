import 'package:SonicScape/ui/app_routes.dart';
import 'package:SonicScape/ui/controllers/analysis_screen_controller.dart';
import 'package:SonicScape/data/models/uimodels/ui_analysis_data_point.dart';
import 'package:SonicScape/ui/resources/strings.dart';
import 'package:SonicScape/ui/reusablewidgets/ss_data_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AnalysisScreenController());
    return Scaffold(
      appBar: AppBar(
        title: Text(strTitleAnalysis,
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
        child: Container(
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
              MachineHealthStatus(controller: controller),
              AnalysisWidget(controller: controller),
              RawSensorDataTable(controller: controller),
            ],
          ),
        ),
      ),
    );
  }
}

class RawSensorDataTable extends StatelessWidget {
  const RawSensorDataTable({
    super.key,
    required this.controller,
  });

  final AnalysisScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 16,
            left: 16,
          ),
          child: Text(
            rawSensorData,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            bottom: 8,
          ),
          child: Obx(() => DataTable(
              horizontalMargin: 0,
              columns: controller.analysisRawTableData.value.columns
                  .map(
                    (e) => DataColumn(
                      label: Text(e),
                    ),
                  )
                  .toList(),
              rows: controller.analysisRawTableData.value.rows
                  .map(
                    (e) => DataRow(
                      cells: e.cell
                          .map(
                            (e) => DataCell(
                              Text(e),
                            ),
                          )
                          .toList(),
                    ),
                  )
                  .toList())),
        ),
      ],
    );
  }
}

class AnalysisWidget extends StatelessWidget {
  const AnalysisWidget({
    super.key,
    required this.controller,
  });

  final AnalysisScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 16,
            left: 16,
          ),
          child: Text(
            analysisData,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8, top: 8),
          child: Obx(
            () => Column(
              children: controller.analysisData
                  .map((element) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: PercentageBar(data: element),
                      ))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class MachineHealthStatus extends StatelessWidget {
  const MachineHealthStatus({
    super.key,
    required this.controller,
  });

  final AnalysisScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        bottom: 8,
      ),
      child: Obx(
        () => controller.machineHealthStatus.value
            ? Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.thumb_up,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      machineDoingWell,
                    ),
                  ],
                ),
              )
            : Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Row(
                  children: [
                    const Icon(
                      Icons.thumb_down,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      machineNeedsAssistance,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class SensorSelector extends StatelessWidget {
  const SensorSelector({
    super.key,
    required this.controller,
  });

  final AnalysisScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        bottom: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(
            () => DropdownButton<String>(
              value: controller.selectedSensor.value.name,
              elevation: 16,
              onChanged: (String? value) {
                if (value != null) {
                  controller.updateSelection(value);
                }
              },
              items: Sensor.values
                  .toList()
                  .map<DropdownMenuItem<String>>((Sensor value) {
                return DropdownMenuItem<String>(
                  value: value.name,
                  child: Text(
                    value.name,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                );
              }).toList(),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.toNamed(AppRoutes.machineIssueTrackerScreen);
            },
            child: const Text(
              sesnorIssues,
              style: TextStyle(color: Colors.blue),
              
            ),
          )
        ],
      ),
    );
  }
}

class PercentageBar extends StatelessWidget {
  const PercentageBar({
    super.key,
    required this.data,
  });
  final UiAnalysisDataPoint data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              data.name.capitalize ?? data.name,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Text(
              "${data.percentage} %",
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        LinearProgressIndicator(
          value: data.value,
          color: fetchColorForValue(data.value, context),
          borderRadius: BorderRadius.circular(16),
          minHeight: 28,
        )
      ],
    );
  }

  Color fetchColorForValue(double value, BuildContext context) {
    switch (value) {
      case < .5:
        return Theme.of(context).colorScheme.error;
      case >= .5 && < .6:
        return Colors.yellow;
      case >= .6:
      default:
        return Colors.green;
    }
  }
}
