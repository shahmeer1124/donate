import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/values/colors.dart';
import '../../common/widgets/button.dart';
import '../person/view.dart';
import '../received_request/view.dart';
import '../request_page/view.dart';
import '../testpages/first.dart';
import 'controller.dart';

class ApplicationPage extends GetView<ApplicationController> {
  const ApplicationPage({super.key});

  Widget _buildPageView() {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: controller.pagecontroller,
      onPageChanged: controller.handlepagechanged,
      children: [
        // RequestPage(),
        DetailScreen('assets/homeback.jpg', 'hello'),
        // ReceivedRequestPage(),
        // PersonView()
      ],
    );
  }

  Widget _buildbottomnavigationbar() {
    return Obx(() => BottomNavigationBar(
          items: controller.bottomtabs,
          currentIndex: controller.state.page,
          type: BottomNavigationBarType.fixed,
          onTap: controller.handlenavbarTap,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedItemColor: AppColors.thirdElement,
          selectedItemColor: AppColors.thirdElement,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageView(),
      // bottomNavigationBar: _buildbottomnavigationbar(),
    );
  }
}
