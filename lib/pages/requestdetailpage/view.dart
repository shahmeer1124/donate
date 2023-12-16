import 'package:donate/common/widgets/toast.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/values/colors.dart';
import '../../common/widgets/button.dart';
import 'controller.dart';

class ReceivedRequestDetail extends GetView<ReceivedRequestDetailController> {
  const ReceivedRequestDetail({super.key});
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
                onPressed: () => {},
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
        body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Column(
          children: [
            SafeArea(
              child: Container(
                height: Get.height * 0.1,
                width: Get.width,
                color: Colors.white,
                child: Center(
                  child: Text(
                    "Request Details",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Divider(
                height: 1,
                color: Colors.pink,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name:    ",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(() => Text(
                        controller.state.name.value,

                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1, // Set the maximum number of lines to 1
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Hospital Name:     ",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(() => Text(
                        controller.state.hospitalname.value,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Phone No:    ",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(() => Text(
                        controller.state.phonenumber.value,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Extra Note:    ",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(() => Text(
                        controller.state.note.value,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Blood Required in Hours:    ",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(() => Text(
                        controller.state.sensitivity.value,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Blood Group:    ",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(() => Text(
                        controller.state.bloodgp.value,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        // Call the method with the latitude and longitude values
                        final locationValue = controller.state.location.value;
                        final latitude =
                            controller.extractLatitude(locationValue);
                        final longitude =
                            controller.extractLongitude(locationValue);
                        if (latitude=='' || longitude == '') {
                          toastInfo(
                              msg:
                                  "Requester didn't shared his location you have to call him");
                        } else {
                          controller.openGoogleMaps(latitude!, longitude!);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(15),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Click here to see the Requestor location',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
