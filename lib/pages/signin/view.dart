import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/values/colors.dart';
import '../../common/widgets/button.dart';
import 'controller.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({super.key});
  Widget _buildThirdPartyLogin() {
    return Container(
      width: 295.w,
      margin: EdgeInsets.only(bottom: 280.h),
      child: Column(
        children: [
          Text(
            "Sign in with social networks",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColors.thirdElement,
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                height: 1),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.h, left: 50.w, right: 50.w),
            child: btnFlatButtonWidget(
                onPressed: () => controller.handlesignIn(),
                width: 200.w,
                height: 55.h,
                title: 'Google Login'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [_buildThirdPartyLogin()],
    ));
  }
}
