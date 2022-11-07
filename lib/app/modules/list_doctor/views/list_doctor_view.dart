import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/modules/list_doctor/views/widgets/list_doctor_card.dart';
import 'package:hallo_doctor_client/app/modules/widgets/empty_list.dart';
import 'package:hallo_doctor_client/app/utils/constants/constants.dart';

import '../../dashboard/views/dashboard_view.dart';
import '../../widgets/background_container.dart';
import '../controllers/list_doctor_controller.dart';

class ListDoctorView extends GetView<ListDoctorController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
            text:'Doctor'.tr,
            widget: controller.obx(
                (listDoctor) => Padding(
                  padding: const EdgeInsets.only(bottom: 151),
                  child: ListView.builder(
                        padding: EdgeInsets.only(top: 10.0),
                        itemCount: listDoctor!.length,
                        itemBuilder: (context, index) {
                          return DoctorCard(
                              doctorName: listDoctor[index].doctorName!,
                              doctorCategory:
                                  listDoctor[index].doctorCategory!.categoryName!,
                              doctorPrice: currencySign +
                                  listDoctor[index].doctorPrice.toString(),
                              doctorPhotoUrl: listDoctor[index].doctorPicture!,
                              doctorHospital: listDoctor[index].doctorHospital!,
                              onTap: () {
                                Get.toNamed('/detail-doctor',
                                    arguments: listDoctor[index]);
                              });
                        },
                      ),
                ),
                onEmpty: Center(
                    child: EmptyList(
                        msg: 'No Doctor Registered in this Category'.tr))),

      ),
      bottomNavigationBar: DashboardView(),
    );
  }
}
