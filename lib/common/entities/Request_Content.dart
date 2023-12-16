import 'package:cloud_firestore/cloud_firestore.dart';

class Requestcontent {
  final String? uid;
  final String? name;
  final String? phonenumber;
  final String? bloodgroup;
  final String? hospitalname;
  final String? location;
  final String? note;
  final String? sensitivity;

  final Timestamp? addtime;

  Requestcontent({
    this.uid,
    this.name,
    this.phonenumber,
    this.hospitalname,
    this.location,
    this.note,
    this.sensitivity,
    this.addtime,
    this.bloodgroup
  });

  factory Requestcontent.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Requestcontent(
      uid: data?['uid'],
      name: data?['name'],
      location: data?['location'],
      bloodgroup: data?['bloodgroup'],
      phonenumber: data?['phonenumber'],
      hospitalname: data?['hospitalname'],
      note: data?['note'],
      sensitivity: data?['sensitivity'],
      addtime: data?['addtime'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (uid != null) "uid": uid,
      if (name != null) "name": name,
      if (bloodgroup != null) "bloodgroup": bloodgroup,
      if (phonenumber != null) "phonenumber": phonenumber,
      if (location != null) "location": location,
      if (hospitalname != null) "hospitalname": hospitalname,
      if (note != null) "note": note,
      if (sensitivity != null) "sensitivity": sensitivity,
      if (addtime != null) "addtime": addtime,
    };
  }
}
