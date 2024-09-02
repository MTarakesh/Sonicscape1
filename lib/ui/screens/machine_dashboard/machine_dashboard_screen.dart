import 'package:SonicScape/data/utils/extensions.dart';
import 'package:SonicScape/ui/app_routes.dart';
import 'package:SonicScape/data/models/uimodels/ui_machine.dart';
import 'package:SonicScape/ui/resources/strings.dart';
import 'package:SonicScape/ui/enums/menu_option.dart';
import 'package:SonicScape/data/models/uimodels/ui_machine_status.data.dart';
import 'package:SonicScape/ui/controllers/machine_dashboard_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MachineDashboardScreen extends StatelessWidget {
  const MachineDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<MachineDashboardScreenController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('SonicScape'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 247, 247, 247),
        actions: [
          Obx(
            () => controller.isSynchronizing.value
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(synchonizing),
                  )
                : IconButton(
                    onPressed: () => controller.syncNewData(),
                    icon: const Icon(Icons.sync),
                  ),
          ),
          PopupMenuButton<MenuOption>(
            onSelected: controller.handleMenu,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuOption>>[
              const PopupMenuItem<MenuOption>(
                value: MenuOption.signOut,
                child: Text(signOut),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Searchbar(viewModel: controller),
            Expanded(
              flex: 20,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.machineMasterData.length,
                    itemBuilder: (context, index) => MachineItemWidget(
                      item: controller.machineMasterData[index],
                      onClicked: (item) {
                        controller.selectMachine(item);
                        debugPrint("Navigating to data visualization screen");
                        Get.toNamed(AppRoutes.dataVisualisationScreen);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Searchbar extends StatelessWidget {
  const Searchbar({
    super.key,
    required this.viewModel,
  });

  final MachineDashboardScreenController viewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextField(
        controller: viewModel.textController,
        focusNode: viewModel.focusNode,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          hintText: "Search".toUpperCase(),
          prefixIcon: const Icon(Icons.search),
        ),
        onChanged: (userSearchText) =>
            viewModel.searchForMachine(userSearchText),
        onTapOutside: (event) => viewModel.stopSearching(),
      ),
    );
  }
}

class MachineItemWidget extends StatelessWidget {
  const MachineItemWidget(
      {super.key, required this.item, required this.onClicked});

  final UiMachine item;
  final Function(UiMachine) onClicked;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClicked(item),
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(vertical: 8),
        height: 150,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 227, 244, 251),
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            border: Border.all(
              color: Colors.black, // Set your desired border color here
              width: 1.2, // Set the border width if needed
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                MachineInfoItem(
                    icon: Icons.settings,
                    msg: "${item.type} (${item.machineId})"),
                MachineInfoItem(
                    icon: Icons.access_time, msg: item.age.toYears()),
                Row(
                  children: [
                    MachineInfoItem(
                        icon: Icons.build,
                        msg: item.nextServiceDate.toHumanRedableFormatNoTime()),
                    const SizedBox(
                      width: 16,
                    ),
                    MachineInfoItem(
                        icon: Icons.engineering,
                        msg: item.nextServiceDate.toHumanRedableFormatNoTime()),
                  ],
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: item.uuid
                  .map(
                    (e) => MachineInfoItem(icon: Icons.memory, msg: e),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}

class MachineInfoItem extends StatelessWidget {
  const MachineInfoItem({
    super.key,
    required this.icon,
    required this.msg,
  });

  final IconData icon;
  final String msg;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(
            width: 4,
          ),
          Text(
            msg,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class MachineStatusWidget extends StatelessWidget {
  const MachineStatusWidget({
    super.key,
    required this.controller,
  });

  final MachineDashboardScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.machineStatusData.isNotEmpty
          ? SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.machineStatusData.length,
                itemBuilder: (context, index) => MachineStatusItem(
                    item: controller.machineStatusData[index]),
              ),
            )
          : const Text(noMachineStatusData),
    );
  }
}

class MachineStatusItem extends StatelessWidget {
  const MachineStatusItem({
    super.key,
    required this.item,
  });

  final UiMachineStatusData item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: item.status ? Colors.greenAccent : Colors.redAccent,
      ),
      child: Text(
        item.machineName,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
