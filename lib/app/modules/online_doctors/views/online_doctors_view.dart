import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/modules/online_doctors/controllers/online_doctors_controller.dart';
import 'package:hallo_doctor_client/app/modules/online_doctors/views/widgets/custom_button.dart';
import 'package:hallo_doctor_client/app/modules/online_doctors/views/widgets/online_doctor_card.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../../widgets/background_container.dart';
import '../../widgets/empty_list.dart';
import 'package:intl/intl.dart';

class OnlineDoctorsView extends GetView<OnlineDoctorsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          return controller.getOnlineDoctors();
        },
        child: BackgroundContainer(
          text: 'Online Doctors'.tr,
          widget: controller.obx(
              (onlineDoctors) => ListView.builder(
                    padding: EdgeInsets.only(top: 10.0),
                    itemCount: onlineDoctors!.length,
                    itemBuilder: (context, index) {
                      return OnlineDoctorCard(
                          doctorPhotoUrl: onlineDoctors[index].doctorPicture!,
                          doctorName: onlineDoctors[index].doctorName!,
                          doctorCategory: onlineDoctors[index]
                              .doctorCategory!
                              .categoryName!,
                          onTap: () {
                            // var timeslot =
                            //     controller.timeSlotOfDoctors[index].timeSlot;
                            // int duration =
                            //     controller.timeSlotOfDoctors[index].duration!;
                            // double price =
                            //     controller.timeSlotOfDoctors[index].price!;
                            viewBottomSheet(
                              context,
                              // price,
                              // timeslot,
                              // duration,
                              index,
                            );
                          });
                    },
                  ),
              onEmpty: Center(child: EmptyList(msg: 'No Online Doctors'.tr))),
        ),
      ),
      bottomNavigationBar: DashboardView(),
    );
  }

  viewBottomSheet(
    context,
    // price,
    // timeslot,
    // timeslotDuration,
    index,
  ) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (BuildContext c) {
          // var timeAvailable = controller.timeSlotOfDoctors[index].timeSlot!.add(
          //     Duration(minutes: controller.timeSlotOfDoctors[index].duration!));
          // var timeAvailableFormat = DateFormat.Hm().format(timeAvailable);
          return FractionallySizedBox(
            heightFactor: 0.5,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: SizedBox(
                height: 300,
                child: Column(
                  children: [
                    /*  Text(
                        'Choose a duration for consulting '.tr,
                        style: TextStyle(
                          fontSize:17
                        ),
                      ),*/
                    /*   Text(
                    'Doctor is available until $timeAvailableFormat'.tr,
                    style: TextStyle(color: Color(0xFF0faa9a)),
                  ),
                  SizedBox(
                    height: 30
                  ),*/
                    /*  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                              CustomButton(
                                  onTap: (){
                                     controller.selectedBottomSheetButton.value=0;
                                     controller.duration=15;
                                     controller.calculatePrice(15, timeslot, timeslotDuration, price);
                                  },
                                  text: '15 min',
                                  color: controller.selectedBottomSheetButton.value==0
                                      ?Color(0xFF0faa9a)
                                      :Colors.grey ,
                              ),
                              CustomButton(
                                  onTap: (){
                                    controller.selectedBottomSheetButton.value=1;
                                    controller.duration=30;
                                    controller.calculatePrice(30, timeslot, timeslotDuration, price);
                                  },
                                  text: '30 min',
                                  color: controller.selectedBottomSheetButton.value==1
                                      ?Color(0xFF0faa9a)
                                      : Colors.grey,
                              ),
                              CustomButton(
                                  onTap: (){
                                    controller.selectedBottomSheetButton.value=2;
                                    controller.duration=45;
                                    controller.calculatePrice(45, timeslot, timeslotDuration, price);
                                  },
                                  text: '45 min',
                                  color: controller.selectedBottomSheetButton.value==2
                                      ?Color(0xFF0faa9a)
                                      :Colors.grey ,
                              ),
                          ],
                        ),
                      SizedBox(height: 25,),*/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Consulting will cost = '),
                        Text(
                          '${controller.price.toString()} USD',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 51,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          onTap: () {
                            Get.back();
                          },
                          text: 'Cancel'.tr,
                          color: Colors.black54,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        CustomButton(
                          onTap: () {
                            controller.onTap(
                              index,
                              controller.price,
                              controller.duration,
                              // timeslot,
                              // timeslotDuration,
                            );
                          },
                          text: 'Confirm'.tr,
                          color: Color(0xFF195076),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
