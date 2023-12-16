import 'package:donate/pages/welcome/controller.dart';
import 'package:get/get.dart';

import 'controller.dart';

class RequestBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequestController>(() => RequestController());
    // TODO: implement dependencies
  }
}
