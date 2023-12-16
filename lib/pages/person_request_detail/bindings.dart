import 'package:donate/pages/welcome/controller.dart';
import 'package:get/get.dart';

import 'controller.dart';

class OwnRequestBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OwnRequestDetailController>(() => OwnRequestDetailController());
    // TODO: implement dependencies
  }
}
