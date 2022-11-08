import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/localization.dart';

class BackgroundHome extends StatelessWidget {
  final Widget widget1;
  final Widget widget2;
  final String text;

  const BackgroundHome(
      {Key? key,
      required this.widget1,
      required this.widget2,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height / 5.5,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                    Color(0xFF76e6da),
                    Color(0xFF1b4170),
                  ])),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hi '.tr + text,
                          style: TextStyle(
                            color: Color(0xFFfafafa),
                            fontSize:
                                (Get.locale == LocalizationService.locales[0])
                                    ? 22
                                    : 20,
                          )),
                      Text('Find your doctor'.tr,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  (Get.locale == LocalizationService.locales[0])
                                      ? 25
                                      : 23,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  widget1
                ],
              ),
            ),
          ),
          Positioned(
              left: 0,
              top: MediaQuery.of(context).size.height / 5.3,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                ),
                child: widget2,
              )),
        ],
      ),
    );
  }
}
