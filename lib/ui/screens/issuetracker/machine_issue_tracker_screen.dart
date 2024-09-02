import 'package:SonicScape/data/models/uimodels/ui_machine_issue.dart';
import 'package:SonicScape/ui/app_routes.dart';
import 'package:SonicScape/ui/controllers/machine_issue_tracker_screen_controller.dart';
import 'package:SonicScape/ui/resources/strings.dart';
import 'package:SonicScape/ui/reusablewidgets/ss_data_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MachineIssueTrackerScreen extends StatelessWidget {
  const MachineIssueTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<MachineIssuesTrasckerScreenController>();

    return Scaffold(
      appBar: AppBar(
          title: Text(
            strTitleIssue,
            style: Theme.of(context).textTheme.titleLarge,
          ),
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
          ]),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.reportsScreen);
                    },
                    child: const Text(
                      strReportsText,
                      style: TextStyle(color:  Colors.blue),
                    
                    ),
                  )
                ],
              ),
              Obx(() {
                // Sort the issues list by issue start time in descending order
                var sortedIssues = controller.machineIssues.toList()
                  ..sort((a, b) => b.issueStartTime.compareTo(a.issueStartTime));
                
                return IssuesDataTable(
                  issues: sortedIssues,
                  sync: () async {
                    controller.syncNewData();
                  },
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

class IssuesDataTable extends StatelessWidget {
  const IssuesDataTable({
    super.key,
    required this.issues,
    required this.sync,
  });

  final List<UiMachineIssue> issues;
  final Function() sync;

  bool isEditable(String fieldName) {
    var editPossibleList = [
      "approvedBySM",
      "issueClosed",
      "isIssueValid",
      "description"
    ];
    return editPossibleList.contains(fieldName);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: ([
          "ID",
          "Description",
          "IssueStartTime",
          "IssueEndTime",
          "ApprovedBySM",
          "IssueClosed",
          "IssueValidation",
        ].map((e) => DataColumn(label: Text(e))).toList()),
        rows: issues
            .map((issue) => DataRow(
                cells: issue
                    .toMap()
                    .map(
                      (issueName, issueValue) => MapEntry(
                        issueName,
                        isEditable(issueName)
                            ? DataCell(
                                onTap: () async {
                                  var result = await Get.toNamed(
                                      AppRoutes.machineIssueEditingScreen,
                                      arguments: issue);
                                  if (result == true) {
                                    sync();
                                  }
                                },
                                Text(
                                  issueValue.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: Colors.blue),
                                ),
                              )
                            : DataCell(
                                onTap: isEditable(issueName) ? () {} : null,
                                Text(issueValue.toString()),
                              ),
                      ),
                    )
                    .values
                    .toList()))
            .toList(),
      ),
    );
  }
}
