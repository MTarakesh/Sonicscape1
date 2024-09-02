import 'dart:collection';
import 'dart:isolate';

import 'package:SonicScape/data/models/file_downloader_service_models/download_task_result.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class FileDownloaderService {
  final String downloadPath = "/storage/emulated/0/Download/";
  final ReceivePort _port = ReceivePort();
  final String portName = "SonicScape-file-downloader-service";
  final HashMap<String, Function(DownloadTaskResult)> _callbacks = HashMap();

  FileDownloaderService() {
    initialiseService().then((value) => listenForStatus());
  }

  void listenForStatus() {
    // log("Started listening");
    // IsolateNameServer.registerPortWithName(_port.sendPort, portName);
    // _port.listen((dynamic data) {
    //   log("status for ${data[0]} is ${data[1]}");
    //   String id = data[0];
    //   DownloadTaskStatus status = DownloadTaskStatus.fromInt(data[1]);
    //   int progress = data[2];

    //   _callbacks[id]?.call(DownloadTaskResult(
    //       status: status.toUIFileDownloadState(), progress: progress));
    // });

    // FlutterDownloader.registerCallback((id, status, progress) {
    //   log("status for $id is $status");
    //   final SendPort? send = IsolateNameServer.lookupPortByName(portName);
    //   send?.send([id, status, progress]);
    // });
  }

  Future<void> initialiseService() async {
    await FlutterDownloader.initialize(
        debug:
            true // optional: set to false to disable printing logs to console (default: true)
        );
  }

  Future<String?> startDownload(String fileLink, String fileName) async {
    return await FlutterDownloader.enqueue(
      url: fileLink,
      fileName: fileName,
      headers: {}, // optional: header send with url (auth token etc)
      savedDir: downloadPath,
      showNotification:
          true, // show download progress in status bar (for Android)
      openFileFromNotification:
          true, // click on notification to open downloaded file (for Android)
    );
  }

  Future<void> registerForDownloadStatus(
      Function(DownloadTaskResult) callback, String taskId) async {
    _callbacks[taskId] = callback;
  }

  Future<void> unRegisterForDownloadStatus(String taskId) async {
    _callbacks.remove(taskId);
  }
}
