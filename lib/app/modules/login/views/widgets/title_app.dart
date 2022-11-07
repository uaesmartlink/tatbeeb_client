import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:hallo_doctor_client/app/utils/styles/styles.dart';

class TitleApp extends StatelessWidget {
  const TitleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Welcome, '.tr,
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        const SizedBox(height: 5,),
        Text(
          'You can search a doctor and book an appointment'.tr,
          style: TextStyle(
              fontSize: 12,
              color: Colors.white),
        ),

      ],
    );
  }
}
