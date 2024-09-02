import 'package:flutter/foundation.dart';

class UiMachine {
  final List<String> uuid;
  final String machineId;
  final String name;
  final int age;
  final String type;
  final int lastServiceDate;
  final int nextServiceDate;
  UiMachine({
    required this.uuid,
    required this.machineId,
    required this.name,
    required this.age,
    required this.type,
    required this.lastServiceDate,
    required this.nextServiceDate,
  });

  UiMachine copyWith({
    List<String>? uuid,
    String? machineId,
    String? name,
    int? age,
    String? type,
    int? lastServiceDate,
    int? nextServiceDate,
  }) {
    return UiMachine(
      uuid: uuid ?? this.uuid,
      machineId: machineId ?? this.machineId,
      name: name ?? this.name,
      age: age ?? this.age,
      type: type ?? this.type,
      lastServiceDate: lastServiceDate ?? this.lastServiceDate,
      nextServiceDate: nextServiceDate ?? this.nextServiceDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'machineId': machineId,
      'name': name,
      'age': age,
      'type': type,
      'lastServiceDate': lastServiceDate,
      'nextServiceDate': nextServiceDate,
    };
  }

  @override
  String toString() {
    return 'UiMachine(uuid: $uuid, machineId: $machineId, name: $name, age: $age, type: $type, lastServiceDate: $lastServiceDate, nextServiceDate: $nextServiceDate)';
  }

  @override
  bool operator ==(covariant UiMachine other) {
    if (identical(this, other)) return true;

    return listEquals(other.uuid, uuid) &&
        other.machineId == machineId &&
        other.name == name &&
        other.age == age &&
        other.type == type &&
        other.lastServiceDate == lastServiceDate &&
        other.nextServiceDate == nextServiceDate;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
        machineId.hashCode ^
        name.hashCode ^
        age.hashCode ^
        type.hashCode ^
        lastServiceDate.hashCode ^
        nextServiceDate.hashCode;
  }
}
