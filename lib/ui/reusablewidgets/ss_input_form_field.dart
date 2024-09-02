import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SSInputFormFeild extends StatelessWidget {
  const SSInputFormFeild(
      {super.key,
      required this.textEditingController,
      required this.decoration,
      this.onTap,
      this.keyboardType,
      this.readOnly = false,
      this.maxLines,
      this.inputFormatters});

  final InputDecoration decoration;
  final TextEditingController textEditingController;
  final Function()? onTap;
  final bool readOnly;
  final TextInputType? keyboardType;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: decoration,
        readOnly: readOnly,
        onTap: onTap,
        controller: textEditingController,
      ),
    );
  }
}
