import 'package:flutter/material.dart';

class SSDropDownFormFeild extends StatelessWidget {
  const SSDropDownFormFeild({
    super.key,
    required this.decoration,
    required this.dropDownValues,
    required this.initialValue,
    required this.onPressed,
  });

  final InputDecoration decoration;
  final Function(String) onPressed;
  final List<String> dropDownValues;
  final String initialValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField(
        decoration: decoration,
        onChanged: (value) {
          if (value != null) {
            onPressed(value);
          }
        },
        value: initialValue,
        items: dropDownValues
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
      ),
    );
  }
}
