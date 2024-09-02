import 'package:SonicScape/ui/plugins/definitions/ui_plugin.dart';
import 'package:SonicScape/ui/plugins/selected_machine_plugin/selected_machine_controller.dart';
import 'package:SonicScape/ui/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectedMachineDataPlugin extends UiPlugin {
  late SelectedMachinePluginController uiController;
  bool shouldShowSensorId;

  SelectedMachineDataPlugin({this.shouldShowSensorId = true}) {
    uiController = Get.put(SelectedMachinePluginController());
  }

  @override
  Widget view() => SelectedMachineDataPluginView(
        controller: uiController,
        shouldShowSensorId: shouldShowSensorId,
      );
}

class SelectedMachineDataPluginView extends StatelessWidget {
  const SelectedMachineDataPluginView(
      {super.key,
      required this.controller,
      this.expanded = true,
      this.shouldShowSensorId = true});
  final SelectedMachinePluginController controller;
  final bool expanded;
  final bool shouldShowSensorId;

  @override
  Widget build(BuildContext context) {
    if (expanded) {
      return Padding(
        padding: const EdgeInsets.only(left: 16, bottom: 8, right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(
                    () => SizedBox(
                      width: 200,
                      child: Text(
                          overflow: TextOverflow.ellipsis,
                          "$serviceMaster: \n${controller.currentSelectedDevice.value?.name ?? "--"}"),
                    ),
                  ),
                  Obx(
                    () => SizedBox(
                      width: 170,
                      child: Text(
                          overflow: TextOverflow.ellipsis,
                          "$strMachineId: ${controller.currentSelectedDevice.value?.machineId ?? "--"}"),
                    ),
                  ),
                ],
              ),
            ),
            shouldShowSensorId
                ? Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                        "$sensorId: ${controller.selectedSensorId ?? "--"}"))
                : const SizedBox(),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 16, bottom: 8, right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => Text(
                  "$serviceMaster: ${controller.currentSelectedDevice.value?.name ?? "--"}"),
            ),
            Obx(
              () => Text(
                  "$strMachineId: ${controller.currentSelectedDevice.value?.machineId ?? "--"}"),
            ),
          ],
        ),
      );
    }
  }
}
