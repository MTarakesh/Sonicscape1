// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UiMachineStatusData {
  final bool status;
  final String machineId;
  final String machineName;
  UiMachineStatusData({
    required this.status,
    required this.machineId,
    required this.machineName,
  });

  UiMachineStatusData copyWith({
    bool? status,
    String? machineId,
    String? machineName,
  }) {
    return UiMachineStatusData(
      status: status ?? this.status,
      machineId: machineId ?? this.machineId,
      machineName: machineName ?? this.machineName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'machineId': machineId,
      'machineName': machineName,
    };
  }

  factory UiMachineStatusData.fromMap(Map<String, dynamic> map) {
    return UiMachineStatusData(
      status: map['status'] as bool,
      machineId: map['machineId'] as String,
      machineName: map['machineName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UiMachineStatusData.fromJson(String source) =>
      UiMachineStatusData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'MachineStatusData(status: $status, machineId: $machineId, machineName: $machineName)';

  @override
  bool operator ==(covariant UiMachineStatusData other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.machineId == machineId &&
        other.machineName == machineName;
  }

  @override
  int get hashCode =>
      status.hashCode ^ machineId.hashCode ^ machineName.hashCode;
}
