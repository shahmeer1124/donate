import 'dart:convert';

import 'package:donate/common/entities/entities.dart';
import 'package:donate/common/routes/names.dart';
import 'package:donate/common/store/store.dart';
import 'package:donate/pages/application/state.dart';
import 'package:donate/pages/request_page/state.dart';
import 'package:donate/pages/signin/state.dart';
import 'package:donate/pages/welcome/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RequestController extends GetxController {
  final user_id = UserStore.to.token;
  String? _userId;
  String? _displayName;
  String? _email;
  String? _photoUrl;
  final namecontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final hospitalnamecontroller = TextEditingController();
  final extranotecontroller = TextEditingController();
  final sensitivitycontroller = TextEditingController();
  RxString bloodGroup = RxString('');
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final state = RequestState();
  RequestController();
  var data;
  @override
  void onInit() {
    super.onInit();
    data = Get.arguments;
    print(data['position']);
    _loadUserProfile();
  }

  void _loadUserProfile() async {
    String profileJson = await UserStore.to.getProfile();
    Map<String, dynamic> profileMap = jsonDecode(profileJson);
    _userId = profileMap["accessToken"];
    _displayName = profileMap["display_name"];
    _email = profileMap["email"];
    _photoUrl = profileMap["photoUrl"];
  }

  void submitRequest() async {
    state.creatingrequest.value = true;
    String name = namecontroller.text;
    String phonenumber = phonecontroller.text;
    String hospitalname = hospitalnamecontroller.text;
    String note = extranotecontroller.text;
    String sensitivity = sensitivitycontroller.text;
    String bloodgroup = bloodGroup.toString();
    final request = Requestcontent(
        uid: user_id,
        name: name,
        location:state.isOn==true? data['position'].toString():'',
        phonenumber: phonenumber,
        hospitalname: hospitalname,
        note: note,
        sensitivity: sensitivity,
        bloodgroup: bloodgroup,
        addtime: Timestamp.now());

    // Create a document for the current user in the "requests" collection
    final userDocRef =
        FirebaseFirestore.instance.collection('requests').doc(user_id);
    await userDocRef
        .set({'name': _displayName, 'email': _email, 'photourl': _photoUrl});

    // Add the current request document to the user's subcollection
    await userDocRef
        .collection('user_requests')
        .withConverter(
            fromFirestore: Requestcontent.fromFirestore,
            toFirestore: (content, _) => content.toFirestore())
        .add(request)
        .then((value) {
      print("request is added to the database");
      sendPushNotification(
          hospitalnamecontroller.text, extranotecontroller.text);
      namecontroller.clear();
      phonecontroller.clear();
      hospitalnamecontroller.clear();
      extranotecontroller.clear();
      sensitivitycontroller.clear();
      // bloodgroupcontroller.clear();

      Get.focusScope?.unfocus();
      state.creatingrequest.value = false;
    });
  }
   void toggleSwitch() {
    state.isOn.value = !state.isOn.value;
  }

  Future<List<String>> getFCMTokensFromFirestore() async {
    final usersCollectionRef = FirebaseFirestore.instance.collection('users');
    final usersSnapshot = await usersCollectionRef.get();
    List<String> fcmTokens = [];
    for (final userDoc in usersSnapshot.docs) {
      final userData = userDoc.data();
      final fcmToken = userData['fcmtoken'] as String?;
      if (fcmToken != null) {
        fcmTokens.add(fcmToken);
      }
    }
    return fcmTokens;
  }

  Future<void> sendPushNotification(String title, String message) async {
    // Send a message with the FCM token of each registered device
    List<String> fcmTokens = await getFCMTokensFromFirestore();
    List<Future<void>> futures = [];

    for (String token in fcmTokens) {
      Map<String, dynamic> notification = {
        'notification': {'title': title, 'body': message},
        'data': {
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
          "id": "1",
          "status": "done"
        },
        'to': token,
      };

      String url = 'https://fcm.googleapis.com/fcm/send';
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAAQWtvi_k:APA91bHDutv0GLh90y235N8v6ERjuFgC4KQdm_twcaZBFWHWXWy7LpApn-roCwOVe0Li00sD8tKoZNk94tRHoHyTEJw9B-5_VGb7PIC47vGqEFqRZj9jPdwvGaPROhgqdpWhbV9Wom2q',
      };

      http.Response response = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(notification));
      if (response.statusCode == 200) {
        print('Push notification sent successfully to $token');
      } else {
        print(
            'Failed to send push notification to $token. Error: ${response.body}');
      }
    }

    print("Push notifications sent successfully.");
  }

  truestate() {
    state.creatingrequest.value = true;
  }

  falsestate() {
    state.creatingrequest.value = false;
  }
}
