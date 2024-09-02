import 'dart:math';

import 'package:SonicScape/data/models/file_downloader_service_models/download_task_result.dart';
import 'package:SonicScape/data/models/network_service_models/analysis_data_point.dart';
import 'package:SonicScape/data/models/network_service_models/reports_data.dart';
import 'package:SonicScape/data/models/network_service_models/sensor_data_point.dart';
import 'package:SonicScape/data/models/network_service_models/vibration_data.dart';
import 'package:SonicScape/data/models/uimodels/ui_reports_data.dart';
import 'package:SonicScape/data/service/network_service.dart';
import 'package:SonicScape/data/service/file_downloader_service.dart';
import 'package:SonicScape/data/service/session_service.dart';
import 'package:SonicScape/data/utils/extensions.dart';
import 'package:SonicScape/data/models/uimodels/ui_analysis_data.dart';
import 'package:SonicScape/data/models/uimodels/ui_vibration_temperature_data.dart';
import 'package:SonicScape/ui/resources/strings.dart';
import 'package:SonicScape/data/models/uimodels/ui_graph_info.dart';
import 'package:SonicScape/data/models/uimodels/ui_table_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';

class ReportsRepository {
  final NetworkService _service = Get.find<NetworkService>();
  final FileDownloaderService _fileDownloaderService =
      Get.find<FileDownloaderService>();
  final _sessionService = Get.find<SessionService>();

  ReportsRepository({service});
  Future<UiVibrationTemperatureData> fetchVibrationTemperatureData(
      {int? startTimeStamp, int? endTimeStamp}) async {
    try {
      var result = (await _service.fetchVibrationData(
              _sessionService.deviceId!,
              startTimeStamp ?? defaultStartTimestamp,
              endTimeStamp ?? defaultEndTimestamp))
          .data;
      return UiVibrationTemperatureData(
          vibrationGraph: _getVibrationData(result?.vibration),
          temperatureGraph: _getTemperatureData(result?.temperature));
    } catch (_) {
      return UiVibrationTemperatureData(
          vibrationGraph: noGraphData(), temperatureGraph: noGraphData());
    }
  }

  Future<UiTableData> fetchTemperatureTableData(
      {int? startTimeStamp, int? endTimeStamp}) async {
    try {
      if (_sessionService.deviceId == null) {
        throw "Device id should not be null";
      }
      var response = (await _service.fetchVibrationData(
              _sessionService.deviceId!,
              startTimeStamp ?? defaultStartTimestamp,
              endTimeStamp ?? defaultEndTimestamp))
          .data;
      if (response != null && response.temperature != null) {
        return UiTableData(
            columns: [time, temperature],
            rows: response.temperature!
                .map((e) => Cells(cell: [
                      e.timestamp != null
                          ? e.timestamp!.toHumanRedableFormatNoTime()
                          : strNoData,
                      e.value.toString()
                    ]))
                .toList());
      } else {
        return noTableData();
      }
    } catch (_) {
      return noTableData();
    }
  }

  Future<UiTableData> fetchVibrationTableData(
      {int? startTimeStamp, int? endTimeStamp}) async {
    try {
      var response = (await _service.fetchVibrationData(
              _sessionService.deviceId!,
              startTimeStamp ?? defaultStartTimestamp,
              endTimeStamp ?? defaultEndTimestamp))
          .data;
      if (response != null &&
          response.vibration != null &&
          response.vibration!.x != null &&
          response.vibration!.y != null &&
          response.vibration!.z != null) {
        List<Cells> rows = [];
        for (var i = 0; i < response.vibration!.x!.length; i++) {
          rows.add(Cells(cell: [
            response.vibration?.x?[i].timestamp != null
                ? response.vibration!.x![i].timestamp!.toHumanRedableFormat()
                : strNoData,
            response.vibration!.x![i].value.toString(),
            response.vibration!.y![i].value.toString(),
            response.vibration!.z![i].value.toString()
          ]));
        }
        return UiTableData(columns: [time, xAxis, yAxis, zAxis], rows: rows);
      } else {
        return noTableData();
      }
    } catch (_) {
      return noTableData();
    }
  }

  Future<UiAnalysisData> fetchVibrationAnalysis(
      {int? startTimeStamp, int? endTimeStamp}) async {
    try {
      var response = (await _service.fetchVibrationAnalysis(
              _sessionService.deviceId!,
              startTimeStamp ?? defaultStartTimestamp,
              endTimeStamp ?? defaultEndTimestamp))
          .data;
      if (response != null && response.analysis != null) {
        return UiAnalysisData(
            result: response.result.toBool(),
            analysis: response.analysis!
                .map((e) => e.toUiAnalysisDataPoint())
                .toList());
      } else {
        return noAnalysisData();
      }
    } catch (_) {
      return noAnalysisData();
    }
  }

  Future<UiAnalysisData> getVibrationToAudioAnalysis(
      {int? startTimeStamp, int? endTimeStamp}) async {
    try {
      var response = (await _service.fetchVibrationToAudioAnalysis(
              _sessionService.deviceId!,
              startTimeStamp ?? defaultStartTimestamp,
              endTimeStamp ?? defaultEndTimestamp))
          .data;
      if (response != null && response.analysis != null) {
        return UiAnalysisData(
            result: response.result.toBool(),
            analysis: response.analysis!
                .map((e) => e.toUiAnalysisDataPoint())
                .toList());
      } else {
        return noAnalysisData();
      }
    } catch (_) {
      return noAnalysisData();
    }
  }

  Future<String?> fetchAudioGraphLink(
      {int? startTimeStamp, int? endTimeStamp}) async {
    try {
      return (await _service.fetchAudioImageLink(
                  _sessionService.deviceId!,
                  startTimeStamp ?? defaultStartTimestamp,
                  endTimeStamp ?? defaultEndTimestamp))
              .data
              ?.image ??
          noLinkData();
    } catch (_) {
      return noLinkData();
    }
  }

  Future<String?> dowloadAudioData(
      {int? startTimeStamp, int? endTimeStamp}) async {
    try {
      var linkData = (await _service.fetchAudioImageLink(
              _sessionService.deviceId!,
              startTimeStamp ?? defaultStartTimestamp,
              endTimeStamp ?? defaultEndTimestamp))
          .data;
      if (linkData != null && linkData.image != null) {
        var fileName = _createFileName(vibrationPrefix, png);
        return _fileDownloaderService.startDownload(linkData.image!, fileName);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<String?> dowloadVibrationData(
      {int? startTimeStamp, int? endTimeStamp}) async {
    try {
      var response = (await _service.fetchVibrationCSVLink(
              _sessionService.deviceId!,
              startTimeStamp ?? defaultStartTimestamp,
              endTimeStamp ?? defaultEndTimestamp))
          .data;
      if (response != null && response.file != null) {
        var linkData = response.file!;
        var fileName = _createFileName(vibrationPrefix, csv);
        return _fileDownloaderService.startDownload(linkData, fileName);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<String?> dowloadTemperatureData(
      {int? startTimeStamp, int? endTimeStamp}) async {
    try {
      var response = (await _service.fetchVibrationCSVLink(
              _sessionService.deviceId!,
              startTimeStamp ?? defaultStartTimestamp,
              endTimeStamp ?? defaultEndTimestamp))
          .data;
      if (response != null && response.file != null) {
        var linkData = response.file;
        var fileName = _createFileName(vibrationPrefix, csv);
        return _fileDownloaderService.startDownload(linkData!, fileName);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<UiReportsData> fetchReports(
      {int? startTimeStamp, int? endTimeStamp}) async {
    try {
      var response = (await _service.fetchReports(
              _sessionService.machineId!,
              startTimeStamp ?? defaultStartTimestamp,
              endTimeStamp ?? defaultEndTimestamp))
          .data;
      if (response != null) {
        return response.toUiReportsData();
      } else {
        return ReportsData().toUiReportsData();
      }
    } catch (_) {
      return ReportsData().toUiReportsData();
    }
  }

  void registerForFileDownloadStatus(
      String taskId, Function(DownloadTaskResult) callback) {
    _fileDownloaderService.registerForDownloadStatus(callback, taskId);
  }

  Future<List<AnalysisDataPoint>?> fetchAudioAnalysis(
      {int? startTimeStamp, int? endTimeStamp}) async {
    try {
      var respone = (await _service.fetchAudioAnalysis(
          _sessionService.deviceId!,
          startTimeStamp ?? defaultStartTimestamp,
          endTimeStamp ?? defaultEndTimestamp));
      return (respone.data?.analysis);
    } catch (_) {
      return null;
    }
  }

  String _createFileName(String prefix, String suffix) {
    var millis = DateTime.now().millisecondsSinceEpoch;
    return "$prefix-$millis.$suffix";
  }

  UiGraphInfo _getTemperatureData(List<SensorDataPoint>? temperature) {
    if (temperature != null) {
      List<FlSpot> temperatureAxisData = temperature
          .where(
              (element) => element.timestamp != null && element.value != null)
          .map((e) => FlSpot(e.timestamp!.toDouble(), e.value!))
          .toList();

      var maxY = (temperatureAxisData.map<double>((e) => e.y).reduce(max))
          .ceil()
          .toDouble();

      var minY = (temperatureAxisData.map<double>((e) => e.y).reduce(min))
          .floor()
          .toDouble();

      if (minY == maxY) {
        minY = maxY - 1;
      }

      var maxX = temperatureAxisData.map<double>((e) => e.x).reduce(max);
      var minX = temperatureAxisData.map<double>((e) => e.x).reduce(min);

      if (maxX == minX) {
        minX = maxX - 1;
      }

      var intervalX = (maxX - minX) / 2.0;

      if (intervalX == 0) {
        intervalX = .5;
      }

      var intervalY = (maxY - minY) / 2.0;

      if (intervalY == 0) {
        intervalY = .5;
      }

      return UiGraphInfo(
        graphLineValues: [
          LineChartBarData(
            color: Colors.red,
            spots: temperatureAxisData,
          )
        ],
        minX: minX,
        maxX: maxX,
        minY: minY,
        maxY: maxY,
        intervalX: intervalX,
        intervalY: intervalY,
      );
    } else {
      return noGraphData();
    }
  }

  UiGraphInfo _getVibrationData(VibrationData? vibration) {
    if (vibration != null &&
        vibration.x != null &&
        vibration.y != null &&
        vibration.z != null) {
      List<FlSpot> xAxisData = vibration.x!
          .where(
              (element) => element.timestamp != null && element.value != null)
          .map((e) => FlSpot(e.timestamp!.toDouble(), e.value!))
          .toList();
      List<FlSpot> yAxisData = vibration.y!
          .where(
              (element) => element.timestamp != null && element.value != null)
          .map((e) => FlSpot(e.timestamp!.toDouble(), e.value!))
          .toList();
      List<FlSpot> zAxisData = vibration.z!
          .where(
              (element) => element.timestamp != null && element.value != null)
          .map((e) => FlSpot(e.timestamp!.toDouble(), e.value!))
          .toList();

      var maxY = (max(
              max(xAxisData.map<double>((e) => e.y).reduce(max),
                  yAxisData.map<double>((e) => e.y).reduce(max)),
              zAxisData.map<double>((e) => e.y).reduce(max)))
          .ceil()
          .toDouble();

      var minY = (min(
              min(xAxisData.map<double>((e) => e.y).reduce(min),
                  yAxisData.map<double>((e) => e.y).reduce(min)),
              zAxisData.map<double>((e) => e.y).reduce(min)))
          .floor()
          .toDouble();

      if (minY == maxY) {
        minY = maxY - 1;
      }

      var maxX = xAxisData.map<double>((e) => e.x).reduce(max);
      var minX = xAxisData.map<double>((e) => e.x).reduce(min);

      if (maxX == minX) {
        minX = maxX - 1;
      }

      var intervalX = (maxX - minX) / 2.0;

      if (intervalX == 0) {
        intervalX = .5;
      }

      var intervalY = (maxY - minY) / 2.0;

      if (intervalY == 0) {
        intervalY = .5;
      }

      return UiGraphInfo(
        graphLineValues: [
          LineChartBarData(
            color: Colors.red,
            spots: xAxisData,
          ),
          LineChartBarData(
            color: Colors.green,
            spots: yAxisData,
          ),
          LineChartBarData(
            color: Colors.blue,
            spots: zAxisData,
          ),
        ],
        minX: minX,
        maxX: maxX,
        minY: minY,
        maxY: maxY,
        intervalX: intervalX,
        intervalY: intervalY,
      );
    } else {
      return noGraphData();
    }
  }

  UiTableData noTableData() {
    return UiTableData(columns: [
      strNoData,
      strNoData
    ], rows: [
      Cells(cell: [strNoData, strNoData])
    ]);
  }

  UiAnalysisData noAnalysisData() {
    return UiAnalysisData(result: true, analysis: []);
  }

  String noLinkData() {
    return "";
  }

  UiGraphInfo noGraphData() {
    return UiGraphInfo(
      graphLineValues: [],
      minX: 0,
      maxX: 1,
      minY: 0,
      maxY: 1,
      intervalX: .5,
      intervalY: .5,
    );
  }

  int get defaultStartTimestamp => DateTime.now()
      .subtract(const Duration(minutes: 15))
      .millisecondsSinceEpoch;

  int get defaultEndTimestamp => DateTime.now().millisecondsSinceEpoch;

  fetchSensorList() {}
}
