import 'package:SonicScape/ui/controllers/machine_issue_tracker_screen_controller.dart';
import 'package:get/get.dart';

class MachineIssueTrackerScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MachineIssuesTrasckerScreenController());
  }
}
