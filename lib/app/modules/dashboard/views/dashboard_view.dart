import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/modules/appointment/views/appointment_view.dart';
import 'package:hallo_doctor_client/app/modules/balance/views/balance_view.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:hallo_doctor_client/app/modules/doctor_category/views/doctor_category_view.dart';
import 'package:hallo_doctor_client/app/modules/home/views/home_view.dart';

import 'package:hallo_doctor_client/app/modules/list_chat/views/list_chat_view.dart';
import 'package:hallo_doctor_client/app/modules/profile/views/profile_view.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  final List<Widget> bodyContent = [
    HomeView(),
    AppointmentView(),
    BalanceView(),
    // ListChatView(),
    ProfileView(),
  ];
  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: MyNavegateBar(this.controller),
        onWillPop: () async {
          String? routeName = ModalRoute.of(context)?.settings.name;
          if (routeName == "/appointment" ||
              routeName == "/balance_page" ||
              routeName == "/profile") {
            Get.toNamed('/home');
            controller.selectedIndex = 0;
            return false;
          }
          if (routeName == "/home") {
            DateTime now = DateTime.now();
            if (currentBackPressTime == null ||
                now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
              currentBackPressTime = now;
              Fluttertoast.showToast(
                msg: "Press Back Button Again to Exit".tr,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
              );
              return false;
            }
            FlutterExitApp.exitApp();
            return false;
          }
          return true;
        });
  }

  Future<bool> showExitPopup(BuildContext context) async {
    return await showDialog(
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit App'),
            content: Text('Do you want to exit an App?'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                //return false when click on "NO"
                child: Text('No'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                //return true when click on "Yes"
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }
}

class MyNavegateBar extends StatelessWidget{
  DashboardController controller;
  MyNavegateBar(this.controller);
  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.ltr,
      child: BottomNavigationBar(
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
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.payment_rounded,
                ),
                label: ''),
        /*    BottomNavigationBarItem(
                icon: Icon(
                  Icons.message,
                  color: Colors.blue[500],
                ),
                label: "Chat".tr),*/
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: ''),
          ],
          currentIndex: controller.selectedIndex,
          onTap: (index) {
            switch (index) {
              case 0:
                {
                  Get.toNamed('/home');
                  controller.selectedIndex = 0;
                  break;
                }
              case 1:
                {
                  Get.toNamed('/appointment');
                  controller.selectedIndex = 1;
                  break;
                }
              case 2:
                {
                  Get.toNamed('/balance_page');
                  controller.selectedIndex = 2;
                  break;
                }
              case 3:
                {
                  Get.toNamed('/profile');
                  controller.selectedIndex = 3;
                  break;
                }
            }
          },
      ),
    );

  }
}
