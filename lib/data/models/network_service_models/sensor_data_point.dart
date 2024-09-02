import 'package:json_annotation/json_annotation.dart';

part 'sensor_data_point.g.dart';

@JsonSerializable()
class SensorDataPoint {
  final int? timestamp;
  final double? value;
  SensorDataPoint({
    this.timestamp,
    this.value,
  });

  SensorDataPoint copyWith({
    int? timestamp,
    double? value,
  }) {
    return SensorDataPoint(
      timestamp: timestamp ?? this.timestamp,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'timestamp': timestamp,
      'value': value,
    };
  }

  factory SensorDataPoint.fromMap(Map<String, dynamic> map) {
    return SensorDataPoint(
      timestamp: map['timestamp'] != null ? map['timestamp'] as int : null,
      value: map['value'] != null ? map['value'] as double : null,
    );
  }

  factory SensorDataPoint.fromJson(Map<String, dynamic> json) =>
      _$SensorDataPointFromJson(json);
  Map<String, dynamic> toJson() => _$SensorDataPointToJson(this);

  @override
  String toString() => 'SensorDataPoint(timestamp: $timestamp, value: $value)';

  @override
  bool operator ==(covariant SensorDataPoint other) {
    if (identical(this, other)) return true;

    return other.timestamp == timestamp && other.value == value;
  }

  @override
  int get hashCode => timestamp.hashCode ^ value.hashCode;
}
