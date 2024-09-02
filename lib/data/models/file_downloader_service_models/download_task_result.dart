sealed class UIFileDownloadState {}

class UIFDLoadingState extends UIFileDownloadState {}

class UIFDSuccessState extends UIFileDownloadState {}

class UIFDErrorState extends UIFileDownloadState {}

class UIFDStartState extends UIFileDownloadState {}

class DownloadTaskResult {
  final UIFileDownloadState status;
  final int progress;

  DownloadTaskResult({
    required this.status,
    required this.progress,
  });

  DownloadTaskResult copyWith({
    UIFileDownloadState? status,
    int? progress,
  }) {
    return DownloadTaskResult(
      status: status ?? this.status,
      progress: progress ?? this.progress,
    );
  }

  @override
  String toString() =>
      'DownloadTaskResult(status: $status, progress: $progress)';

  @override
  bool operator ==(covariant DownloadTaskResult other) {
    if (identical(this, other)) return true;

    return other.status == status && other.progress == progress;
  }

  @override
  int get hashCode => status.hashCode ^ progress.hashCode;
}
