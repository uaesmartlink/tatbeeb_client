import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hallo_doctor_client/app/modules/widgets/background_container.dart';
import 'package:lottie/lottie.dart';
import 'package:hallo_doctor_client/app/utils/constants/constants.dart';
import 'package:hallo_doctor_client/app/utils/constants/style_constants.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../controllers/payment_success_controller.dart';

class PaymentSuccessView extends GetView<PaymentSuccessController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackgroundContainer(
          text:'Payment Success'.tr,
          widget: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                    width: double.infinity,
                    child: Lottie.asset('assets/animations/done.json',
                        height: 250,
                        repeat: false,
                        controller: controller.animController,
                        onLoaded: (composition) {
                      controller.animController.forward();
                    })),
                Text(
                  'Payment Successfull'.tr,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: Color(0xFF76e6da),),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Your payment has been processed! \n Details of transaction are included below'
                      .tr,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: mSubtitleColor),
                  textAlign: TextAlign.center,
                ),
                Divider(
                  height: 30,
                ),
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('TOTAL AMOUNT PAID'.tr),
                        Text(currencySign + controller.price.value.toString())
                      ],
                    )),
                Divider(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('TRANSACTION DATE'.tr),
                    Text(DateTime.now().toLocal().toString())
                  ],
                ),
                Divider(
                  height: 30,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xFF125a9a)),
                    ),
                    onPressed: () {
                      controller.goHome();
                    },
                    child: Text(
                        'Go Home'.tr,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        )
                    ),
                    )
              ],
            ),
          ),
        ),
      bottomNavigationBar: DashboardView(),
    );
  }
}
