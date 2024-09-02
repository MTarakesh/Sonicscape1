import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:SonicScape/data/models/network_service_models/machine_issue_item.dart';

part 'machine_issues.g.dart';

@JsonSerializable()
class MachineIssues {
  final List<MachineIssueItem> issues;
  MachineIssues({
    required this.issues,
  });

  MachineIssues copyWith({
    List<MachineIssueItem>? issues,
  }) {
    return MachineIssues(
      issues: issues ?? this.issues,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'issues': issues.map((x) => x.toMap()).toList(),
    };
  }

  factory MachineIssues.fromMap(Map<String, dynamic> map) {
    return MachineIssues(
      issues: List<MachineIssueItem>.from(
        (map['issues'] as List<int>).map<MachineIssueItem>(
          (x) => MachineIssueItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
  factory MachineIssues.fromJson(Map<String, dynamic> json) =>
      _$MachineIssuesFromJson(json);
  Map<String, dynamic> toJson() => _$MachineIssuesToJson(this);

  @override
  String toString() => 'MachineIssues(issues: $issues)';

  @override
  bool operator ==(covariant MachineIssues other) {
    if (identical(this, other)) return true;

    return listEquals(other.issues, issues);
  }

  @override
  int get hashCode => issues.hashCode;
}
