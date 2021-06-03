import 'package:get/get.dart';
import 'package:kero_bake/models/menu.dart';

class MenuController extends GetxController {
  final menu = <Menu>[].obs;
  final currentImage = 0.obs;

  Menu currentMenu() {
    return menu[currentImage.value];
  }

  void updateImage(int index) {
    currentImage.value = index;
  }
}
