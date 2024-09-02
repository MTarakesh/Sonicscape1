// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UiAnalysisDataPoint {
  final String name;
  final double value;
  final double percentage;
  UiAnalysisDataPoint({
    required this.name,
    required this.value,
    required this.percentage,
  });

  UiAnalysisDataPoint copyWith({
    String? name,
    double? value,
    double? percentage,
  }) {
    return UiAnalysisDataPoint(
      name: name ?? this.name,
      value: value ?? this.value,
      percentage: percentage ?? this.percentage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'value': value,
      'percentage': percentage,
    };
  }

  factory UiAnalysisDataPoint.fromMap(Map<String, dynamic> map) {
    return UiAnalysisDataPoint(
      name: map['name'] as String,
      value: map['value'] as double,
      percentage: map['percentage'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory UiAnalysisDataPoint.fromJson(String source) =>
      UiAnalysisDataPoint.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UiAnalysisDataPoint(name: $name, value: $value, percentage: $percentage)';

  @override
  bool operator ==(covariant UiAnalysisDataPoint other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.value == value &&
        other.percentage == percentage;
  }

  @override
  int get hashCode => name.hashCode ^ value.hashCode ^ percentage.hashCode;
}
