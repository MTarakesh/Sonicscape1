import 'package:SonicScape/di/bindings/issue_tracker_screen_binding.dart';
import 'package:SonicScape/di/bindings/navigation_screen_binding.dart';
import 'package:SonicScape/di/bindings/report_screen_binding.dart';
import 'package:SonicScape/ui/screens/issuetracker/machine_issue_edititng_screen.dart';
import 'package:SonicScape/ui/screens/issuetracker/machine_issue_tracker_screen.dart';
import 'package:SonicScape/ui/screens/login/login_screen.dart';
import 'package:SonicScape/ui/screens/machine_dashboard/machine_dashboard_screen.dart';
import 'package:SonicScape/ui/screens/registermachine/register_machine_screen.dart';
import 'package:SonicScape/ui/screens/navigator/navigator_screen.dart';
import 'package:SonicScape/ui/screens/onboarding_screen/onboarding_screen.dart';
import 'package:SonicScape/ui/screens/analysis/analysis_screen.dart';
import 'package:SonicScape/ui/screens/datavisualisation/data_visulisation_screen.dart';
import 'package:SonicScape/ui/screens/reports/reports_screen.dart';
import 'package:SonicScape/ui/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/default_route.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoutes {
  static const String splashScreen = "/";
  static const String onboardingScreen = "/onboardingScreen";
  static const String loginScreen = '/loginScreen';
  static const String navigationScreen = "/navigationScreen";
  static const String registerMachineScreen = "/registerMachineScreen";
  static const String machineDashboardScreen = "/machineDashboardScreen";
  static const String dataVisualisationScreen = "/dataVisualisationScreen";
  static const String analysisScreen = "/analysisScreen";
  static const String machineIssueTrackerScreen = "/machineIssueTrackerScreen";
  static const String machineIssueEditingScreen = "/machineIssueEditingScreen";
  static const String reportsScreen = "/reportsScreen";

  static List<GetPage<dynamic>> generateGetPages() {
    return [
      GetPage(name: splashScreen, page: () => const SplashScreen()),
      GetPage(name: onboardingScreen, page: () => const OnboardingScreen()),
      GetPage(name: loginScreen, page: () => const LoginScreen()),
      GetPage(
        name: navigationScreen,
        page: () => const NavigationPage(),
        binding: NavigatonScreenBinding(),
      ),
      GetPage(
        name: dataVisualisationScreen,
        page: () => const DataVisualisationScreen(),
        binding: ReportScreenBinding(),
      ),
      GetPage(name: analysisScreen, page: () => const AnalysisScreen()),
      GetPage(
        name: machineIssueTrackerScreen,
        page: () => const MachineIssueTrackerScreen(),
        binding: MachineIssueTrackerScreenBinding(),
      ),
      GetPage(
        name: machineIssueEditingScreen,
        page: () => const MachineIssueEditingScreen(),
      ),
      GetPage(name: reportsScreen, page: () => const ReportsScreen()),
    ];
  }

  static Route? generatePagesWithBottomBar(RouteSettings settings) {
    switch (settings.name) {
      case registerMachineScreen:
      {
        return GetPageRoute(
          settings: settings,
          page: () => const RegisterMachineScreen(),
        );
      }  
      case machineDashboardScreen:
       {
        return GetPageRoute(
          settings: settings,
          page: () => const MachineDashboardScreen(),
        );
       }
      default:
       {
        return null;
    }
    }
  }
}