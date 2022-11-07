import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/service/user_service.dart';
import '../../../service/payment_service.dart';
import '../controllers/balance_controller.dart';


class BalanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BalanceController>(
          () => BalanceController(),
    );
    Get.lazyPut<PaymentService>(
          () => PaymentService(),
    );
    Get.put(UserService());
  }
}
