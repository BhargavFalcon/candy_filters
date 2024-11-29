import 'package:get/get.dart';

import '../controllers/edit_screen_controller.dart';

class EditScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditScreenController>(
      () => EditScreenController(),
    );
  }
}
