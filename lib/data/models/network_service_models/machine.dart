import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'machine.g.dart';

@JsonSerializable()
class Machine {
  final List<String>? uuids;
  final String? machineId;
  final String? name;
  final String? emailId;
  final String? phoneNumber;
  final String? type;
  final int? age;
  final int? lastServiceDate;
  final int? nextServiceDate;
  Machine({
    this.uuids,
    this.machineId,
    this.name,
    this.emailId,
    this.phoneNumber,
    this.type,
    this.age,
    this.lastServiceDate,
    this.nextServiceDate,
  });

  Machine copyWith({
    List<String>? uuids,
    String? machineId,
    String? name,
    String? emailId,
    String? phoneNumber,
    String? type,
    int? age,
    int? lastServiceDate,
    int? nextServiceDate,
  }) {
    return Machine(
      uuids: uuids ?? this.uuids,
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

  factory Machine.fromJson(Map<String, dynamic> json) =>
      _$MachineFromJson(json);

  Map<String, dynamic> toJson() => _$MachineToJson(this);

  @override
  String toString() {
    return 'Machine(uuids: $uuids, machineId: $machineId, name: $name, emailId: $emailId, phoneNumber: $phoneNumber, type: $type, age: $age, lastServiceDate: $lastServiceDate, nextServiceDate: $nextServiceDate)';
  }

  @override
  bool operator ==(covariant Machine other) {
    if (identical(this, other)) return true;

    return listEquals(other.uuids, uuids) &&
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
    return uuids.hashCode ^
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
