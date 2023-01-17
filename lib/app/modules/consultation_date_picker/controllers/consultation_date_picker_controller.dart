import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/models/doctor_model.dart';
import 'package:hallo_doctor_client/app/models/time_slot_model.dart';
import 'package:hallo_doctor_client/app/service/doctor_service.dart';
import 'package:hallo_doctor_client/app/service/timeslot_service.dart';

enum TimeSlotStatus { startUp, unselected, selected }

class ConsultationDatePickerController extends GetxController
    with StateMixin<List<TimeSlot>> {
  List<TimeSlot> allTimeSlot = List.empty(growable: true);
  List<TimeSlot> tempTimeSlot = List.empty(growable: true);
  late List<TimeSlot> selectedDateTimeslot = List.empty();
  var selectedTimeSlot = TimeSlot().obs;
  Doctor doctor = Get.arguments[0];
  bool isReschedule = false;
  late int price;
  DateTime date = DateTime.now();
  List<TimeSlot> schedule = List.empty(growable: true);
  List<String> durations = List.empty(growable: true);
  int durationSelectedIndex = 0;

  @override
  void onInit() {
    super.onInit();
    price = doctor.doctorPrice!;
    durations.add('15 minutes\n       \$${price / 4}');
    durations.add('30 minutes\n       \$${price / 2}');
    durations.add('45 minutes\n       \$${price / 4 * 3}');
    durations.add('60 minutes\n       \$${price}');
    print(price);
    if (Get.arguments[1] != null) isReschedule = true;
    //print('is Reschedule $isReschedule');
    DoctorService().getDoctorTimeSlot(doctor).then((timeSlot) {
      allTimeSlot = timeSlot;
      tempTimeSlot = timeSlot;
      updateScheduleAtDate(
          DateTime.now().day, DateTime.now().month, DateTime.now().year);
    }).onError((error, stackTrace) {
      change(
        [],
        status: RxStatus.error(
          error.toString(),
        ),
      );
    });
  }

  @override
  void onClose() {}

  void updateScheduleAtDate(int date, int month, int year) {
     schedule = allTimeSlot
        .where((timeSlot) =>
            timeSlot.timeSlot!.day.isEqual(date) &&
            timeSlot.timeSlot!.month.isEqual(month) &&
            timeSlot.timeSlot!.year.isEqual(year))
        .toList();
    //print('Schedule for date ${date.toString()} is : ${schedule.length}');
    change(schedule, status: RxStatus.success());
  }

  void updateList() {
    allTimeSlot = List.empty(growable: true);

    int slot = durationSelectedIndex;
    for (int i = 0; i < tempTimeSlot.length - slot; i++) {
      TimeSlot first = tempTimeSlot[i];
      TimeSlot last = tempTimeSlot[i + slot];

      int h1 = first.timeSlot!.hour;
      int h2 = last.timeSlot!.hour;
      int m1 = first.timeSlot!.minute;
      int m2 = last.timeSlot!.minute;

      int time1 = h1 * 60 + m1;
      int time2 = h2 * 60 + m2;
      if (time2 - time1 <= (slot + 1) * 15 &&
          first.timeSlot?.day == last.timeSlot?.day!) {
        allTimeSlot.add(first);
      }
    }
    updateScheduleAtDate(date.day, date.month, date.year);
    //change(allTimeSlot, status: RxStatus.success());
  }

  void confirm() async {
    try {
      if (isReschedule) {
        EasyLoading.show();
        await TimeSlotService()
            .rescheduleTimeslot(Get.arguments[1], selectedTimeSlot.value);
        Fluttertoast.showToast(
            msg: 'Appointment has been successfully rescheduled'.tr);
        EasyLoading.dismiss();
        Get.back();
      } else {
        int index = 0;
        for(index = 0 ; index < schedule.length ; index++){
          if(schedule[index].timeSlotId == selectedTimeSlot.value.timeSlotId)
            break;
        }
        List<TimeSlot> timesSlot = List.empty(growable: true);
        for(int i = index + 1 ; i <= index + durationSelectedIndex ; i++){
            timesSlot.add(schedule[i]);
            print(schedule[i].timeSlot);
        }
        Get.toNamed(
          '/detail-order',
          arguments: [
            selectedTimeSlot.value,
            doctor,
            (durationSelectedIndex + 1) * 15,
            timesSlot,
          ],
        );
      }
    } catch (e) {
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
