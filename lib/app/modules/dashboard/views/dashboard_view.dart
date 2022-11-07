import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/modules/appointment/views/appointment_view.dart';
import 'package:hallo_doctor_client/app/modules/balance/views/balance_view.dart';
//import 'package:hallo_doctor_client/app/modules/doctor_category/views/doctor_category_view.dart';
import 'package:hallo_doctor_client/app/modules/home/views/home_view.dart';
//import 'package:hallo_doctor_client/app/modules/list_chat/views/list_chat_view.dart';
import 'package:hallo_doctor_client/app/modules/profile/views/profile_view.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  final List<Widget> bodyContent = [
    HomeView(),
    AppointmentView(),
    BalanceView(),
    ProfileView()
  ];
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Color(0xFF1a3e6c),
              unselectedItemColor: Colors.grey[500],
              iconSize: 30,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                    ),
                  label: '',
                    ),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.event_note,
                    ),
                  label: ''
                    ),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.payment_rounded,
                    ),
                  label: ''
                    ),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person,
                    ),
                  label: ''
                    ),
              ],
              currentIndex: controller.selectedIndex,
              onTap: (index) {
                switch(index){
                  case 0:{
                     Get.toNamed('/home');
                     controller.selectedIndex=0;
                     break;
                  }
                  case 1:{
                    Get.toNamed('/appointment');
                    controller.selectedIndex=1;
                    break;
                  }
                  case 2:{
                    Get.toNamed('/balance_page');
                    controller.selectedIndex=2;
                    break;
                  }
                  case 3:{
                    Get.toNamed('/profile');
                    controller.selectedIndex=3;
                    break;
                  }
                }
              },
            );
      /*body: Obx(
        () => Center(
          child: IndexedStack(
              index: controller.selectedIndex, children: bodyContent),
        ),
      ),*/
  }
}
