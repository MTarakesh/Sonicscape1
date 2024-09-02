import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:SonicScape/data/models/network_service_models/machine.dart';

part 'machine_data.g.dart';

@JsonSerializable()
class MachineData {
  final List<Machine>? machines;
  MachineData({
    this.machines,
  });

  MachineData copyWith({
    List<Machine>? machines,
  }) {
    return MachineData(
      machines: machines ?? this.machines,
    );
  }

  factory MachineData.fromJson(Map<String, dynamic> json) =>
      _$MachineDataFromJson(json);

  Map<String, dynamic> toJson() => _$MachineDataToJson(this);

  @override
  String toString() => 'MachineData(machines: $machines)';

  @override
  bool operator ==(covariant MachineData other) {
    if (identical(this, other)) return true;

    return listEquals(other.machines, machines);
  }

  @override
  int get hashCode => machines.hashCode;
}
