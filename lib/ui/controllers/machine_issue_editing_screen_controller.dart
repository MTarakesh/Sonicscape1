import 'package:SonicScape/data/models/network_service_models/update_issue_request.dart';
import 'package:SonicScape/data/models/uimodels/ui_machine_issue.dart';
import 'package:SonicScape/data/repository/mahine_repository.dart';
import 'package:SonicScape/data/utils/extensions.dart';
import 'package:SonicScape/ui/resources/strings.dart';
import 'package:SonicScape/ui/uistates/result_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MachineIssueEditingScreenController extends GetxController {
  final _repository = Get.find<MachineRepository>();

  final TextEditingController issueIdController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  var updateIssueState = Rx<ResultState>(Success());

  late UiMachineIssue _currentIssue;
  late bool _approveBySMController;
  late bool _issueStatusController;
  late bool _issueVaildController;
  var dropdownTrueFalse = [strTrue, strFalse];

  get approveBySMController => _approveBySMController.toString();
  get issueStatusController => _issueStatusController.toString();
  get issueVaildController => _issueVaildController.toString();

  set updateApproveBySm(String value) =>
      _approveBySMController = value.toBool();
  set updateIssueStatus(String value) =>
      _issueStatusController = value.toBool();
  set updateissueVaild(String value) => _issueVaildController = value.toBool();

  @override
  void onInit() {
    super.onInit();
    _fetchIssue();
  }

  void _fetchIssue() {
    if (Get.arguments is UiMachineIssue) {
      _currentIssue = Get.arguments;
      issueIdController.text = _currentIssue.id;
      descriptionController.text = _currentIssue.description;
      _approveBySMController = _currentIssue.approvedBySM;
      _issueStatusController = _currentIssue.issueClosed;
      _issueVaildController = _currentIssue.isIssueValid;
    }
  }

  Future<void> updateIssue() async {
    var updateRequest = UpdateIssueRequest(
      id: _currentIssue.id,
      description: descriptionController.text.trim(),
      issueClosed: _issueStatusController.toInt(),
      isIssueValid: _issueVaildController.toInt(),
      approvedBySM: _approveBySMController.toInt(),
    );
    updateIssueState.value = Loading();
    await _repository.updateMachineIssue(updateRequest);
    Get.back(result: true);
  }
}
