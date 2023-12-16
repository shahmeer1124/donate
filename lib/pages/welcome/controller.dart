import 'package:donate/common/routes/names.dart';
import 'package:donate/common/store/config.dart';
import 'package:donate/pages/welcome/state.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController {
  final state = WelcomeState();
  WelcomeController();

  handleSignIn() async {
    await ConfigStore.to.saveAlreadyOpen();
    Get.offAndToNamed(AppRoutes.SIGN_IN);
  }
}
