import 'package:SonicScape/data/models/uimodels/ui_graph_info.dart';

class UiVibrationTemperatureData {
  final UiGraphInfo vibrationGraph;
  final UiGraphInfo temperatureGraph;
  UiVibrationTemperatureData({
    required this.vibrationGraph,
    required this.temperatureGraph,
  });

  UiVibrationTemperatureData copyWith({
    UiGraphInfo? vibrationGraph,
    UiGraphInfo? temperatureGraph,
  }) {
    return UiVibrationTemperatureData(
      vibrationGraph: vibrationGraph ?? this.vibrationGraph,
      temperatureGraph: temperatureGraph ?? this.temperatureGraph,
    );
  }

  @override
  String toString() =>
      'UiVibrationTemperatureData(vibrationGraph: $vibrationGraph, temperatureGraph: $temperatureGraph)';

  @override
  bool operator ==(covariant UiVibrationTemperatureData other) {
    if (identical(this, other)) return true;

    return other.vibrationGraph == vibrationGraph &&
        other.temperatureGraph == temperatureGraph;
  }

  @override
  int get hashCode => vibrationGraph.hashCode ^ temperatureGraph.hashCode;
}
