import 'package:flutter/widgets.dart';

abstract class UiPlugin {
  Widget view();
  void sync() {}
}
