import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/service/payment_service.dart';
import '../../../service/timeslot_service.dart';
import '../controllers/detail_order_controller.dart';
import '../../balance/controllers/balance_controller.dart';

class DetailOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailOrderController>(
      () => DetailOrderController(),
    );
    Get.lazyPut<PaymentService>(
      () => PaymentService(),
    );
    Get.lazyPut<TimeSlotService>(
      () => TimeSlotService(),
    );
    Get.lazyPut<BalanceController>(
      () => BalanceController(),
    );
  }
}
