import 'package:flutter/material.dart';

import '../../../../data/models/uimodels/ui_onboard_items.dart';

class ContentTemplate extends StatelessWidget {
  const ContentTemplate({
    super.key,
    required this.item,
  });

  final UiOnBoardItems item;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Image.asset(
          item.image,
          height: size.height * 0.3,
        ),
        SizedBox(height: size.height * 0.05),
        FittedBox(
          child: Text(
            item.title,
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(height: size.height * 0.02),
        SizedBox(height: size.height * 0.1),
      ],
    );
  }
}
