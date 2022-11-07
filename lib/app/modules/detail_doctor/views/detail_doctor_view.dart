import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/modules/dashboard/views/dashboard_view.dart';
import 'package:hallo_doctor_client/app/modules/widgets/background_container.dart';
import '../../../utils/constants/constants.dart';
import '../../list_doctor/views/widgets/list_doctor_card.dart';
import '../controllers/detail_doctor_controller.dart';

class DetailDoctorView extends GetView<DetailDoctorController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
        text: 'Doctor'.tr,
        widget: controller.obx((doctor) => Container(
              alignment: Alignment.center,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DoctorCard(
                      doctorName: doctor!.doctorName!,
                      doctorCategory: doctor.doctorCategory!.categoryName!,
                      doctorPrice: currencySign + doctor.doctorPrice.toString(),
                      doctorPhotoUrl: doctor.doctorPicture!,
                      doctorHospital: doctor.doctorHospital!,
                      onTap: () {
                        Get.toNamed('/consultation-date-picker',
                            arguments: [controller.selectedDoctor, null]);
                      },
                    ),
                    const SizedBox(height: 34,),
                    Text(
                      'Service'.tr,
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF333333),
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 17,
                    ),
                    Text(
                      doctor.doctorShortBiography!,
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF333333),
                      ),
                    )
                  ]),
            )),
      ),
      bottomNavigationBar: DashboardView(),
    );
  }
}
