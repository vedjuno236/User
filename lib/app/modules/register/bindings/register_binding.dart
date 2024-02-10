import 'package:flutter_final/app/modules/register/controllers/register_controller.dart';
import 'package:get/get.dart';


class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(
          () => RegisterController(),
    );
  }
}
