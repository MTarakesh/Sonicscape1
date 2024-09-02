// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UiReportsData {
  final int noOfAllIssues;
  final int noOfExistingIssues;
  final int noOfClosedIssues;
  final double idleTime;
  final double runningTime;
  UiReportsData({
    required this.noOfAllIssues,
    required this.noOfExistingIssues,
    required this.noOfClosedIssues,
    required this.idleTime,
    required this.runningTime,
  });

  UiReportsData copyWith({
    int? noOfAllIssues,
    int? noOfExistingIssues,
    int? noOfClosedIssues,
    double? idleTime,
    double? runningTime,
  }) {
    return UiReportsData(
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

  factory UiReportsData.fromMap(Map<String, dynamic> map) {
    return UiReportsData(
      noOfAllIssues: map['noOfAllIssues'] as int,
      noOfExistingIssues: map['noOfExistingIssues'] as int,
      noOfClosedIssues: map['noOfClosedIssues'] as int,
      idleTime: map['idleTime'] as double,
      runningTime: map['runningTime'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory UiReportsData.fromJson(String source) =>
      UiReportsData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UiReportsData(noOfAllIssues: $noOfAllIssues, noOfExistingIssues: $noOfExistingIssues, noOfClosedIssues: $noOfClosedIssues, idleTime: $idleTime, runningTime: $runningTime)';
  }

  @override
  bool operator ==(covariant UiReportsData other) {
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
