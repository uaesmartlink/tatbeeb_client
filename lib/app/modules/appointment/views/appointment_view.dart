import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/modules/dashboard/views/dashboard_view.dart';
import 'package:hallo_doctor_client/app/modules/widgets/empty_list.dart';
import '../../widgets/background_container.dart';
import '../controllers/appointment_controller.dart';
import 'package:intl/intl.dart';

class AppointmentView extends GetView<AppointmentController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        return  controller.toHome();
      },
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () {
            return controller.getListAppointment();
          },
          child: BackgroundContainer(
            isArrowBack: 0,
            isPadding: 0,
            text:'Appointment'.tr,
            widget: controller.obx(
              (listTimeslot) => Padding(
                padding: const EdgeInsets.only(bottom: 151),
                child: ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: listTimeslot!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(top:10),
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
                      child: ListTile(
                        onTap: () {
                          Get.toNamed('/appointment-detail',
                              arguments: listTimeslot[index]);
                        },
                        leading:Container(
                           height: 45,
                           width: 45,
                           decoration: BoxDecoration(
                             image: DecorationImage(
                             fit: BoxFit.cover,
                             image: CachedNetworkImageProvider(
                                 listTimeslot[index].doctor!.doctorPicture!),
                             ),
                             borderRadius: BorderRadius.all(Radius.circular(12.0)),
                           ),
                        ),
                        title: Text('Appointment with '.tr +
                            listTimeslot[index].doctor!.doctorName!,
                          style: TextStyle(
                              fontSize: 14
                          ),
                        ),
                        subtitle: Text(
                          'at '.tr +
                              DateFormat('EEEE, dd, MMMM')
                                  .format(listTimeslot[index].timeSlot!),
                          style: TextStyle(
                            color: Color(0xFF0faa9a),
                            fontSize: 12
                          ),
                        ),
                        trailing: Icon(Icons.navigate_next_outlined),
                      ),
                    );
                  },
                ),
              ),
              onEmpty: Center(
                child: EmptyList(msg: 'you don\'t have an appointment yet'.tr),
              ),
            ),
          ),
        ),
        bottomNavigationBar: DashboardView(),
      ),
    );
  }
}
