import 'package:get/get.dart';

import 'controller.dart';

class ReceivedRequestBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReceivedRequestController>(() => ReceivedRequestController());
    // TODO: implement dependencies
  }
}
