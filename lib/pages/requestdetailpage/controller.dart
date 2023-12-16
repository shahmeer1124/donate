import 'package:donate/pages/requestdetailpage/state.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
class ReceivedRequestDetailController extends GetxController {
  final state = ReceivedRequestDetailState();
  ReceivedRequestDetailController();

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


  void openGoogleMaps(String latitude, String longitude) async {
  final url = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

String? extractLatitude(String locationValue) {
  final regex = RegExp(r'Latitude: ([\d.]+)');
  final match = regex.firstMatch(locationValue);
  if (match != null && match.groupCount >= 1) {
    return match.group(1);
  }
  return '';
}

String? extractLongitude(String locationValue) {
  final regex = RegExp(r'Longitude: ([\d.]+)');
  final match = regex.firstMatch(locationValue);
  if (match != null && match.groupCount >= 1) {
    return match.group(1);
  }
  return '';
}
}
