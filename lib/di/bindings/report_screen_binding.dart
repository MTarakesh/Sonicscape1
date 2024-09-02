import 'package:SonicScape/data/repository/reports_repository.dart';
import 'package:get/get.dart';

class ReportScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ReportsRepository());
  }
}
