import 'package:flutter/material.dart';

class FormHeaderwidget extends StatelessWidget {
  const FormHeaderwidget({
    Key? key,
    this.imageColor,
    this.heightBetween,
    required this.image,
    required this.title,
    required this.subtitle,
    this.imageHeight = 0.2,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.textAlign,
  }) : super(key: key);

  final Color? imageColor;
  final double imageHeight;
  final double? heightBetween;
  final String image, title, subtitle;
  final CrossAxisAlignment crossAxisAlignment;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(image: AssetImage(image), height: 250),
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        Text(subtitle,
            textAlign: textAlign,
            style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
