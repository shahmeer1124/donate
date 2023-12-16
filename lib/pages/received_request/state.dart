import 'package:get/get.dart';

import '../../common/entities/Request_Content.dart';
import '../../common/entities/user.dart';

class ReceivedRequestState {
  RxList<Requestcontent> requestslist = <Requestcontent>[].obs;

void update(Function(ReceivedRequestState state) updateFunction) {
    updateFunction(this);
  }


}
