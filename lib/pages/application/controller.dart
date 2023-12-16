import 'package:donate/common/entities/entities.dart';
import 'package:donate/common/routes/names.dart';
import 'package:donate/common/store/store.dart';
import 'package:donate/pages/application/state.dart';
import 'package:donate/pages/signin/state.dart';
import 'package:donate/pages/welcome/state.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../common/values/colors.dart';
import '../../common/widgets/toast.dart';

import 'package:flutter/widgets.dart';

class ApplicationController extends GetxController with WidgetsBindingObserver {
  final state = ApplicationState();
  final db = FirebaseFirestore.instance;

  ApplicationController();
  late final List<String> tabtitles;
  late final PageController pagecontroller;
  late final List<BottomNavigationBarItem> bottomtabs;
  handlepagechanged(int index) {
    state.page = index;
  }

  changestate() {
    state.firststate.value = true;
  }

  @override
  void onInit() {
    super.onInit();
    requestNotificationPermission();

    tabtitles = ['Chat', 'Contact', 'Profile'];
    bottomtabs = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.request_page,
            color: AppColors.thirdElementText,
          ),
          label: 'Home',
          activeIcon: Icon(
            Icons.home_max,
            color: AppColors.secondaryElementText,
          ),
          backgroundColor: AppColors.primaryBackground),
      // const BottomNavigationBarItem(
      //     icon: Icon(
      //       Icons.incomplete_circle_outlined,
      //       color: AppColors.thirdElementText,
      //     ),
      //     activeIcon: Icon(
      //       Icons.person,
      //       color: AppColors.secondaryElementText,
      //     ),
      //     label: 'Contact',
      //     backgroundColor: AppColors.primaryBackground),
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: AppColors.thirdElementText,
          ),
          label: 'Person',
          backgroundColor: AppColors.primaryBackground)
    ];
    pagecontroller = PageController(initialPage: state.page);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // Get the new FCM token
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      // Update the FCM token in the Firestore database
      await updateFcmToken(fcmToken);
    }
  }

  // Update the FCM token in the Firestore database
  Future<void> updateFcmToken(String? fcmToken) async {
    String id = FirebaseAuth.instance.currentUser?.uid ?? '';
    if (id.isNotEmpty) {
      await db.collection("users").doc(id).update({"fcmtoken": fcmToken});
    }
  }

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("permission granted");
    } else {
      print("permission denied");
    }
  }

  @override
  void dispose() {
    // Unregister this controller as an observer of the app lifecycle
    WidgetsBinding.instance.removeObserver(this);
    pagecontroller.dispose();
    super.dispose();
  }

  void handlenavbarTap(int index) {
    pagecontroller.jumpToPage(index);
  }
}
