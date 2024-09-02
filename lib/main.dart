import 'package:SonicScape/data/repository/mahine_repository.dart';
import 'package:SonicScape/data/repository/session_repository.dart';
import 'package:SonicScape/data/service/network_service.dart';
import 'package:SonicScape/data/service/refresh_service.dart';
import 'package:SonicScape/data/service/session_service.dart';
import 'package:SonicScape/ui/app_routes.dart';
import 'package:SonicScape/ui/controllers/machine_dashboard_screen_controller.dart';
import 'package:SonicScape/ui/controllers/navigation_screen_controller.dart';
import 'package:SonicScape/ui/firebase/firbasemessaging.dart';
import 'package:SonicScape/ui/resources/colors.dart';
import 'package:SonicScape/ui/resources/strings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

// Define a global navigator key
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessagingService().initialize();

  final dio = Dio();
  dio.options.headers = {
    "apiKey": "wuyRdtRBW931fEcgB9BPE124V3Um9Fae6FcFI4E4"
  };

  // Debugging
  print('Initializing network service');

  final networkService = NetworkService(dio);
  const orgId = uniqueID;
  print('Organization ID: $orgId');

  final sessionService = SessionService(orgId: orgId);
  Get.put(sessionService);
  Get.put(networkService);

  print('Registering repositories and services');
  Get.put(MachineRepository(networkService, Get.find<SessionService>()));
  Get.put(SessionRepository(Get.find<SessionService>(), Get.find<MachineRepository>()));
  Get.put(RefreshService());

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey, // Set the global navigator key here
      title: 'SonicScape',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: appColor.primaryColor),
        textTheme: const TextTheme(
            bodySmall: TextStyle(fontFamily: 'Poppins'),
            bodyMedium: TextStyle(fontFamily: 'Poppins'),
            bodyLarge: TextStyle(fontFamily: 'Poppins'),
            displayLarge: TextStyle(fontFamily: 'Poppins')),
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: Colors.transparent, width: 0),
          ),
        ),
      ),
      initialRoute: AppRoutes.splashScreen,
      getPages: AppRoutes.generateGetPages(),
      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder(() {
        Get.put(NavigationScreenController());
        Get.put(MachineDashboardScreenController());
      }),
    );
  }
}

