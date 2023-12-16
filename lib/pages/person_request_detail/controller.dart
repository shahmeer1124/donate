import 'package:donate/common/routes/names.dart';
import 'package:donate/pages/requestdetailpage/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../common/store/user.dart';

class OwnRequestDetailController extends GetxController {
  final state = ReceivedRequestDetailState();

  OwnRequestDetailController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var data = Get.parameters;
    state.name.value = data['name'] ?? '';
    state.phonenumber.value = data['phone_number'] ?? '';
    state.hospitalname.value = data['hospital_name'] ?? '';
    state.sensitivity.value = data['sensitivity'] ?? '';
    state.location.value = data['location'] ?? '';
    state.note.value = data['note'] ?? '';
    state.bloodgp.value = data['bloodgroup'] ?? '';
  }

 
}
