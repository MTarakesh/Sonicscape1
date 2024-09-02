import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:SonicScape/data/models/network_service_models/sensor_data_point.dart';

part 'vibration_data.g.dart';

@JsonSerializable()
class VibrationData {
  final List<SensorDataPoint>? x;
  final List<SensorDataPoint>? y;
  final List<SensorDataPoint>? z;
  VibrationData({
    this.x,
    this.y,
    this.z,
  });

  VibrationData copyWith({
    List<SensorDataPoint>? x,
    List<SensorDataPoint>? y,
    List<SensorDataPoint>? z,
  }) {
    return VibrationData(
      x: x ?? this.x,
      y: y ?? this.y,
      z: z ?? this.z,
    );
  }

  factory VibrationData.fromJson(Map<String, dynamic> json) =>
      _$VibrationDataFromJson(json);
  Map<String, dynamic> toJson() => _$VibrationDataToJson(this);

  @override
  String toString() => 'VibrationData(x: $x, y: $y, z: $z)';

  @override
  bool operator ==(covariant VibrationData other) {
    if (identical(this, other)) return true;

    return listEquals(other.x, x) &&
        listEquals(other.y, y) &&
        listEquals(other.z, z);
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode ^ z.hashCode;
}
