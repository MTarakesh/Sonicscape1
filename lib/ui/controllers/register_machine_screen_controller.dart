import 'package:SonicScape/data/models/network_service_models/machine_request.dart';
import 'package:SonicScape/data/repository/mahine_repository.dart';
import 'package:SonicScape/data/utils/extensions.dart';
import 'package:SonicScape/ui/screens/registermachine/registration_dialog.dart';
import 'package:SonicScape/ui/uistates/result_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterMachineScreenController extends GetxController {
  // dependencies
  final _repository = Get.find<MachineRepository>();

  // reactive variables
  var registrationState = Rx<ResultState>(Success());

  // UI controllers
  final TextEditingController sensorIdController = TextEditingController();
  final TextEditingController machineIdController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController machineTypeController = TextEditingController();
  final TextEditingController machineAgeController = TextEditingController();
  final TextEditingController latestServiceDateController = TextEditingController();
  final TextEditingController nextServiceDateController = TextEditingController();

  // non-reactive variables
  var _machineInfo = MachineRequest(
      uuid: "",
      machineId: "",
      name: "",
      emailId: "",
      phoneNumber: "",
      type: "",
      age: 0,
      lastServiceDate: DateTime.now().millisecondsSinceEpoch,
      nextServiceDate: DateTime.now().millisecondsSinceEpoch);

  void updateLatestServiceDate(DateTime? serviceDate) {
    var selectedDate = (serviceDate ?? DateTime.now());
    var milliSecondTimeStamp =
        (serviceDate ?? DateTime.now()).millisecondsSinceEpoch;
    _machineInfo = _machineInfo.copyWith(lastServiceDate: milliSecondTimeStamp);
    latestServiceDateController.text =
        selectedDate.toHumanRedableFormatNoTime();
  }

  void updateNextServiceDate(DateTime? serviceDate) {
    var selectedDate = (serviceDate ?? DateTime.now());
    var milliSecondTimeStap =
        (serviceDate ?? DateTime.now()).millisecondsSinceEpoch;
    _machineInfo = _machineInfo.copyWith(nextServiceDate: milliSecondTimeStap);
    nextServiceDateController.text = selectedDate.toHumanRedableFormatNoTime();
  }

  void updateMachineAge(DateTime dateTime) {
    var age = (DateTime.now().year) - dateTime.year;
    _machineInfo = _machineInfo.copyWith(age: age);
    machineAgeController.text = "$age years";
  }

  void updateSensorId(String id) {
    sensorIdController.text = id;
  }

  void feedUserInputToMachineMasterItem() {
    _machineInfo = _machineInfo.copyWith(
        uuid: sensorIdController.text.trim().toLowerCase(),
        phoneNumber: phoneNumberController.text.trim(),
        emailId: emailController.text.trim().toLowerCase(),
        machineId: machineIdController.text.trim().toLowerCase(),
        name: nameController.text.trim(),
        type: machineTypeController.text.trim().toLowerCase());
  }

  Future<void> registerMachine() async {
    registrationState.value = Loading();
    feedUserInputToMachineMasterItem();
    await _repository.registerMachine(_machineInfo);
    var shouldAddMore =
        await Get.dialog(RegistrationDialog(registrationState: Success()));
    if (shouldAddMore == true) {
      clearLimitedData();
    } else {
      clearData();
    }
    registrationState.value = Success();
  }

  void clearData() {
    clearLimitedData();
    machineIdController.clear();
    nameController.clear();
    phoneNumberController.clear();
    emailController.clear();
    machineTypeController.clear();
    machineAgeController.clear();
    latestServiceDateController.clear();
    nextServiceDateController.clear();
  }

  void clearLimitedData() {
    sensorIdController.clear();
  }
}
