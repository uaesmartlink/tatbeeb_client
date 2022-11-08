import 'package:flutter_easyloading/flutter_easyloading.dart';
//import 'package:flutter_stripe/flutter_stripe.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/service/auth_service.dart';
import 'package:hallo_doctor_client/app/service/carousel_service.dart';
import 'package:hallo_doctor_client/app/service/user_service.dart';

import '../../dashboard/controllers/dashboard_controller.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final caoruselIndex = 0.obs;
  get getcaoruselIndex => caoruselIndex.value;
  AuthService authService = Get.find();
  UserService userService = Get.find();
  var userPicture = ''.obs;
  List<String?> listImageCarousel = [];

  @override
  void onInit() async {
    super.onInit();
    EasyLoading.instance.maskType = EasyLoadingMaskType.black;
    userPicture.value = userService.getProfilePicture()!;
    listImageCarousel = await CarouselService().getListCarouselUrl();
    //print('jumlah image carousel : ${listImageCarousel.length}');
    update();
  }

  @override
  void onClose() {}
  void carouselChange(int index) {
    caoruselIndex.value = index;
  }

  void logout() async {
    authService.logout().then((value) => Get.toNamed('/login'));
  }

  void toProfile() {
    Get.find<DashboardController>().selectedIndex = 3;
    Get.toNamed('/profile');

  }

  void toOnlineDoctors() {
    Get.toNamed('/online_doctors');
  }

  void toDoctorCategory() {
    Get.toNamed('/doctor-category');
  }

  void toTopRatedDoctor() {
    Get.toNamed('/top-rated-doctor');
  }

  void toSearchDoctor() {
    Get.toNamed('/search-doctor');
  }
}
