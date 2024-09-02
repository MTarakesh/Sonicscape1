import 'package:SonicScape/ui/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class SensorIdScannerDialog extends StatelessWidget {
  const SensorIdScannerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(scanSensorID),
      content: SizedBox(
        height: 200,
        width: 200,
        child: MobileScanner(
          onDetect: (barcodeCapture) {
            var code = barcodeCapture.barcodes.firstOrNull;
            if (code != null) {
              Get.back(result: code.displayValue);
            }
          },
        ),
      ),
    );
  }
}
