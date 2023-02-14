import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/models/time_slot_model.dart';
import 'package:hallo_doctor_client/app/modules/appointment/controllers/appointment_controller.dart';
import 'package:hallo_doctor_client/app/modules/dashboard/controllers/dashboard_controller.dart';

class PaymentSuccessController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final count = 0.obs;
  late AnimationController animController;
  TimeSlot timeSlot = Get.arguments[0];
  double price = Get.arguments[1];
  @override
  void onInit() {
    super.onInit();
    animController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    // price.value = timeSlot.price!;
  }

  @override
  void onClose() {
    animController.dispose();
  }

  void increment() => count.value++;

  void goHome() {
    Get.offAllNamed('home');
    Get.find<DashboardController>().selectedIndex = 0;
    Get.lazyPut(()=>AppointmentController());
  }
}
