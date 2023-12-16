import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common/entities/Request_Content.dart';
import '../../../common/entities/user.dart';
import '../../../common/values/colors.dart';
import '../controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ReceivedRequestList extends GetView<ReceivedRequestController> {
  const ReceivedRequestList({Key? key}) : super(key: key);

  Widget _buildWidget(BuildContext context, Requestcontent item) {
    const double _padding = 10.0;
    // var item = controller.state.requestslist[index];
    return Container(
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.only(top: 15.w, left: 15.w, right: 15.w),
      decoration: BoxDecoration(
          borderRadius: UIparameters.cardBorderRadius,
          color: Theme.of(context).cardColor),
      child: InkWell(
        onTap: () {
          if(item.uid!=null)
          controller.seedetails(item);
        },
        child: Padding(
          padding: const EdgeInsets.all(_padding),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ColoredBox(
                      color: Theme.of(context).cardColor.withOpacity(0.1),
                      child: SizedBox(
                        height: Get.width * 0.15,
                        width: Get.width * 0.15,
                        child: CachedNetworkImage(
                          imageUrl: '',
                          placeholder: (context, url) => Container(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: ((context, url, error) =>
                              Image.asset("assets/blood-bag.png")),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name.toString(),
                          style: cardTitle(context),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 15),
                          child: Text(item.note.toString()),
                        ),
                        Row(
                          children: [
                            AppIconText(
                              icon: Icon(
                                Icons.phone,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Theme.of(context).primaryColor,
                              ),
                              text: Text(
                                "${item.phonenumber} ",
                                style: DetailText.copyWith(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            AppIconText(
                              icon: Icon(
                                Icons.timer,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Theme.of(context).primaryColor,
                              ),
                              text: Text(
                                item.sensitivity.toString(),
                                style: DetailText.copyWith(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Theme.of(context).primaryColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                  bottom: -_padding,
                  right: -_padding,
                  child: GestureDetector(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(cardBorderRadius),
                              bottomRight: Radius.circular(cardBorderRadius))),
                      child: Icon(
                        Icons.health_and_safety,
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.w),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  var item = controller.state.requestslist[index];

                  return _buildWidget(context, item);
                },
                childCount: controller.state.requestslist.length,
              ),
            ),
          )
        ],
      ),
    );
  }
}
