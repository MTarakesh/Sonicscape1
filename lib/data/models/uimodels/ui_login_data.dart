// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UiLoginData {
  final String orgId;
  UiLoginData({
    required this.orgId,
  });

  UiLoginData copyWith({
    String? orgId,
  }) {
    return UiLoginData(
      orgId: orgId ?? this.orgId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orgId': orgId,
    };
  }

  factory UiLoginData.fromMap(Map<String, dynamic> map) {
    return UiLoginData(
      orgId: map['orgId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UiLoginData.fromJson(String source) =>
      UiLoginData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UiLoginData(orgId: $orgId)';

  @override
  bool operator ==(covariant UiLoginData other) {
    if (identical(this, other)) return true;

    return other.orgId == orgId;
  }

  @override
  int get hashCode => orgId.hashCode;
}
