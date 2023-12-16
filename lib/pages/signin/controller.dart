import 'package:donate/common/entities/entities.dart';
import 'package:donate/common/routes/names.dart';
import 'package:donate/common/store/store.dart';
import 'package:donate/pages/signin/state.dart';
import 'package:donate/pages/welcome/state.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../common/widgets/toast.dart';
import '../request_page/controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>['openid']);

class SignInController extends GetxController {
  final state = SignInState();
  SignInController();
  final db = FirebaseFirestore.instance;
final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> handlesignIn() async {
    try {
      var user = await _googleSignIn.signIn();
      String? fcmToken = await _firebaseMessaging.getToken();
      if (user != null) {
        final _gauthentication = await user.authentication;
        final credential = GoogleAuthProvider.credential(
            idToken: _gauthentication.idToken,
            accessToken: _gauthentication.accessToken);
        await FirebaseAuth.instance.signInWithCredential(credential);
        String displayname = user.displayName ?? user.email;
        String email = user.email;
        String photoUrl = user.photoUrl ?? '';
        String id = user.id;
        UserLoginResponseEntity userProfile = UserLoginResponseEntity();
        userProfile.email = email;
        userProfile.displayName = displayname;
        userProfile.photoUrl = photoUrl;
        userProfile.accessToken = id;
        UserStore.to.saveProfile(userProfile);
        var userbase = await db
            .collection("users")
            .withConverter(
                fromFirestore: UserData.fromFirestore,
                toFirestore: (UserData userdata, options) =>
                    userdata.toFirestore())
            .where('id', isEqualTo: id)
            .get();
        if (userbase.docs.isEmpty) {
          final data = SignInData(
              id: id,
              name: displayname,
              email: email,
              photourl: photoUrl,
              location: '',
              fcmtoken: fcmToken,
              addtime: Timestamp.now());
          await db
              .collection("users")
              .withConverter(
                  fromFirestore: SignInData.fromFirestore,
                  toFirestore: (SignInData userdata, options) =>
                      userdata.toFirestore())
              .add(data);
        }
        toastInfo(msg: "login success");
        Get.offAndToNamed(AppRoutes.Application);
      }
    } catch (e) {
      toastInfo(msg: 'login error $e');
    }
  }



  @override
  void onReady() {
    super.onReady();
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        print('user is not logged in');
      } else {
        print('user is logged in');
      }
    });
  }
}
