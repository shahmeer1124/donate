import 'package:donate/pages/welcome/controller.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomePage extends GetView<WelcomeController> {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => SizedBox(
        width: 360.w,
        height: 780.w,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView(
              scrollDirection: Axis.horizontal,
              reverse: false,
              onPageChanged: (index) {
                controller.state.index.value = index;
              },
              controller: PageController(
                initialPage: 0,
                keepPage: false,
                viewportFraction: 1,
              ),
              pageSnapping: true,
              physics: ClampingScrollPhysics(),
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/backimg1.jpg'))),
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/back2.jpg'))),
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/back3.jpg'))),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Positioned(
                          bottom: 90,
                          child: ElevatedButton(
                              child: Text("Login"),
                              onPressed: () {
                                controller.handleSignIn();
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.white,
                                  ),
                                  foregroundColor: MaterialStateProperty.all(
                                    Colors.black,
                                  ),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  side: MaterialStateProperty.all(
                                      BorderSide(color: Colors.white)))))
                    ],
                  ),
                )
              ],
            ),
            Positioned(
                bottom: 70,
                child: DotsIndicator(
                  position: controller.state.index.value.toDouble(),
                  dotsCount: 3,
                  reversed: false,
                  mainAxisAlignment: MainAxisAlignment.center,
                  decorator: DotsDecorator(
                      size: Size.square(9),
                      activeSize: Size(18, 9),
                      activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                ))
          ],
        ),
      ),
    ));
  }
}
