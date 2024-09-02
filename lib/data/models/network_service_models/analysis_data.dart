import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:SonicScape/data/models/network_service_models/analysis_data_point.dart';

part 'analysis_data.g.dart';

@JsonSerializable()
class AnalysisData {
  final String? id;
  final double? result;
  final int? deviceId;
  final int? createdAt;
  final int? analysisStartTime;
  final int? analysisEndTime;
  final int? plotImage;
  final List<AnalysisDataPoint>? analysis;
  AnalysisData({
    this.id,
    this.result,
    this.deviceId,
    this.createdAt,
    this.analysisStartTime,
    this.analysisEndTime,
    this.plotImage,
    this.analysis,
  });

  AnalysisData copyWith({
    String? id,
    double? result,
    int? deviceId,
    int? createdAt,
    int? analysisStartTime,
    int? analysisEndTime,
    int? plotImage,
    List<AnalysisDataPoint>? analysis,
  }) {
    return AnalysisData(
      id: id ?? this.id,
      result: result ?? this.result,
      deviceId: deviceId ?? this.deviceId,
      createdAt: createdAt ?? this.createdAt,
      analysisStartTime: analysisStartTime ?? this.analysisStartTime,
      analysisEndTime: analysisEndTime ?? this.analysisEndTime,
      plotImage: plotImage ?? this.plotImage,
      analysis: analysis ?? this.analysis,
    );
  }

  factory AnalysisData.fromJson(Map<String, dynamic> json) =>
      _$AnalysisDataFromJson(json);
  Map<String, dynamic> toJson() => _$AnalysisDataToJson(this);

  @override
  String toString() {
    return 'AnalysisData(id: $id, result: $result, deviceId: $deviceId, createdAt: $createdAt, analysisStartTime: $analysisStartTime, analysisEndTime: $analysisEndTime, plotImage: $plotImage, analysis: $analysis)';
  }

  @override
  bool operator ==(covariant AnalysisData other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.result == result &&
        other.deviceId == deviceId &&
        other.createdAt == createdAt &&
        other.analysisStartTime == analysisStartTime &&
        other.analysisEndTime == analysisEndTime &&
        other.plotImage == plotImage &&
        listEquals(other.analysis, analysis);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        result.hashCode ^
        deviceId.hashCode ^
        createdAt.hashCode ^
        analysisStartTime.hashCode ^
        analysisEndTime.hashCode ^
        plotImage.hashCode ^
        analysis.hashCode;
  }
}
