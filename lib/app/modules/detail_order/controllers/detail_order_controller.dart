import 'package:flutter_easyloading/flutter_easyloading.dart';
//import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/models/doctor_model.dart';
import 'package:hallo_doctor_client/app/models/order_detail_model.dart';
import 'package:hallo_doctor_client/app/models/time_slot_model.dart';
import 'package:hallo_doctor_client/app/service/notification_service.dart';
import 'package:hallo_doctor_client/app/service/payment_service.dart';
import 'package:hallo_doctor_client/app/service/user_service.dart';
import 'package:hallo_doctor_client/app/utils/constants/constants.dart';
import 'package:intl/intl.dart';
import '../../balance/views/balance_view.dart';

class DetailOrderController extends GetxController {
  final username = ''.obs;
  final UserService userService = Get.find();
  List<OrderDetailModel> orderDetail = List.empty();
  TimeSlot selectedTimeSlot = Get.arguments[0];
  Doctor doctor = Get.arguments[1];
  PaymentService paymentService = Get.find();
  NotificationService notificationService = Get.find<NotificationService>();
  late String clientSecret;
  @override
  void onInit() async{
    super.onInit();
    userService.getUsername().then((value) {
      username.value = value;
    });
  }

  @override
  void onClose() {}

  OrderDetailModel buildOrderDetail() {
    var formatter = DateFormat('yyyy-MM-dd hh:mm');
    var time = formatter.format(selectedTimeSlot.timeSlot!);

    var orderDetail = OrderDetailModel(
        itemId: selectedTimeSlot.timeSlotId!,
        itemName: 'Consultation with ${doctor.doctorName!}',
        time: time,
        duration: '${selectedTimeSlot.duration} minute',
        price: currencySign + selectedTimeSlot.price.toString());
    return orderDetail;
  }

  void makePayment()async{
    EasyLoading.show();
    try {
      String? userId = userService.currentUser!.uid;
      double? balance = await userService.getUserBalance(userId);
      if (balance! > selectedTimeSlot.price!) {
        await paymentService.makePayment(
            selectedTimeSlot.timeSlotId!, userService.getUserId(),
            selectedTimeSlot.price!,selectedTimeSlot.duration!);
        EasyLoading.dismiss();
        Get.offNamed('/payment-success', arguments: selectedTimeSlot);
        notificationService.setNotificationAppointment(selectedTimeSlot.timeSlot!);
      }
      else {
        Fluttertoast.showToast(msg: 'please charge your balance!');
        Get.to(() => BalanceView());
      }
    } catch (err) {
      Fluttertoast.showToast(msg: err.toString());
      return null;
    }

  }
  /*
  void makePayment() async {
    EasyLoading.show();
    try {
      var clientSecret = await paymentService.getClientSecret(
          selectedTimeSlot.timeSlotId!, userService.getUserId());
      if (clientSecret.isEmpty) return;
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        applePay: true,
        googlePay: true,
        testEnv: true,
        merchantCountryCode: 'US',
        merchantDisplayName: 'Helo Doctor',
        paymentIntentClientSecret: clientSecret,
      ));
      EasyLoading.dismiss();
      await Stripe.instance.presentPaymentSheet();
      Get.offNamed('/payment-success', arguments: selectedTimeSlot);
      //selectedTimeSlot.timeSlot
      notificationService.setNotificationAppointment(selectedTimeSlot.timeSlot!);
    } on StripeException catch (err) {
      Fluttertoast.showToast(msg: err.error.message!);
      return null;
    } catch (err) {
      Fluttertoast.showToast(msg: err.toString());
      return null;
    } finally {}
  }*/
}
