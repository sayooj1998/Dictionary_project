import 'package:get/get.dart';

class ColorController extends GetxController {
  final selectIndex = 0.obs;
  void setIndex(int index) {
    selectIndex.value = 0;
  }
}
