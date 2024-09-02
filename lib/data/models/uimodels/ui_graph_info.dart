import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';

class UiGraphInfo {
  final List<LineChartBarData> graphLineValues;
  final double minX;
  final double maxX;
  final double minY;
  final double maxY;
  final double intervalX;
  final double intervalY;
  UiGraphInfo({
    required this.graphLineValues,
    required this.minX,
    required this.maxX,
    required this.minY,
    required this.maxY,
    required this.intervalX,
    required this.intervalY,
  });

  UiGraphInfo copyWith({
    List<LineChartBarData>? graphLineValues,
    double? minX,
    double? maxX,
    double? minY,
    double? maxY,
    double? intervalX,
    double? intervalY,
  }) {
    return UiGraphInfo(
      graphLineValues: graphLineValues ?? this.graphLineValues,
      minX: minX ?? this.minX,
      maxX: maxX ?? this.maxX,
      minY: minY ?? this.minY,
      maxY: maxY ?? this.maxY,
      intervalX: intervalX ?? this.intervalX,
      intervalY: intervalY ?? this.intervalY,
    );
  }

  @override
  String toString() {
    return 'UiGraphInfo(graphLineValues: $graphLineValues, minX: $minX, maxX: $maxX, minY: $minY, maxY: $maxY, intervalX: $intervalX, intervalY: $intervalY)';
  }

  @override
  bool operator ==(covariant UiGraphInfo other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return listEquals(other.graphLineValues, graphLineValues) &&
        other.minX == minX &&
        other.maxX == maxX &&
        other.minY == minY &&
        other.maxY == maxY &&
        other.intervalX == intervalX &&
        other.intervalY == intervalY;
  }

  @override
  int get hashCode {
    return graphLineValues.hashCode ^
        minX.hashCode ^
        maxX.hashCode ^
        minY.hashCode ^
        maxY.hashCode ^
        intervalX.hashCode ^
        intervalY.hashCode;
  }
}
