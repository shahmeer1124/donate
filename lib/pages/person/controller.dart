import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donate/common/widgets/toast.dart';
import 'package:donate/pages/person/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/entities/Request_Content.dart';
import '../../common/routes/names.dart';
import '../../common/store/user.dart';

class PersonController extends GetxController {
  PersonController();
  late StreamSubscription<QuerySnapshot> subscription;
  final state = PersonState();
  final db = FirebaseFirestore.instance;
  final token = UserStore.to.token;

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

  void listenToRequests() {
    subscription = db.collection('requests').snapshots().listen((snapshot) {
      state.createdrequestlist.clear();
      for (var doc in snapshot.docs) {
        doc.reference
            .collection('user_requests')
            .where('uid', isEqualTo: token)
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
            if (request.uid == token) {
              state.createdrequestlist.add(request);
            }
          }
        });
      }
    });
  }

  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Confirmation'),
          content:
              Text('Are you sure you want to mark this request as completed?'),
          actions: [
            TextButton(
              onPressed: () {
                deleteCurrentUserRequests();
                Navigator.pop(dialogContext);
                
                // Close the dialog
                // Perform your action here for 'Yes'
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext); // Close the dialog
                // Perform your action here for 'No'
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  void deleteCurrentUserRequests() {
    db.collection('requests').get().then((snapshot) {
      for (var doc in snapshot.docs) {
        doc.reference
            .collection('user_requests')
            .where('uid', isEqualTo: token)
            .get()
            .then((userSnapshot) {
          for (var userDoc in userSnapshot.docs) {
            userDoc.reference.delete();
          }
        });
      }
    });
    state.createdrequestlist.clear();
  }

    void seedetails(Requestcontent content) {
    Get.toNamed(AppRoutes.Chat, parameters: {
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
