import 'package:donate/pages/received_request/controller.dart';
import 'package:donate/pages/received_request/widget/requests_list.dart';
import 'package:donate/pages/welcome/controller.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/values/colors.dart';
import '../../common/widgets/app.dart';

class ReceivedRequestPage extends GetView<ReceivedRequestController> {
  const ReceivedRequestPage({super.key});

  AppBar _buildAppbar() {
    return AppBar(
      backgroundColor: Colors.pink.shade400,
      toolbarHeight: 80,
      elevation: 2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(15),
              bottomLeft: Radius.circular(15))),
      title: Text(
        'Donation Requests',
      ),
      actions: [
        Row(
          children: [
            SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(blurRadius: 2, spreadRadius: 2, color: Colors.pink)
              ], shape: BoxShape.circle, color: Colors.pink.shade400),
              child: Icon(
                Icons.logout,
                size: 20,
              ),
            ),
            SizedBox(
              width: 26,
            )
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: _buildAppbar(),
      body: ReceivedRequestList(),
    );
  }
}
