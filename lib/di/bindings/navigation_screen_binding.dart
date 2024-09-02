import 'package:SonicScape/data/models/uimodels/ui_login_data.dart';
import 'package:SonicScape/data/repository/mahine_repository.dart';
import 'package:SonicScape/data/service/session_service.dart';
import 'package:SonicScape/ui/controllers/register_machine_screen_controller.dart';
import 'package:SonicScape/data/service/network_service.dart';
import 'package:SonicScape/data/service/refresh_service.dart';
import 'package:SonicScape/data/service/file_downloader_service.dart';
import 'package:SonicScape/ui/controllers/machine_dashboard_screen_controller.dart';
import 'package:SonicScape/ui/controllers/navigation_screen_controller.dart';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigatonScreenBinding extends Bindings {
  @override
  void dependencies() {
    _initialiseServices();
    _initialiseRepositories();
    _initialiseControllers();
  }

  void _initialiseControllers() {
  print("Initializing NavigationScreenController");
  Get.lazyPut(()=>NavigationScreenController());
  print("Initializing RegisterMachineScreenController");
  Get.put(RegisterMachineScreenController());
  print("Initializing MachineDashboardScreenController");
  Get.put(MachineDashboardScreenController());
}

void _initialiseRepositories() {
  final networkService = Get.find<NetworkService>(); 
  final sessionService = Get.find<SessionService>(); 
  Get.lazyPut<MachineRepository>(() => MachineRepository(networkService, sessionService));
}


  void _initialiseServices() {
    Get.put(NetworkService(_configureDio()));
    Get.put(FileDownloaderService());
    Get.put(RefreshService());
    if (Get.arguments is UiLoginData) {
      Get.put(SessionService(
        orgId: Get.arguments.orgId,
      ));
    }
  }

  Dio _configureDio() {
    var dio = Dio();
    dio.options.headers = {
      "apiKey": "wuyRdtRBW931fEcgB9BPE124V3Um9Fae6FcFI4E4"
    };
    dio.interceptors
        .add(LogInterceptor(logPrint: (o) => debugPrint(o.toString())));
    dio.interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: true));

    return dio;
  }
}