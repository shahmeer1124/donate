import 'dart:async';

import 'package:donate/common/routes/names.dart';
import 'package:donate/pages/received_request/state.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../common/entities/Request_Content.dart';
import '../../common/entities/user.dart';
import '../../common/store/user.dart';

class ReceivedRequestController extends GetxController {
  final state = ReceivedRequestState();
  late StreamSubscription<QuerySnapshot> subscription;

  ReceivedRequestController();

  @override
  void onReady() {
    super.onReady();
    listenToRequests();
  }

  @override
  void onClose() {
    subscription.cancel();
    super.onClose();
  }

  final db = FirebaseFirestore.instance;
  final token = UserStore.to.token;

  void listenToRequests() {
    subscription = db.collection('requests').snapshots().listen((snapshot) {
      state.requestslist.clear();
      for (var doc in snapshot.docs) {
        if (doc.data()['uid'] == token)
          continue; // skip current user's requests
        doc.reference
            .collection('user_requests')
            .where('uid', isEqualTo: doc.data()['uid'])
            .withConverter(
                fromFirestore: Requestcontent.fromFirestore,
                toFirestore: (Requestcontent request, options) =>
                    request.toFirestore())
            .orderBy('addtime', descending: true)
            .limit(1)
            .snapshots()
            .listen((userSnapshot) {
          if (userSnapshot.docs.isNotEmpty) {
            var request = userSnapshot.docs.first.data();
            if (request.uid == token)
              return; // skip current user's own requests
            if (state.requestslist.any((r) => r.uid == request.uid)) {
              state.requestslist.removeWhere((r) => r.uid == request.uid);
            }
            state.requestslist.add(request);
          }
        });
      }
    });
  }






  



  void seedetails(Requestcontent content) {
    Get.toNamed(AppRoutes.ReceivedRequestDetail, parameters: {
      'name': content.name ?? '',
      'phone_number': content.phonenumber ?? '',
      'hospital_name': content.hospitalname ?? '',
      'note': content.note ?? '',
      'sensitivity': content.sensitivity ?? '',
      'location': content.location ?? '',
      'bloodgroup': content.bloodgroup ?? ''
    });
  }
}
