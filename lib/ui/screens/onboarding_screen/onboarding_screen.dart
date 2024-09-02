import 'package:SonicScape/ui/app_routes.dart';
import 'package:SonicScape/data/models/uimodels/ui_onboard_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/content_template.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int selectedIndex = 0;
  late PageController controller;

  @override
  void initState() {
    controller =
        PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        actions: [skipBtn(context), const SizedBox(width: 20)],
      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: PageView.builder(
                  itemCount: KDummyData.onBoardItemList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller,
                  onPageChanged: (v) {
                    setState(() {
                      selectedIndex = v;
                    });
                  },
                  itemBuilder: (context, index) {
                    return ContentTemplate(
                        item: KDummyData.onBoardItemList[index]);
                  }),
            ),
            Row(
              children: [
                SizedBox(width: size.width * 0.05),
                Row(
                  children: List.generate(
                    KDummyData.onBoardItemList.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                      height: 8,
                      width: selectedIndex == index ? 24 : 8,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                          color: selectedIndex == index
                              ? Theme.of(context).colorScheme.primaryContainer
                              : Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    if (selectedIndex < KDummyData.onBoardItemList.length - 1) {
                      controller.animateToPage(selectedIndex + 1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease);
                    } else {
                      Get.offNamed(AppRoutes.loginScreen);
                    }
                  },
                  child: CircleAvatar(
                    radius: 35,
                    child:
                        selectedIndex != KDummyData.onBoardItemList.length - 1
                            ? const Icon(
                                Icons.arrow_forward,
                                size: 30,
                              )
                            : Text(
                                "Start",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.15),
          ],
        ),
      ),
    );
  }

  GestureDetector skipBtn(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.offAllNamed(AppRoutes.loginScreen);
      },
      child: Text(
        "SKIP",
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }
}

class KDummyData {
  static List<UiOnBoardItems> onBoardItemList = [
    UiOnBoardItems(
      image: 'assets/images/Onboarding 2.jpg',
      title: "Predective maintainence",
    ),
    UiOnBoardItems(
      image: 'assets/images/Onboarding 3.png',
      title: "Easy to use",
    ),
    UiOnBoardItems(
      image: 'assets/images/Onboarding 4.png',
      title: "Real time data",
    )
  ];
}
