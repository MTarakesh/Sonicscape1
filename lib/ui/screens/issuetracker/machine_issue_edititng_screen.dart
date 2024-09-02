import 'package:SonicScape/ui/controllers/machine_issue_editing_screen_controller.dart';
import 'package:SonicScape/ui/resources/strings.dart';
import 'package:SonicScape/ui/reusablewidgets/ss_dorpdown_form_field.dart';
import 'package:SonicScape/ui/reusablewidgets/ss_input_form_field.dart';
import 'package:SonicScape/ui/uistates/result_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MachineIssueEditingScreen extends StatelessWidget {
  const MachineIssueEditingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(MachineIssueEditingScreenController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(strTitleIssueEditing),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SSInputFormFeild(
                  readOnly: true,
                  textEditingController: controller.issueIdController,
                  decoration: const InputDecoration(
                    label: Text(
                      strId,
                      style: TextStyle(color: Colors.black),),
                  ),
                ),
                SSInputFormFeild(
                  textEditingController: controller.descriptionController,
                  decoration: const InputDecoration(
                    label: Text(
                      strDescription,
                      style: TextStyle(color: Colors.black),
                      ),
                  ),
                ),
                SSDropDownFormFeild(
                  decoration: const InputDecoration(
                    label: Text(
                      strApproveBySm,
                      style: TextStyle(color: Colors.black),
                      ),
                  ),
                  dropDownValues: controller.dropdownTrueFalse,
                  initialValue: controller.approveBySMController,
                  onPressed: (value) {
                    controller.updateApproveBySm = value;
                  },
                ),
                SSDropDownFormFeild(
                  decoration: const InputDecoration(
                    
                    label: Text(
                      strIssueStatus,
                      style: TextStyle(color: Colors.black),
                      ),
                  ),
                  dropDownValues: controller.dropdownTrueFalse,
                  initialValue: controller.issueStatusController,
                  onPressed: (value) {
                    controller.updateIssueStatus = value;
                  },
                ),
                SSDropDownFormFeild(
                  decoration: const InputDecoration(
                    label: Text(
                      strIssueValid,
                      style: TextStyle(color: Colors.black),
                      ),
                  ),
                  dropDownValues: controller.dropdownTrueFalse,
                  initialValue: controller.issueVaildController,
                  onPressed: (value) {
                    controller.updateissueVaild = value;
                  },
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  width: double.infinity,
                  child: Obx(() {
                    switch (controller.updateIssueState.value.runtimeType) {
                      case Loading:
                        return const Center(child: CircularProgressIndicator());

                      default:
                        return OutlinedButton(
                          onPressed: controller.updateIssue,
                          child: const Text(
                            strUpdateButton,
                            style: TextStyle(color: Colors.black),
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
