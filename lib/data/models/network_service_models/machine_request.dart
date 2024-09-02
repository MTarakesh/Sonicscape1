import 'package:json_annotation/json_annotation.dart';

part 'machine_request.g.dart';

@JsonSerializable()
class MachineRequest {
  final String? uuid;
  final String? machineId;
  final String? name;
  final String? emailId;
  final String? phoneNumber;
  final String? type;
  final int? age;
  final int? lastServiceDate;
  final int? nextServiceDate;
  MachineRequest({
    this.uuid,
    this.machineId,
    this.name,
    this.emailId,
    this.phoneNumber,
    this.type,
    this.age,
    this.lastServiceDate,
    this.nextServiceDate,
  });

  MachineRequest copyWith({
    String? uuid,
    String? machineId,
    String? name,
    String? emailId,
    String? phoneNumber,
    String? type,
    int? age,
    int? lastServiceDate,
    int? nextServiceDate,
  }) {
    return MachineRequest(
      uuid: uuid ?? this.uuid,
      machineId: machineId ?? this.machineId,
      name: name ?? this.name,
      emailId: emailId ?? this.emailId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      type: type ?? this.type,
      age: age ?? this.age,
      lastServiceDate: lastServiceDate ?? this.lastServiceDate,
      nextServiceDate: nextServiceDate ?? this.nextServiceDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'machineId': machineId,
      'name': name,
      'emailId': emailId,
      'phoneNumber': phoneNumber,
      'type': type,
      'age': age,
      'lastServiceDate': lastServiceDate,
      'nextServiceDate': nextServiceDate,
    };
  }

  factory MachineRequest.fromMap(Map<String, dynamic> map) {
    return MachineRequest(
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      machineId: map['machineId'] != null ? map['machineId'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      emailId: map['emailId'] != null ? map['emailId'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      age: map['age'] != null ? map['age'] as int : null,
      lastServiceDate:
          map['lastServiceDate'] != null ? map['lastServiceDate'] as int : null,
      nextServiceDate:
          map['nextServiceDate'] != null ? map['nextServiceDate'] as int : null,
    );
  }

  factory MachineRequest.fromJson(Map<String, dynamic> json) =>
      _$MachineRequestFromJson(json);
  Map<String, dynamic> toJson() => _$MachineRequestToJson(this);

  @override
  String toString() {
    return 'MachineRequest(uuid: $uuid, machineId: $machineId, name: $name, emailId: $emailId, phoneNumber: $phoneNumber, type: $type, age: $age, lastServiceDate: $lastServiceDate, nextServiceDate: $nextServiceDate)';
  }

  @override
  bool operator ==(covariant MachineRequest other) {
    if (identical(this, other)) return true;

    return other.uuid == uuid &&
        other.machineId == machineId &&
        other.name == name &&
        other.emailId == emailId &&
        other.phoneNumber == phoneNumber &&
        other.type == type &&
        other.age == age &&
        other.lastServiceDate == lastServiceDate &&
        other.nextServiceDate == nextServiceDate;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
        machineId.hashCode ^
        name.hashCode ^
        emailId.hashCode ^
        phoneNumber.hashCode ^
        type.hashCode ^
        age.hashCode ^
        lastServiceDate.hashCode ^
        nextServiceDate.hashCode;
  }
}
