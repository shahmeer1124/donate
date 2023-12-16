import 'package:donate/common/widgets/toast.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/values/colors.dart';
import '../../common/widgets/button.dart';
import 'controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestPage extends GetView<RequestController> {
  const RequestPage({super.key});

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
      appBar: _buildAppbar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                TextFormField(
                  controller: controller.namecontroller,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.pinkAccent,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.pinkAccent,
                        width: 1.0,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 1.0,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 2.0,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty ||
                        RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                      return "Enter the correct info";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 30),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: controller.phonecontroller,
                  decoration: InputDecoration(
                    labelText: 'Contact No:',
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.pinkAccent,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.pinkAccent,
                        width: 1.0,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 1.0,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 2.0,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty || RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return "Enter the correct info";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 30),
                DropdownButtonFormField<String>(
                  items: ['A+', 'B+', 'O+', 'AB+', 'A-', 'B-', 'O-', 'AB-']
                      .map((bg) => DropdownMenuItem(
                            value: bg,
                            child: Text(bg),
                          ))
                      .toList(),
                  decoration: InputDecoration(
                    hintText: 'Select blood group',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a blood group';
                    }
                    return null;
                  },
                  onChanged: (value) =>
                      controller.bloodGroup.value = value ?? 'false request',
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: controller.hospitalnamecontroller,
                  decoration: InputDecoration(
                    labelText: 'Hospital Name',
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.pinkAccent,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.pinkAccent,
                        width: 1.0,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 1.0,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 2.0,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty ||
                        RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                      return "Enter the correct info";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 10),
                Text('In how many hours blood is needed?',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: controller.sensitivitycontroller,
                  decoration: InputDecoration(
                    labelText: 'Hours',
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.pinkAccent,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.pinkAccent,
                        width: 1.0,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 1.0,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 2.0,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty ||
                        RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                      return "Enter the correct info";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 30),
                TextFormField(
                  maxLines: 4,
                  keyboardType: TextInputType.text,
                  controller: controller.extranotecontroller,
                  decoration: InputDecoration(
                    labelText: 'Extra Note',
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.pinkAccent,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.pinkAccent,
                        width: 1.0,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 1.0,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 2.0,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty ||
                        RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                      return "Enter the correct info";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Obx(
                      () => Switch(
                        value: controller.state.isOn.value,
                        onChanged: (value) => controller.toggleSwitch(),
                      ),
                    ),
                    Text(
                      'Need blood at current location?',
                      style:
                          TextStyle(fontSize: 20, color: Colors.pink.shade400),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: SizedBox(
                    width: Get.width * 0.8,
                    height: 60,
                    child: ElevatedButton(
                        onPressed: () {
                          if (controller.phonecontroller.text.isEmpty ||
                              controller.bloodGroup.value.isEmpty ||
                              controller.hospitalnamecontroller.text.isEmpty ||
                              controller.sensitivitycontroller.text.isEmpty) {
                            toastInfo(msg: "Please enter all the information ");
                          } else {
                            controller.submitRequest();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.pink, // Set the button color to pink
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(30), // Set rounded edges
                          ),
                        ),
                        child: Obx(
                          () => controller.state.creatingrequest == true
                              ? Center(
                                  child: CircularProgressIndicator(
                                  color: Colors.white,
                                ))
                              : Text(
                                  'Create Request!',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
