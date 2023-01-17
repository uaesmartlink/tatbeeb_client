import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/models/time_slot_model.dart';
import 'package:hallo_doctor_client/app/service/review_service.dart';
import 'package:hallo_doctor_client/app/service/user_service.dart';

class ReviewController extends GetxController {
  //TODO: Implement ReviewController

  var review = '';
  var rating = 5.0.obs;
  TextEditingController textEditingReviewController = TextEditingController();
  TimeSlot timeSlot = Get.arguments;
  var price = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    price.value = timeSlot.price!;
  }

  @override
  void onClose() {}
  void saveReview() async {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    var user = UserService().currentUser;
    try {
      await ReviewService().saveReview('',
          rating.value.toInt(), timeSlot, user!);
      Get.toNamed("/home");
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }
}
