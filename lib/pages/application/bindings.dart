import 'package:donate/pages/request_page/controller.dart';
import 'package:donate/pages/welcome/controller.dart';
import 'package:get/get.dart';

import '../person/controller.dart';
import '../received_request/controller.dart';
import 'controller.dart';

class ApplicationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplicationController>(() => ApplicationController());
    Get.lazyPut<RequestController>(()=>RequestController());
    Get.lazyPut<ReceivedRequestController>(()=>ReceivedRequestController());
    // Get.lazyPut<PersonController>(()=>PersonController());



    // TODO: implement dependencies
  }
}
