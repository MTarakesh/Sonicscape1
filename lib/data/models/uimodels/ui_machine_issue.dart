// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UiMachineIssue {
  final String id;
  final String description;
  final String issueStartTime;
  final String issueEndTime;
  final bool approvedBySM;
  final bool issueClosed;
  final bool isIssueValid;
  UiMachineIssue({
    required this.id,
    required this.description,
    required this.issueStartTime,
    required this.issueEndTime,
    required this.approvedBySM,
    required this.issueClosed,
    required this.isIssueValid,
  });

  UiMachineIssue copyWith({
    String? id,
    String? description,
    String? issueStartTime,
    String? issueEndTime,
    bool? approvedBySM,
    bool? issueClosed,
    bool? isIssueValid,
  }) {
    return UiMachineIssue(
      id: id ?? this.id,
      description: description ?? this.description,
      issueStartTime: issueStartTime ?? this.issueStartTime,
      issueEndTime: issueEndTime ?? this.issueEndTime,
      approvedBySM: approvedBySM ?? this.approvedBySM,
      issueClosed: issueClosed ?? this.issueClosed,
      isIssueValid: isIssueValid ?? this.isIssueValid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
      'issueStartTime': issueStartTime,
      'issueEndTime': issueEndTime,
      'approvedBySM': approvedBySM,
      'issueClosed': issueClosed,
      'isIssueValid': isIssueValid,
    };
  }

  factory UiMachineIssue.fromMap(Map<String, dynamic> map) {
    return UiMachineIssue(
      id: map['id'] as String,
      description: map['description'] as String,
      issueStartTime: map['issueStartTime'] as String,
      issueEndTime: map['issueEndTime'] as String,
      approvedBySM: map['approvedBySM'] as bool,
      issueClosed: map['issueClosed'] as bool,
      isIssueValid: map['isIssueValid'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory UiMachineIssue.fromJson(String source) =>
      UiMachineIssue.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UiMachineIssue(id: $id, description: $description, issueStartTime: $issueStartTime, issueEndTime: $issueEndTime, approvedBySM: $approvedBySM, issueClosed: $issueClosed, isIssueValid: $isIssueValid)';
  }

  @override
  bool operator ==(covariant UiMachineIssue other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.description == description &&
        other.issueStartTime == issueStartTime &&
        other.issueEndTime == issueEndTime &&
        other.approvedBySM == approvedBySM &&
        other.issueClosed == issueClosed &&
        other.isIssueValid == isIssueValid;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        description.hashCode ^
        issueStartTime.hashCode ^
        issueEndTime.hashCode ^
        approvedBySM.hashCode ^
        issueClosed.hashCode ^
        isIssueValid.hashCode;
  }
}
