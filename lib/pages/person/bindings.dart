import 'package:get/get.dart';

import 'controller.dart';

class PersonBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonController>(() => PersonController());

  }
}