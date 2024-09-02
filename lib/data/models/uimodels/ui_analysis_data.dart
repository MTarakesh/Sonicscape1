// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:SonicScape/data/models/uimodels/ui_analysis_data_point.dart';

class UiAnalysisData {
  final bool result;
  final List<UiAnalysisDataPoint> analysis;
  UiAnalysisData({
    required this.result,
    required this.analysis,
  });

  UiAnalysisData copyWith({
    bool? result,
    List<UiAnalysisDataPoint>? analysis,
  }) {
    return UiAnalysisData(
      result: result ?? this.result,
      analysis: analysis ?? this.analysis,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'result': result,
      'analysis': analysis.map((x) => x.toMap()).toList(),
    };
  }

  factory UiAnalysisData.fromMap(Map<String, dynamic> map) {
    return UiAnalysisData(
      result: map['result'] as bool,
      analysis: List<UiAnalysisDataPoint>.from(
        (map['analysis'] as List<int>).map<UiAnalysisDataPoint>(
          (x) => UiAnalysisDataPoint.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UiAnalysisData.fromJson(String source) =>
      UiAnalysisData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UiAnalysisData(result: $result, analysis: $analysis)';

  @override
  bool operator ==(covariant UiAnalysisData other) {
    if (identical(this, other)) return true;

    return other.result == result && listEquals(other.analysis, analysis);
  }

  @override
  int get hashCode => result.hashCode ^ analysis.hashCode;
}
