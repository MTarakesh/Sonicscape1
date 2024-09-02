// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';

class UiChartReportData {
  final List<FlSpot> vibrationDataXAxis;
  final List<FlSpot> vibrationDataYAxis;
  final List<FlSpot> vibrationDataZAxis;
  final List<FlSpot> temperatureData;
  UiChartReportData({
    required this.vibrationDataXAxis,
    required this.vibrationDataYAxis,
    required this.vibrationDataZAxis,
    required this.temperatureData,
  });

  UiChartReportData copyWith({
    List<FlSpot>? vibrationDataXAxis,
    List<FlSpot>? vibrationDataYAxis,
    List<FlSpot>? vibrationDataZAxis,
    List<FlSpot>? temperatureData,
  }) {
    return UiChartReportData(
      vibrationDataXAxis: vibrationDataXAxis ?? this.vibrationDataXAxis,
      vibrationDataYAxis: vibrationDataYAxis ?? this.vibrationDataYAxis,
      vibrationDataZAxis: vibrationDataZAxis ?? this.vibrationDataZAxis,
      temperatureData: temperatureData ?? this.temperatureData,
    );
  }

  @override
  String toString() {
    return 'UiChartReportData(vibrationDataXAxis: $vibrationDataXAxis, vibrationDataYAxis: $vibrationDataYAxis, vibrationDataZAxis: $vibrationDataZAxis, temperatureData: $temperatureData)';
  }

  @override
  bool operator ==(covariant UiChartReportData other) {
    if (identical(this, other)) return true;
  
    return 
      listEquals(other.vibrationDataXAxis, vibrationDataXAxis) &&
      listEquals(other.vibrationDataYAxis, vibrationDataYAxis) &&
      listEquals(other.vibrationDataZAxis, vibrationDataZAxis) &&
      listEquals(other.temperatureData, temperatureData);
  }

  @override
  int get hashCode {
    return vibrationDataXAxis.hashCode ^
      vibrationDataYAxis.hashCode ^
      vibrationDataZAxis.hashCode ^
      temperatureData.hashCode;
  }
}
