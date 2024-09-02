import 'package:json_annotation/json_annotation.dart';

part 'machine_issue_item.g.dart';

@JsonSerializable()
class MachineIssueItem {
  final String? id;
  final String? description;
  final int? issueStartTime;
  final int? issueEndTime;
  final int? approvedBySM;
  final int? issueClosed;
  final int? isIssueValid;
  MachineIssueItem({
    this.id,
    this.description,
    this.issueStartTime,
    this.issueEndTime,
    this.approvedBySM,
    this.issueClosed,
    this.isIssueValid,
  });

  MachineIssueItem copyWith({
    String? id,
    String? description,
    int? issueStartTime,
    int? issueEndTime,
    int? approvedBySM,
    int? issueClosed,
    int? isIssueValid,
  }) {
    return MachineIssueItem(
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

  factory MachineIssueItem.fromMap(Map<String, dynamic> map) {
    return MachineIssueItem(
      id: map['id'] != null ? map['id'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      issueStartTime:
          map['issueStartTime'] != null ? map['issueStartTime'] as int : null,
      issueEndTime:
          map['issueEndTime'] != null ? map['issueEndTime'] as int : null,
      approvedBySM:
          map['approvedBySM'] != null ? map['approvedBySM'] as int : null,
      issueClosed:
          map['issueClosed'] != null ? map['issueClosed'] as int : null,
      isIssueValid:
          map['isIssueValid'] != null ? map['isIssueValid'] as int : null,
    );
  }

  factory MachineIssueItem.fromJson(Map<String, dynamic> json) =>
      _$MachineIssueItemFromJson(json);

  Map<String, dynamic> toJson() => _$MachineIssueItemToJson(this);

  @override
  String toString() {
    return 'MachineIssueItem(id: $id, description: $description, issueStartTime: $issueStartTime, issueEndTime: $issueEndTime, approvedBySM: $approvedBySM, issueClosed: $issueClosed, isIssueValid: $isIssueValid)';
  }

  @override
  bool operator ==(covariant MachineIssueItem other) {
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
