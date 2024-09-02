import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:SonicScape/data/models/network_service_models/sensor_data_point.dart';
import 'package:SonicScape/data/models/network_service_models/vibration_data.dart';

part 'vibration_temperature_data.g.dart';

@JsonSerializable()
class VibrationTemperatureData {
  final VibrationData? vibration;
  final List<SensorDataPoint>? temperature;
  VibrationTemperatureData({
    this.vibration,
    this.temperature,
  });

  VibrationTemperatureData copyWith({
    VibrationData? vibration,
    List<SensorDataPoint>? temperature,
  }) {
    return VibrationTemperatureData(
      vibration: vibration ?? this.vibration,
      temperature: temperature ?? this.temperature,
    );
  }

  factory VibrationTemperatureData.fromJson(Map<String, dynamic> json) =>
      _$VibrationTemperatureDataFromJson(json);
  Map<String, dynamic> toJson() => _$VibrationTemperatureDataToJson(this);

  @override
  String toString() =>
      'VibrationTemperatureData(vibration: $vibration, temperature: $temperature)';

  @override
  bool operator ==(covariant VibrationTemperatureData other) {
    if (identical(this, other)) return true;

    return other.vibration == vibration &&
        listEquals(other.temperature, temperature);
  }

  @override
  int get hashCode => vibration.hashCode ^ temperature.hashCode;
}
