import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/modules/widgets/background_container.dart';
import 'package:hallo_doctor_client/app/utils/constants/style_constants.dart';
import '../../../utils/localization.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../controllers/doctor_category_controller.dart';

class DoctorCategoryView extends GetView<DoctorCategoryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
        text: 'Doctor Specialist'.tr,
        isPadding: 0,
        widget: controller.obx((listCategory) => Padding(
              padding: const EdgeInsets.only(bottom: 170),
              child: GridView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: listCategory!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 3 / 4,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed('/list-doctor',
                            arguments: listCategory[index]);
                      },
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10,
                                )
                              ]),
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 5,
                                  child: Container(
                                    child: CachedNetworkImage(
                                        imageUrl: listCategory[index].iconUrl!),
                                  )),
                              Expanded(
                                flex: 4,
                                child: Container(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Text(
                                    (Get.locale ==
                                            LocalizationService.locales[0])
                                        ? listCategory[index].categoryName!
                                        : listCategory[index]
                                            .categoryTranslation!,
                                    style: doctorCategoryTextStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          )),
                    );
                  }),
            )),
      ),
      bottomNavigationBar: DashboardView(),
    );
  }
}
