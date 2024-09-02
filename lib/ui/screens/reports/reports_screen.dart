import 'package:SonicScape/ui/controllers/reports_screen_controller.dart';
import 'package:SonicScape/ui/resources/strings.dart';
import 'package:SonicScape/ui/reusablewidgets/ss_data_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ReportsScreenController());
    return Scaffold(
      appBar: AppBar(
        title: Text(strTitleReports,
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
          padding: const EdgeInsets.only(right: 16),
          child: Column(
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
              ListTile(
                title: const Text(strAllIssues),
                subtitle: Obx(
                  () => Text(
                      (controller.reports.value?.noOfAllIssues.toString()) ??
                          strNoData),
                ),
              ),
              ListTile(
                title: const Text(strExisitingIssues),
                subtitle: Obx(
                  () => Text((controller.reports.value?.noOfExistingIssues
                          .toString()) ??
                      strNoData),
                ),
              ),
              ListTile(
                title: const Text(strClosedIssues),
                subtitle: Obx(
                  () => Text(
                      (controller.reports.value?.noOfClosedIssues.toString()) ??
                          strNoData),
                ),
              ),
              ListTile(
                title: const Text(strIdleTime),
                subtitle: Obx(
                  () => Text((controller.reports.value?.idleTime.toString()) ??
                      strNoData),
                ),
              ),
              ListTile(
                title: const Text(strRunningTime),
                subtitle: Obx(
                  () => Text(
                      (controller.reports.value?.runningTime.toString()) ??
                          strNoData),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
