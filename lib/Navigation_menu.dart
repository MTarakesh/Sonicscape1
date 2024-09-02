// import 'package:SonicScape/screens/Create/create.dart';
// import 'package:SonicScape/screens/report_complete_screen/report_complete_screen.dart';
// import 'package:SonicScape/screens/home/home.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class NavigationMenu extends StatelessWidget {
//   const NavigationMenu({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(NavigationController());

//     return Scaffold(
//       bottomNavigationBar: Obx(
//         () => NavigationBar(
//           height: 80,
//           elevation: 0,
//           selectedIndex: controller.selectedIndex.value,
//           onDestinationSelected: (index) =>
//               controller.selectedIndex.value = index,
//           destinations: const [
//             NavigationDestination(
//                 icon: Icon(Icons.add_home_work_rounded), label: 'Add'),
//             NavigationDestination(
//                 icon: Icon(Icons.dashboard_customize_rounded),
//                 label: 'Dashboard'),
//             NavigationDestination(
//                 icon: Icon(Icons.bar_chart_rounded), label: 'Report'),
//           ],
//         ),
//       ),
//       body: Obx(() => controller.screens[controller.selectedIndex.value]),
//     );
//   }
// }

// class NavigationController extends GetxController {
//   final Rx<int> selectedIndex = 0.obs;

//   final screens = [CreatePage(), HomeScreen(), ReportCompleteScreen()];
// }
