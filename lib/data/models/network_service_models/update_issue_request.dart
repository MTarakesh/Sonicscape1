import 'package:json_annotation/json_annotation.dart';

part 'update_issue_request.g.dart';

@JsonSerializable()
class UpdateIssueRequest {
  final String id;
  final String description;
  final int issueClosed;
  final int isIssueValid;
  final int approvedBySM;
  UpdateIssueRequest({
    required this.id,
    required this.description,
    required this.issueClosed,
    required this.isIssueValid,
    required this.approvedBySM,
  });

  UpdateIssueRequest copyWith({
    String? id,
    String? description,
    int? issueClosed,
    int? isIssueValid,
    int? approvedBySM,
  }) {
    return UpdateIssueRequest(
      id: id ?? this.id,
      description: description ?? this.description,
      issueClosed: issueClosed ?? this.issueClosed,
      isIssueValid: isIssueValid ?? this.isIssueValid,
      approvedBySM: approvedBySM ?? this.approvedBySM,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
      'issueClosed': issueClosed,
      'isIssueValid': isIssueValid,
      'approvedBySM': approvedBySM,
    };
  }

  factory UpdateIssueRequest.fromMap(Map<String, dynamic> map) {
    return UpdateIssueRequest(
      id: map['id'] as String,
      description: map['description'] as String,
      issueClosed: map['issueClosed'] as int,
      isIssueValid: map['isIssueValid'] as int,
      approvedBySM: map['approvedBySM'] as int,
    );
  }

  factory UpdateIssueRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateIssueRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateIssueRequestToJson(this);
  @override
  String toString() {
    return 'UpdateIssueRequest(id: $id, description: $description, issueClosed: $issueClosed, isIssueValid: $isIssueValid, approvedBySM: $approvedBySM)';
  }

  @override
  bool operator ==(covariant UpdateIssueRequest other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.description == description &&
        other.issueClosed == issueClosed &&
        other.isIssueValid == isIssueValid &&
        other.approvedBySM == approvedBySM;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        description.hashCode ^
        issueClosed.hashCode ^
        isIssueValid.hashCode ^
        approvedBySM.hashCode;
  }
}
