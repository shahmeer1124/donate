import 'package:flutter/material.dart';

import 'package:get/get.dart';




import '../../pages/person/index.dart';
import '../../pages/person_request_detail/index.dart';
import '../../pages/received_request/index.dart';
import '../../pages/request_page/index.dart';
import '../../pages/requestdetailpage/index.dart';
import '../../pages/welcome/index.dart';
import '../../pages/signin/index.dart';
import '../../pages/application/index.dart';




import '../middlewares/router_welcome.dart';
import 'routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.INITIAL;
  static const APPlication = AppRoutes.Application;
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.INITIAL,
      page: () => WelcomePage(),
      binding: WelcomeBinding(),
      middlewares: [
        RouteWelcomeMiddleware(priority: 1),
      ],
    ),
    GetPage(
      name: AppRoutes.SIGN_IN,
      page: () => SignInPage(),
      binding: SignInBinding(),
    ),

    // check if needed to login or not
    GetPage(
      name: AppRoutes.Application,
      page: () => ApplicationPage(),
      binding: ApplicationBinding(),
      // middlewares: [
        // RouteAuthMiddleware(priority: 1),
      // ],
    ),
    

    // 最新路由
    // 首页
    GetPage(name: AppRoutes.CreateRequest, page: () => RequestPage(), binding: RequestBinding()),
    //消息
    GetPage(name: AppRoutes.ReceivedRequests, page: () => ReceivedRequestPage(), binding: ReceivedRequestBinding()),
    //我的
    GetPage(name: AppRoutes.Me, page: () => PersonView(), binding: PersonBindings()),
    //聊天详情
    GetPage(name: AppRoutes.Chat, page: () => OwnRequestPage(), binding: OwnRequestBinding()),

    //  GetPage(name: AppRoutes.Photoimgview, page: () => PhotoImgViewPage(), binding: PhotoImgViewBinding()),
// received request detail page 
    GetPage(name: AppRoutes.ReceivedRequestDetail, page: () => ReceivedRequestDetail(), binding: ReceivedRequestDetailBinding()),

  ];
}
