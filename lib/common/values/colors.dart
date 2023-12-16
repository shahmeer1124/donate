import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
class AppColors {
  /// 主背景 白色
  static const Color primaryBackground = Color.fromARGB(255, 255, 255, 255);

  /// 主文本 灰色
  static const Color primaryText = Color.fromARGB(255, 45, 45, 47);

  /// 主控件-背景
  static const Color primaryElement = Color.fromARGB(255, 99, 133, 230);

  /// 主控件-文本 白色
  static const Color primaryElementText = Color.fromARGB(255, 255, 255, 255);

  // *****************************************

  /// 第二种控件-背景色 淡灰色
  static const Color secondaryElement = Color.fromARGB(255, 246, 246, 246);

  /// 第二种控件-文本 浅蓝色
  static const Color secondaryElementText = Color.fromARGB(255, 99, 133, 231);

  // *****************************************

  /// 第三种控件-背景色 石墨色
  static const Color thirdElement = Color.fromARGB(255, 45, 45, 47);

  static const Color fourElementText = Color.fromARGB(255, 99, 99, 99);
  /// 第三种控件-文本 浅灰色2
  static const Color thirdElementText = Color.fromARGB(255, 183, 191, 202);


  // *****************************************

  /// tabBar 默认颜色 灰色
  static const Color tabBarElement = Color.fromARGB(255, 208, 208, 208);

  /// tabCellSeparator 单元格底部分隔条 颜色
  static const Color tabCellSeparator = Color.fromARGB(255, 230, 230, 231);
  //聊天背景颜色
  static const Color chatbg = Color.fromARGB(255, 248, 248, 248);


  static const Color morenbg = Color.fromARGB(255, 250, 250, 250);

  //背景颜色

}

mixin SubthemeData {
  TextTheme gettextThemes() {
    return GoogleFonts.quicksandTextTheme(const TextTheme(
        bodyText1: TextStyle(fontWeight: FontWeight.w400),
        bodyText2: TextStyle(fontWeight: FontWeight.w200)));
  }

 IconThemeData getIconTheme() {
    return const IconThemeData(color: surfaceTextColor, size: 16);
  }
}

class LightTheme with SubthemeData {
  buildLightTheme() {
    final ThemeData systemLightTheme = ThemeData.light();
    return systemLightTheme.copyWith(
        primaryColor: primaryColorLight,
        iconTheme: getIconTheme(),
        cardColor: cardColor,
        textTheme: gettextThemes().apply(
          bodyColor: mainTextColor,
          displayColor: mainTextColor,
        ));
  }
}


class ThemeController extends GetxController {
  late ThemeData _lightThemeData;
  late ThemeData _darkThemeData;
  @override
  void onInit() {
    // TODO: implement onInit
    InitializeThemeData();
    super.onInit();
  }

  InitializeThemeData() {
    _lightThemeData = LightTheme().buildLightTheme();
    // _darkThemeData = DarkTheme().buildDarkTheme();
  }

  ThemeData get darkTheme => _darkThemeData;
  ThemeData get lightTheme => _lightThemeData;

}



Color customScaffoldColor(BuildContext context) => UIparameters.isdarkMode()
    ? const Color(0xFF2e3c62)
    : const Color.fromARGB(255, 240, 237, 255);

double _mobileScreenpadding = 20.0;
double _cardBorderRadius = 10;

double get mobilescreenpadding => _mobileScreenpadding;
double get cardBorderRadius => _cardBorderRadius;
double get mobileScreenpadding => _mobileScreenpadding;

class AppIcons {
  AppIcons._();
  static const fontFam = 'AppIcons';
  static const IconData trophyOutline = IconData(0xe808, fontFamily: fontFam);
  static const IconData menuLeft = IconData(0xe805, fontFamily: fontFam);
  static const IconData peace = IconData(0xe806, fontFamily: fontFam);
  static const IconData menu = IconData(0xe804, fontFamily: fontFam);



}
const Color primaryLightColorLight = Color(0xff3ac3cb);
const Color primaryColorLight = Color(0xFFf85187);
const Color mainTextColor = Color.fromARGB(255, 40, 40, 40);
const Color cardColor = Color.fromARGB(255, 254, 254, 255);
const Color primaryDarkColor = Color(0xFF2e3c62);
const Color primaryColorDark = Color(0xFF99ace1);
const Color surfaceTextColor = Colors.white;
const Color correctAnswercolor = Color(0xFF3ac3cb);
const Color wrongAnswerColor = Color(0xFFf85187);
const Color notansweredColor = Color(0xFF2a3c65);
const maingradientlight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryLightColorLight, primaryColorLight]);

const maingradientdark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryDarkColor, primaryColorDark]);

LinearGradient mainGradient() =>
    UIparameters.isdarkMode() ? maingradientdark : maingradientlight;



Color answerSelectedColor() => UIparameters.isdarkMode()
    ? Theme.of(Get.context!).cardColor.withOpacity(0.5)
    : Theme.of(Get.context!).primaryColor;

Color answerBorderColor() => UIparameters.isdarkMode()
    ? const Color.fromARGB(255, 20, 46, 158)
    : const Color.fromARGB(255, 221, 221, 221);
TextStyle cardTitle(context) => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: UIparameters.isdarkMode()
        ? Theme.of(context).textTheme.bodyLarge!.color
        : Theme.of(context).primaryColor);
const QuestionText = TextStyle(fontSize: 16, fontWeight: FontWeight.w800);
const DetailText = TextStyle(fontSize: 12);
const HeaderText = TextStyle(
    fontSize: 22, fontWeight: FontWeight.w700, color: surfaceTextColor);
const appBarTs = TextStyle(
    fontWeight: FontWeight.bold, fontSize: 16, color: surfaceTextColor);
TextStyle countDownTs() => TextStyle(
  letterSpacing: 2,
  color: UIparameters.isdarkMode()?Theme.of(Get.context!).textTheme.bodyText1!.color:Theme.of(Get.context!).primaryColor
);
class UIparameters {
  static BorderRadius get cardBorderRadius => BorderRadius.circular(_cardBorderRadius);
  static EdgeInsets get mobilescreenpadding =>
      EdgeInsets.all(_mobileScreenpadding);
  static bool isdarkMode() {
    return Get.isDarkMode?true:false;
  }
}

class AppIconText extends StatelessWidget {
  final Icon icon;
  final Widget text;
  const AppIconText({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        icon,
        SizedBox(width: 4,),
        text
      ],
    );
  }
}

class AppCircleButton extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double width;
  final VoidCallback? ontap;
  const AppCircleButton(
      {super.key,
      required this.child,
      this.color,
      this.width = 60,
      this.ontap});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: ontap,
        child: child,
      ),
      // shape: CircleBorder(),
    );
  }
}


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? titleWidget;
  final Widget? leading;
  final bool showActionIcon;
  final VoidCallback? onMenuActionTap;
  const CustomAppBar(
      {super.key,
      this.title = '',
      this.showActionIcon = false,
      this.titleWidget,
      this.leading,
      this.onMenuActionTap});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: mobileScreenpadding, vertical: mobileScreenpadding),
        child: Stack(
          children: [
            Positioned.fill(
                child: titleWidget == null
                    ? Center(
                        child: Text(
                          title,
                          style: appBarTs,
                        ),
                      )
                    : Center(
                        child: titleWidget,
                      )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                leading ??
                    Transform.translate(
                      offset: const Offset(-14, 0),
                      child: BackButton(),
                    ),
                if (showActionIcon)
                  Transform.translate(
                    offset: const Offset(1, 0),
                    child: AppCircleButton(
                      ontap: onMenuActionTap ??
                          () =>{},
                      child: Icon(
                        AppIcons.menu,
                      ),
                    ),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(double.maxFinite, 80);
}


