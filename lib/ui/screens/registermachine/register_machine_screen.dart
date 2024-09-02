import 'package:SonicScape/ui/controllers/register_machine_screen_controller.dart';
import 'package:SonicScape/ui/resources/strings.dart';
import 'package:SonicScape/ui/reusablewidgets/ss_input_form_field.dart';
import 'package:SonicScape/ui/screens/registermachine/sensor_id_scanner_dialog.dart';
import 'package:SonicScape/ui/uistates/result_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RegisterMachineScreen extends StatelessWidget {
  const RegisterMachineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(RegisterMachineScreenController()); // Initialize the controller

    return Scaffold(
      appBar: AppBar(
        title: const Text(machineRegistration),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SSInputFormFeild(
                  decoration: const InputDecoration(
                    label: Text(sensorId,
                    style: TextStyle(color: Colors.black),
                    ),
                    icon: Icon(Icons.barcode_reader),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  textEditingController: controller.sensorIdController,
                  onTap: () async {
                    controller.updateSensorId(
                        await Get.dialog(const SensorIdScannerDialog()));
                  },
                  readOnly: true,
                ),
                SSInputFormFeild(
                  decoration: const InputDecoration(
                    label: Text(strMachineId,
                    style: TextStyle(color: Colors.black),
                    ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                  ),
                  textEditingController: controller.machineIdController,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(strMachineIdLimit)
                  ],
                ),
                SSInputFormFeild(
                  decoration: const InputDecoration(
                    label: Text(machineMasterName,
                    style: TextStyle(color: Colors.black),
                    ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                  ),
                  textEditingController: controller.nameController,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(strMachineMasterNameLimit)
                  ],
                ),
                SSInputFormFeild(
                  decoration: const InputDecoration(
                    label: Text(machineMasterEmailId,
                    style: TextStyle(color: Colors.black),
                    ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                  ),
                  textEditingController: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(strEmailIdLimit)
                  ],
                ),
                SSInputFormFeild(
                  decoration: const InputDecoration(
                    label: Text(machineMasterPhoneNumber,
                    style: TextStyle(color: Colors.black),
                    ),
                    prefix: Text("+91 "),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                  ),
                  textEditingController: controller.phoneNumberController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(strPhoneNumberLimit)
                  ],
                ),
                SSInputFormFeild(
                  decoration: const InputDecoration(
                    label: Text(machineType,
                    style: TextStyle(color: Colors.black),
                    ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                  ),
                  textEditingController: controller.machineTypeController,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(strMachineTypeLimit)
                  ],
                ),
                SSInputFormFeild(
                  decoration: const InputDecoration(
                    label: Text(machineAge,
                    style: TextStyle(color: Colors.black),
                    ),
                 enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                  ),
                  textEditingController: controller.machineAgeController,
                  keyboardType: TextInputType.number,
                  onTap: () {
                    Get.dialog(MachineAgeYearPicker(
                        onDateSelected: (date) =>
                            controller.updateMachineAge(date)));
                  },
                  readOnly: true,
                ),
                SSInputFormFeild(
                  decoration: const InputDecoration(
                    label: Text(lastestServiceDate,
                    style: TextStyle(color: Colors.black),
                    ),
                    icon: Icon(Icons.calendar_month),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                  ),
                  textEditingController: controller.latestServiceDateController,
                  onTap: () async {
                    var currentDate = DateTime.now();
                    var selectedDate = await showDatePicker(
                        context: context,
                        initialDate: null,
                        firstDate: DateTime(currentDate.year - 50),
                        lastDate: currentDate);
                    controller.updateLatestServiceDate(selectedDate);
                  },
                  readOnly: true,
                ),
                SSInputFormFeild(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_month),
                    label: Text(strNextServiceDate,
                    style: TextStyle(color: Colors.black),
                    ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                  ),
                  textEditingController: controller.nextServiceDateController,
                  onTap: () async {
                    var currentDate = DateTime.now();
                    var selectedDate = await showDatePicker(
                        context: context,
                        initialDate: null,
                        firstDate: currentDate,
                        lastDate: DateTime((currentDate.year + 50)));
                    controller.updateNextServiceDate(selectedDate);
                  },
                  readOnly: true,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  width: double.infinity,
                  child: Obx(() {
                    switch (controller.registrationState.value.runtimeType) {
                      case Loading:
                        return const Center(child: CircularProgressIndicator());

                      default:
                        return OutlinedButton(
                          onPressed: controller.registerMachine,
                          style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                          backgroundColor: Colors.black,
                        ),
                          child: const Text(registerbutton,
                          style: TextStyle(color: Colors.white),
                          ),
                        );
                    }
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MachineAgeYearPicker extends StatelessWidget {
  const MachineAgeYearPicker({
    super.key,
    required this.onDateSelected,
  });

  final Function(DateTime) onDateSelected;

  @override
  Widget build(BuildContext context) {
    var currentDate = DateTime.now();

    return AlertDialog(
      title: const Text(machineManufactureDate),
      content: SizedBox(
        height: 200,
        width: 200,
        child: YearPicker(
          firstDate: DateTime(currentDate.year - 50),
          lastDate: currentDate,
          selectedDate: currentDate,
          onChanged: (date) {
            onDateSelected(date);
            Get.back();
          },
        ),
      ),
    );
  }
}
