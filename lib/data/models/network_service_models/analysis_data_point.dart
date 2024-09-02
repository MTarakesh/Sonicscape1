import 'package:json_annotation/json_annotation.dart';

part 'analysis_data_point.g.dart';

@JsonSerializable()
class AnalysisDataPoint {
  final String? name;
  final double? max;
  final double? min;
  final double? value;
  AnalysisDataPoint({
    this.name,
    this.max,
    this.min,
    this.value,
  });

  AnalysisDataPoint copyWith({
    String? name,
    double? max,
    double? min,
    double? value,
  }) {
    return AnalysisDataPoint(
      name: name ?? this.name,
      max: max ?? this.max,
      min: min ?? this.min,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'max': max,
      'min': min,
      'value': value,
    };
  }

  factory AnalysisDataPoint.fromMap(Map<String, dynamic> map) {
    return AnalysisDataPoint(
      name: map['name'] != null ? map['name'] as String : null,
      max: map['max'] != null ? map['max'] as double : null,
      min: map['min'] != null ? map['min'] as double : null,
      value: map['value'] != null ? map['value'] as double : null,
    );
  }

  factory AnalysisDataPoint.fromJson(Map<String, dynamic> json) =>
      _$AnalysisDataPointFromJson(json);
  Map<String, dynamic> toJson() => _$AnalysisDataPointToJson(this);

  @override
  String toString() {
    return 'AnalysisDataPoint(name: $name, max: $max, min: $min, value: $value)';
  }

  @override
  bool operator ==(covariant AnalysisDataPoint other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.max == max &&
        other.min == min &&
        other.value == value;
  }

  @override
  int get hashCode {
    return name.hashCode ^ max.hashCode ^ min.hashCode ^ value.hashCode;
  }
}
