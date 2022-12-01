import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/modules/profile/controllers/profile_controller.dart';

import '../../../../utils/localization.dart';
import '../../../dashboard/views/dashboard_view.dart';


class ChangeLanguagePage extends GetView<ProfileController> {

  ChangeLanguagePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var locale = Get.locale;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Chose a language for your app'.tr,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17
                ),
              ),
              const SizedBox(height:51),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                            onPressed: (){
                              Get.updateLocale(LocalizationService.locales[0]);
                              locale = Get.locale;
                              Get.toNamed('/home');
                              DashboardView().controller.selectedIndex = 0;
                            },
                            child: Text(
                              'English'.tr,
                              style: TextStyle(
                                  color: locale.toString() == 'en_US' ? Colors.black : Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 25
                              ),
                            )
                        ),
                        const SizedBox(height: 10,),
                        TextButton(
                            onPressed: (){
                              Get.updateLocale(LocalizationService.locales[1]);
                              locale = Get.locale;
                              Get.toNamed('/home');
                              DashboardView().controller.selectedIndex = 0;
                            },
                            child: Text(
                              'Arabic'.tr,
                              style: TextStyle(
                                  color: locale.toString() == 'ar' ? Colors.black : Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 25
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

        ),
      bottomNavigationBar: DashboardView(),
    );
  }
}
