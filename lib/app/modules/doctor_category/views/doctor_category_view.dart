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
              padding: const EdgeInsets.only(bottom: 99),
              child: GridView.builder(
                padding: const EdgeInsets.all(20),
                  itemCount: listCategory!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 15),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed('/list-doctor',
                            arguments: listCategory[index]);
                      },
                      child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 40,
                              )
                            ]
                          ),
                          child: Column(
                           children: [
                             Expanded(
                              child: Container(
                               decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF76e6da),),
                             padding: const EdgeInsets.all(8.0),
                             child: CachedNetworkImage(
                                imageUrl: listCategory[index].iconUrl!),
                            )),
                            SizedBox(
                            height: 5,
                          ),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              (Get.locale==LocalizationService.locales[0])?listCategory[index].categoryName!:listCategory[index].categoryTranslation!,
                              style: doctorCategoryTextStyle,
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          )
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
