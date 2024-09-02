import 'package:SonicScape/data/models/file_downloader_service_models/download_task_result.dart';
import 'package:SonicScape/data/models/network_service_models/analysis_data_point.dart';
import 'package:SonicScape/data/models/network_service_models/machine.dart';
import 'package:SonicScape/data/models/network_service_models/machine_issues.dart';
import 'package:SonicScape/data/models/network_service_models/reports_data.dart';
import 'package:SonicScape/data/models/uimodels/ui_analysis_data_point.dart';
import 'package:SonicScape/data/models/uimodels/ui_machine.dart';
import 'package:SonicScape/data/models/uimodels/ui_machine_issue.dart';
import 'package:SonicScape/data/models/uimodels/ui_reports_data.dart';
import 'package:SonicScape/ui/resources/strings.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:intl/intl.dart';

extension UiDataConversion on DownloadTaskStatus {
  UIFileDownloadState toUIFileDownloadState() {
    switch (this) {
      // Failed
      case DownloadTaskStatus.undefined:
      case DownloadTaskStatus.canceled:
      case DownloadTaskStatus.failed:
        return UIFDErrorState();
      // Loading
      case DownloadTaskStatus.enqueued:
      case DownloadTaskStatus.running:
        return UIFDLoadingState();
      // Success
      case DownloadTaskStatus.complete:
      default:
        return UIFDLoadingState();
    }
  }
}

extension UiMachineConversion on Machine {
  UiMachine toUiMachine() {
    return UiMachine(
        uuid: uuids ?? [],
        machineId: machineId ?? strNoData,
        name: name ?? strNoData,
        type: type ?? strNoData,
        lastServiceDate: lastServiceDate ?? 0,
        nextServiceDate: nextServiceDate ?? 0,
        age: age ?? 0);
  }
}

extension UiAnalysisDataPoinConvertion on AnalysisDataPoint {
  UiAnalysisDataPoint toUiAnalysisDataPoint() {
    var tempMin = min!;
    var tempMax = max!;
    var tempValue = value!;
    if (tempMin < 0) tempMin = -1 * tempMin;
    if (tempMax < 0) tempMax = -1 * tempMax;
    if (tempValue < 0) tempValue = -1 * tempValue;
    if (max != null && min != null && value != null) {
      var calculatedValue = (tempValue / (tempMax + tempMin));
      return UiAnalysisDataPoint(
          name: "$name",
          value: calculatedValue,
          percentage: calculatedValue * 100);
    } else {
      return UiAnalysisDataPoint(name: "$name", value: 0, percentage: 0);
    }
  }
}

extension UiReportsConverters on ReportsData {
  UiReportsData toUiReportsData() {
    return UiReportsData(
        noOfAllIssues: noOfAllIssues ?? 0,
        noOfExistingIssues: noOfExistingIssues ?? 0,
        noOfClosedIssues: noOfClosedIssues ?? 0,
        idleTime: idleTime ?? 0,
        runningTime: runningTime ?? 0);
  }
}

extension BoolFromDouble on double? {
  bool toBool() {
    if (this == 0.0) {
      return false;
    } else {
      return true;
    }
  }
}

extension BoolFromInt on int? {
  bool toBool() {
    if (this == 0) {
      return false;
    } else {
      return true;
    }
  }
}

extension StringConverters on int {
  String toYears() {
    if (this == 1) {
      return "$this Year";
    } else {
      return "$this Years";
    }
  }
}

extension DateConverters on int {
  String toHumanRedableFormatNoTime() {
    final dateFormat = DateFormat('dd-MM-yyyy ');
    return dateFormat.format(DateTime.fromMillisecondsSinceEpoch(this));
  }

  String toHumanRedableFormat() {
    final dateFormat = DateFormat('dd-MM-yyyy HH:mm:ss');
    return dateFormat.format(DateTime.fromMillisecondsSinceEpoch(this));
  }
}

extension DateUtils on DateTime {
  String toHumanRedableFormatNoTime() {
    final dateFormat = DateFormat('dd-MM-yyyy ');
    return dateFormat.format(this);
  }

  String toHumanRedableFormat() {
    final dateFormat = DateFormat('dd-MM-yyyy HH:mm:ss');
    return dateFormat.format(this);
  }
}

extension IssueTrackerUtils on MachineIssues {
  List<UiMachineIssue> toUiMachineIssue() {
    return issues
        .where((element) => element.id != null)
        .map((e) => UiMachineIssue(
              id: e.id!,
              description: e.description ?? strNoData,
              issueStartTime:
                  e.issueStartTime?.toHumanRedableFormat() ?? strNoData,
              issueEndTime: e.issueEndTime?.toHumanRedableFormat() ?? strNoData,
              approvedBySM: e.approvedBySM.toBool(),
              issueClosed: e.issueClosed.toBool(),
              isIssueValid: e.isIssueValid.toBool(),
            ))
        .toList();
  }
}

extension BoolConvertors on String {
  bool toBool() {
    if (this == true.toString()) {
      return true;
    } else {
      return false;
    }
  }
}

extension BoolToIntConvertors on bool {
  int toInt() {
    if (true == this) {
      return 1;
    } else {
      return 0;
    }
  }
}
