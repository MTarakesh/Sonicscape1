import 'package:SonicScape/ui/app_routes.dart';
import 'package:get/get.dart';



class NavigationScreenController extends GetxController {
  static NavigationScreenController get to => Get.find();

  var currentIndex = 0.obs;
  final _pages = <String>[
    AppRoutes.registerMachineScreen,
    AppRoutes.machineDashboardScreen,
  ];
  String get currentPageRoute => _pages[currentIndex.value];

  void changePage(int index) {
    currentIndex.value = index;
    print("Navigating to $currentPageRoute");
    Get.toNamed(currentPageRoute, id: 1, preventDuplicates: true);
  }

  void navigateToAddScreen() => Get.toNamed(AppRoutes.registerMachineScreen,
      id: 1, preventDuplicates: true);
  void navigateTodDashboard() => Get.toNamed(AppRoutes.machineDashboardScreen,
      id: 1, preventDuplicates: true);
}

