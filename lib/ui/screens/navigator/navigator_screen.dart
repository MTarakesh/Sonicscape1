import 'package:SonicScape/ui/app_routes.dart';
import 'package:SonicScape/ui/controllers/navigation_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationPage extends GetView<NavigationScreenController> {
  const NavigationPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        observers: [GetObserver((_) {}, Get.routing)],
        key: Get.nestedKey(1),
        initialRoute: AppRoutes.registerMachineScreen,
        onGenerateRoute: AppRoutes.generatePagesWithBottomBar,
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.add_home_work_rounded),
              label: 'Add',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_customize_rounded),
              label: 'Dashboard',
            ),
          ],
          currentIndex: controller.currentIndex.value,
          selectedItemColor: Colors.black,
          onTap: controller.changePage,
        ),
      ),
    );
  }
}
