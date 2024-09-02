import 'dart:convert';

/// Singleton class to manage session state
class SessionService {
  // Singleton instance
  static final SessionService _instance = SessionService._internal();

  factory SessionService({required String orgId}) {
    _instance._session = Session(orgId: orgId);
    return _instance;
  }

  SessionService._internal();

  late Session _session;

  void initialize(String orgId) {
    _session = Session(orgId: orgId);
  }

  String get orgId => _session.orgId;

  String? get deviceId => _session.deviceId;
  set deviceId(String? id) {
    _session = _session.copyWith(deviceId: id);
  }

  String? get machineId => _session.machineId;
  set machineId(String? id) {
    _session = _session.copyWith(machineId: id);
  }

  Map<String, dynamic> toMap() {
    return _session.toMap();
  }

  String toJson() => json.encode(toMap());

  factory SessionService.fromJson(String source) =>
      SessionService(orgId: Session.fromJson(source).orgId);

  @override
  String toString() => _session.toString();

  @override
  bool operator ==(covariant SessionService other) {
    if (identical(this, other)) return true;

    return other._session == _session;
  }

  @override
  int get hashCode => _session.hashCode;
}

class Session {
  final String orgId;
  String? deviceId;
  String? machineId;

  Session({
    required this.orgId,
    this.deviceId,
    this.machineId,
  });

  Session copyWith({
    String? orgId,
    String? deviceId,
    String? machineId,
  }) {
    return Session(
      orgId: orgId ?? this.orgId,
      deviceId: deviceId ?? this.deviceId,
      machineId: machineId ?? this.machineId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orgId': orgId,
      'deviceId': deviceId,
      'machineId': machineId,
    };
  }

  factory Session.fromMap(Map<String, dynamic> map) {
    return Session(
      orgId: map['orgId'] as String,
      deviceId: map['deviceId'] as String?,
      machineId: map['machineId'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory Session.fromJson(String source) =>
      Session.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Session(orgId: $orgId, deviceId: $deviceId, machineId: $machineId)';

  @override
  bool operator ==(covariant Session other) {
    if (identical(this, other)) return true;

    return other.orgId == orgId &&
        other.deviceId == deviceId &&
        other.machineId == machineId;
  }

  @override
  int get hashCode => orgId.hashCode ^ deviceId.hashCode ^ machineId.hashCode;
}
