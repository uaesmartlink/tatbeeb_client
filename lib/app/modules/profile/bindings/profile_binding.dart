import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/service/user_service.dart';
import '../../../service/payment_service.dart';
import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
    Get.lazyPut<PaymentService>(
          () => PaymentService(),
    );
    Get.put(UserService());
  }
}
