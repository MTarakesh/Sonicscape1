import 'package:SonicScape/data/utils/extensions.dart';
import 'package:SonicScape/ui/resources/strings.dart';
import 'package:SonicScape/ui/reusablewidgets/ss_input_form_field.dart';
import 'package:flutter/material.dart';

class SSDataRangePicker extends StatelessWidget {
  const SSDataRangePicker({
    super.key,
    required this.onDateChanged,
    this.label,
  });

  final Function(DateTime fromDate, DateTime toDate) onDateChanged;
  final String? label;

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    return SSInputFormFeild(
      textEditingController: textEditingController,
      decoration: InputDecoration(
        label: Text(label ?? strFromToDate),
        icon: const Icon(Icons.calendar_month),
      ),
      maxLines: 2,
      readOnly: true,
      onTap: () async {
        var currentDate = DateTime.now();
        var fromDate = await showDatePicker(
          helpText: strFromDate,
          context: context,
          initialDate: null,
          firstDate: DateTime(currentDate.year - 50),
          lastDate: currentDate,
        );
        if (fromDate != null) {
          if (!context.mounted) return;
          var fromTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
            barrierLabel: strToTime,
          );
          fromDate =
              fromDate.copyWith(hour: fromTime?.hour, minute: fromTime?.minute);
          if (!context.mounted) return;
          var toDate = await showDatePicker(
            helpText: strToDate,
            context: context,
            initialDate: fromDate,
            firstDate: fromDate,
            lastDate: currentDate,
          );
          if (toDate != null) {
            if (!context.mounted) return;
            var toTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
              barrierLabel: strFromDate,
            );
            toDate =
                toDate.copyWith(hour: toTime?.hour, minute: fromTime?.minute);
            textEditingController.text =
                "To: ${fromDate.toHumanRedableFormat()} \n From: ${toDate.toHumanRedableFormat()}";
            onDateChanged(fromDate, toDate);
          }
        }
      },
    );
  }
}
