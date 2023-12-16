import 'package:donate/pages/welcome/controller.dart';
import 'package:get/get.dart';

import 'controller.dart';

class ReceivedRequestDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReceivedRequestDetailController>(() => ReceivedRequestDetailController());
    // TODO: implement dependencies
  }
}
