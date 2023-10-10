import 'package:get/get.dart';

import '../controllers/bus_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BusController>(
      () => BusController(),
    );
  }
}
