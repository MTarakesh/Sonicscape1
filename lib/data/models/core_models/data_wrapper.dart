import 'package:SonicScape/data/models/network_service_models/machine_issues.dart';
import 'package:SonicScape/data/models/network_service_models/reports_data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:SonicScape/data/models/network_service_models/analysis_data.dart';
import 'package:SonicScape/data/models/network_service_models/link_data.dart';
import 'package:SonicScape/data/models/network_service_models/machine_data.dart';
import 'package:SonicScape/data/models/network_service_models/vibration_temperature_data.dart';

part 'data_wrapper.g.dart';

@JsonSerializable()
class DataWrapper<T extends Object?> {
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  final T? data;
  final String? error;
  final String? message;
  DataWrapper({
    this.data,
    this.error,
    this.message,
  });

  DataWrapper<T> copyWith({
    T? data,
    String? error,
    String? message,
  }) {
    return DataWrapper<T>(
      data: data ?? this.data,
      error: error ?? this.error,
      message: message ?? this.message,
    );
  }

  @override
  String toString() =>
      'DataWrapper(data: $data, error: $error, message: $message)';

  @override
  bool operator ==(covariant DataWrapper<T> other) {
    if (identical(this, other)) return true;

    return other.data == data &&
        other.error == error &&
        other.message == message;
  }

  @override
  int get hashCode => data.hashCode ^ error.hashCode ^ message.hashCode;

  factory DataWrapper.fromJson(Map<String, dynamic> json) =>
      _$DataWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$DataWrapperToJson(this);

  static T? _fromJson<T>(Object? json) {
    switch (T) {
      case MachineData:
        return MachineData.fromJson(json as Map<String, dynamic>) as T;
      case VibrationTemperatureData:
        return VibrationTemperatureData.fromJson(json as Map<String, dynamic>)
            as T;
      case AnalysisData:
        return AnalysisData.fromJson(json as Map<String, dynamic>) as T;
      case LinkData:
        return LinkData.fromJson(json as Map<String, dynamic>) as T;
      case MachineIssues:
        return MachineIssues.fromJson(json as Map<String, dynamic>) as T;
      case ReportsData:
        return ReportsData.fromJson(json as Map<String, dynamic>) as T;
      default:
        return null;
    }
  }

  static Object? _toJson<T>(T object) {
    switch (T) {
      case MachineData:
        return (object as MachineData).toJson();
      case VibrationTemperatureData:
        return (object as VibrationTemperatureData).toJson();
      case AnalysisData:
        return (object as AnalysisData).toJson();
      case LinkData:
        return (object as LinkData).toJson();
      case MachineIssues:
        return (object as MachineIssues).toJson();
      case ReportsData:
        return (object as ReportsData).toJson();
      default:
        return null;
    }
  }
}
