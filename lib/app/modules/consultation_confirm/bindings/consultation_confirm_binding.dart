import 'package:get/get.dart';

import '../controllers/consultation_confirm_controller.dart';
import '../../dashboard/controllers/dashboard_controller.dart';
import '../../../service/notification_service.dart';

class ConsultationConfirmBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConsultationConfirmController>(
      () => ConsultationConfirmController(),
    );
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
    Get.lazyPut<NotificationService>(
      () => NotificationService(),
    );
  }
}
