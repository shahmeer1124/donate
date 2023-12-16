import 'package:donate/common/routes/names.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../application/controller.dart';

class DetailScreen extends GetView<ApplicationController> {
  String image, title;
  DetailScreen(this.image, this.title);

  AppBar _buildAppbar() {
    return AppBar(
      backgroundColor: Colors.pink.shade400,
      toolbarHeight: 70,
      elevation: 2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10))),
      title: Text(
        'Donation Requests',
      ),
      actions: [
        Row(
          children: [
            SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.Me);
              },
              child: Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(blurRadius: 2, spreadRadius: 2, color: Colors.pink)
                ], shape: BoxShape.circle, color: Colors.pink.shade400),
                child: Icon(
                  Icons.person,
                  size: 20,
                ),
              ),
            ),
            SizedBox(
              width: 26,
            )
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: _buildAppbar(),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height - 575.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('$image'), fit: BoxFit.cover)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, top: 45.0),
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 25.0, top: 45.0),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 25.0, top: 95.0),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 140.0),
                        child: Stack(children: <Widget>[
                          Container(
                            height: 120.0,
                            decoration: BoxDecoration(
                                color: Colors.pink.shade400,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40.0),
                                    topRight: Radius.circular(40.0))),
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12.0, 15.0, 12.0, 5.0),
                                    child: Text('Donate.',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Cardo',
                                            fontSize: 34.0,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 90.0),
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 700.0,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(38.0),
                                          topRight: Radius.circular(38.0))),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Text('IMPORTANCE',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8.0, 4.0, 8.0, 2.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'The Quran teaches that saving one life is equivalent to saving all of humanity, and blood donation is seen as a practical way to fulfill this duty. Islamic organizations often organize blood drives and campaigns to raise awareness of the importance of blood donation.',
                                              style: TextStyle(fontSize: 12.0),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20.0),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: GridView.count(
                                          crossAxisCount: 3,
                                          mainAxisSpacing: 8.0,
                                          crossAxisSpacing: 8.0,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () async {
                                                // Show circular progress indicator
                                                Get.dialog(
                                                  AlertDialog(
                                                    content: SizedBox(
                                                      height: 100,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          CircularProgressIndicator(),
                                                          SizedBox(height: 20),
                                                          Text(
                                                            'Fetching location...',
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                );
                                                final status = await Permission
                                                    .locationWhenInUse.status;
                                                if (status.isDenied) {
                                                  // Request permission from the user
                                                  await Permission
                                                      .locationWhenInUse
                                                      .request();
                                                }

                                                // Get the current position of the user
                                                Position position =
                                                    await Geolocator
                                                        .getCurrentPosition(
                                                            desiredAccuracy:
                                                                LocationAccuracy
                                                                    .high);

                                                // Navigate to the CreateRequest screen and pass the position as a parameter
                                                Get.toNamed(
                                                        AppRoutes.CreateRequest,
                                                        arguments: {
                                                      'position': position
                                                    })!
                                                    .then((_) {
                                                  // Hide circular progress indicator
                                                  Get.back();
                                                });
                                              },
                                              child: cardWidget(Icons.bloodtype,
                                                  'Need Blood?', ''),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.toNamed(
                                                    AppRoutes.ReceivedRequests);
                                              },
                                              child: cardWidget(
                                                  Icons.health_and_safety,
                                                  'Want to Donate?',
                                                  ''),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget cardWidget(IconData icon, String title, String number) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 8.0,
        child: Container(
          width: 20.0,
          height: 100.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                          color: Colors.red[100],
                          borderRadius: BorderRadius.circular(40.0)),
                    ),
                    Positioned(
                      left: 8.0,
                      top: 7.0,
                      child: Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40.0),
                        elevation: 1.0,
                        child: Container(
                          width: 45.0,
                          height: 45.0,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40.0)),
                          child: Center(
                            child: Icon(
                              icon,
                              color: Colors.pink.shade400,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Text(
                title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  number,
                  style: TextStyle(color: Colors.red, fontSize: 12.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
