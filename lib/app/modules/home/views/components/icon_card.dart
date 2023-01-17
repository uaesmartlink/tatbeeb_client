import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/localization.dart';

class IconCard extends StatelessWidget {
  final IconData? iconData;
  final Color? color1;
  final Color? color2;
  final String? text;
  final String? text1;
  final VoidCallback? onTap;

  const IconCard(
      {Key? key,
      this.iconData,
      this.color1,
      this.color2,
      this.text,
      this.text1,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 130,
        width: 150,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                height: 70,
                width: 150,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 40,
                      ),
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height / 35,
                    ),
                    Text(
                      text!,
                      style: TextStyle(
                          color: Color(0xFF677294),
                          fontSize:
                              (Get.locale == LocalizationService.locales[0])
                                  ? width / 27
                                  : width / 27,
                          fontWeight: FontWeight.bold),
                    ),
                    if (text1 != null)
                      Text(
                        text1!,
                        style: TextStyle(
                          color: Color(0xFF677294),
                          fontSize:
                              (Get.locale == LocalizationService.locales[0])
                                  ? width / 27
                                  : width / 27,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 40,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [color1!, color2!])),
                child: Icon(
                  iconData,
                  size: 45,
                  shadows: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 40,
                    ),
                  ],
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
