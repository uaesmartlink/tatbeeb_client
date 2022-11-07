import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/modules/onboarding_page/controllers/onboarding_controller.dart';
import 'package:hallo_doctor_client/app/modules/onboarding_page/views/widget/page_view_content.dart';

class OnBoardingView extends GetView<OnBoardingController>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        children: [
          PageViewContent(
              image: 'assets/images/onboarding1.png',
              title: 'Find Trusted'.tr,
              text: 'video/phone consult top doctors from your home/office/car : 24/7'.tr,
              onTap: (){
               controller.pageController.nextPage(duration:Duration(milliseconds: 300) , curve: Curves.ease);
              }
          ),
          PageViewContent(
              image: 'assets/images/onboarding2.png',
              title: 'Choose Best'.tr,
              text: 'Book the best doctors from multi specialist'.tr,
              onTap: (){
                controller.pageController.nextPage(duration:Duration(milliseconds: 300) , curve: Curves.ease);
              }
          ),
          PageViewContent(
              image: 'assets/images/onboarding3.png',
              title: 'Easy'.tr,
              text: 'Save time and money'.tr,
              onTap: (){

              }
          ),
        ],
      )
    );

  }
}