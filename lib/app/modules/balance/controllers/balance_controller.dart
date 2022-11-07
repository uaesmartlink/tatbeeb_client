import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/service/auth_service.dart';
import 'package:hallo_doctor_client/app/service/user_service.dart';
import '../../../service/payment_service.dart';


class BalanceController extends GetxController {
  var balance=0.0.obs;
  String userId='';

  AuthService authService = Get.find();
  UserService userService = Get.find();

  @override
  void onInit() async {
    super.onInit();
    userId=  userService.currentUser!.uid;
    balance.value=(await userService.getUserBalance(userId))!;
  }

  @override
  void onClose() {}

  void chargeBalance(double amount) async {
    try {
      var clientSecret = await PaymentService().getSecret(
          amount, userService.getUserId());
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
      await Stripe.instance.presentPaymentSheet();
      balance.value=(await userService.getUserBalance(userId))!;
    } on StripeException catch (err) {
      Fluttertoast.showToast(msg: err.error.message!);
      return null;
    } catch (err) {
      Fluttertoast.showToast(msg: err.toString());
      return null;
    } finally {}
  }
}