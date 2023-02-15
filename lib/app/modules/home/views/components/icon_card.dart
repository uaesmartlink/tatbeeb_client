import 'package:flutter/material.dart';

class IconCard extends StatelessWidget {
  final String path;
  final String text;
  final VoidCallback onTap;

  const IconCard({required this.path, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(path),
              ),
            ),
          ),
          Card(
            child: Container(
              height: 40,
              width: 150,
              padding: const EdgeInsets.all(10),
              child: Text(
                textAlign: TextAlign.center,
                text,
                style: const TextStyle(
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*  child: Container(
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
      ),*/
