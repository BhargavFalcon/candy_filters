import 'package:candy_filters/constant/argumentConstant.dart';
import 'package:get/get.dart';

class EditScreenController extends GetxController {
  RxString profilePhoto = "".obs;
  @override
  void onInit() {
    if (Get.arguments != null) {
      profilePhoto.value = Get.arguments[ArgumentConstant.pickImage];
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
