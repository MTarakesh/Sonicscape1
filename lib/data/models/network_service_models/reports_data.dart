import 'package:json_annotation/json_annotation.dart';

part 'reports_data.g.dart';

@JsonSerializable()
class ReportsData {
  final int? noOfAllIssues;
  final int? noOfExistingIssues;
  final int? noOfClosedIssues;
  final double? idleTime;
  final double? runningTime;
  ReportsData({
    this.noOfAllIssues,
    this.noOfExistingIssues,
    this.noOfClosedIssues,
    this.idleTime,
    this.runningTime,
  });

  ReportsData copyWith({
    int? noOfAllIssues,
    int? noOfExistingIssues,
    int? noOfClosedIssues,
    double? idleTime,
    double? runningTime,
  }) {
    return ReportsData(
      noOfAllIssues: noOfAllIssues ?? this.noOfAllIssues,
      noOfExistingIssues: noOfExistingIssues ?? this.noOfExistingIssues,
      noOfClosedIssues: noOfClosedIssues ?? this.noOfClosedIssues,
      idleTime: idleTime ?? this.idleTime,
      runningTime: runningTime ?? this.runningTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'noOfAllIssues': noOfAllIssues,
      'noOfExistingIssues': noOfExistingIssues,
      'noOfClosedIssues': noOfClosedIssues,
      'idleTime': idleTime,
      'runningTime': runningTime,
    };
  }

  factory ReportsData.fromMap(Map<String, dynamic> map) {
    return ReportsData(
      noOfAllIssues:
          map['noOfAllIssues'] != null ? map['noOfAllIssues'] as int : null,
      noOfExistingIssues: map['noOfExistingIssues'] != null
          ? map['noOfExistingIssues'] as int
          : null,
      noOfClosedIssues: map['noOfClosedIssues'] != null
          ? map['noOfClosedIssues'] as int
          : null,
      idleTime: map['idleTime'] != null ? map['idleTime'] as double : null,
      runningTime:
          map['runningTime'] != null ? map['runningTime'] as double : null,
    );
  }

  factory ReportsData.fromJson(Map<String, dynamic> json) =>
      _$ReportsDataFromJson(json);

  Map<String, dynamic> toJson() => _$ReportsDataToJson(this);

  @override
  String toString() {
    return 'ReportsData(noOfAllIssues: $noOfAllIssues, noOfExistingIssues: $noOfExistingIssues, noOfClosedIssues: $noOfClosedIssues, idleTime: $idleTime, runningTime: $runningTime)';
  }

  @override
  bool operator ==(covariant ReportsData other) {
    if (identical(this, other)) return true;

    return other.noOfAllIssues == noOfAllIssues &&
        other.noOfExistingIssues == noOfExistingIssues &&
        other.noOfClosedIssues == noOfClosedIssues &&
        other.idleTime == idleTime &&
        other.runningTime == runningTime;
  }

  @override
  int get hashCode {
    return noOfAllIssues.hashCode ^
        noOfExistingIssues.hashCode ^
        noOfClosedIssues.hashCode ^
        idleTime.hashCode ^
        runningTime.hashCode;
  }
}
