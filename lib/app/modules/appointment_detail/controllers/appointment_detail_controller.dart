import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/service/user_service.dart';

import 'package:hallo_doctor_client/app/models/doctor_model.dart';
import 'package:hallo_doctor_client/app/models/order_model.dart';
import 'package:hallo_doctor_client/app/models/time_slot_model.dart';
import 'package:hallo_doctor_client/app/service/doctor_service.dart';
import 'package:hallo_doctor_client/app/service/order_service.dart';
import 'package:hallo_doctor_client/app/service/videocall_service.dart';
import 'package:hallo_doctor_client/app/service/notification_service.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AppointmentDetailController extends GetxController
    with StateMixin<TimeSlot> {
  NotificationService notificationService = Get.find<NotificationService>();

  final count = 0.obs;
  VideoCallService videoCallService = Get.find();
  var videoCallStatus = true.obs;

  //ParseObject? room;
  TimeSlot? selectedTimeslot = Get.arguments[0];
  Doctor doctor = Get.arguments[1];
  int duration = Get.arguments[2];
  late Appointment order;
  late String token;
  var database = FirebaseDatabase.instance.ref();
  late StreamSubscription _roomStreaming;
  var active = true.obs;

  @override
  void onInit() async {
    super.onInit();
    if (selectedTimeslot != null) {
      DoctorService().getDoctorDetail(selectedTimeslot!.doctorid!).then(
        (doc) {
          selectedTimeslot!.doctor = doc;
          doctor = doc;
          change(selectedTimeslot, status: RxStatus.success());
          if (selectedTimeslot!.status == 'refund') {
            Get.defaultDialog(
                title: 'Appointment Canceled'.tr,
                content: Text(
                    'the doctor has canceled the appointment, and your payment has been refunded'
                        .tr),
                onConfirm: () {
                  Get.back();
                });
          }
        },
      );
    } else {
      DoctorService().getDoctorById(doctor.doctorId.toString()).then(
        (doc) {
          selectedTimeslot = TimeSlot(
            timeSlot: DateTime.now(),
            doctor: doctor,
            timeSlotId: DateTime.now().hashCode.toString(),
            price: (doctor.doctorPrice! / 4).toDouble(),
            doctorid: doctor.doctorId,
            duration: 15,
            purchaseTime: DateTime.now(),
          );
          change(selectedTimeslot, status: RxStatus.success());
        },
      );
    }
    var roomSnapshot = FirebaseFirestore.instance
        .collection('RoomVideoCall')
        .doc(DateTime.now().hashCode.toString())
        .snapshots();

    _roomStreaming = roomSnapshot.listen((event) async {
      if (event.data() == null) {
        videoCallStatus.value = true;
      } else {
        await Future.delayed(const Duration(seconds: 1), () {
          videoCallStatus.value = true;
          token = event.data()!['token'];
          printInfo(info: 'token : $token');
        });
      }
    });
  }

  @override
  void onClose() {
    _roomStreaming.cancel();
  }

  void startVideoCall() async{
    if (videoCallStatus.value) {
      // videoCallStatus.value = false;
      EasyLoading.show();

      token = await VideoCallService()
          .getAgoraToken(selectedTimeslot!.timeSlotId!);
      print(token);
      final roomData = <String, dynamic>{
        'room': selectedTimeslot!.timeSlotId,
        'token': token,
        'timestamp': Timestamp.fromDate(DateTime.now())
      };

      await VideoCallService()
          .createRoom(selectedTimeslot!.timeSlotId!, roomData);
      String doctorId = await DoctorService().getUserId(doctor);

      notificationService.notificationStartAppointment(
          UserService().currentUser!.displayName!,
          doctorId,
          selectedTimeslot!.timeSlotId!,
          token,
          selectedTimeslot!.timeSlotId!);
      EasyLoading.dismiss();

      Get.toNamed('/video-call', arguments: [
        {
          'timeSlot': selectedTimeslot,
          'room': selectedTimeslot!.timeSlotId,
          'token': token
        }
      ]);
    } else {
      if (selectedTimeslot!.status == 'refund') {
        Fluttertoast.showToast(
            msg:
                'the doctor has canceled the appointment, and your payment has been refunded'
                    .tr,
            toastLength: Toast.LENGTH_LONG);
      } else {
        Fluttertoast.showToast(
            msg:
                'the doctor has not started the meeting session, this button will automatically turn on when the doctor has started it'
                    .tr,
            toastLength: Toast.LENGTH_LONG);
      }
    }
  }

  toConsultationConfirm() {
    Get.toNamed('/consultation-confirm', arguments: selectedTimeslot);
  }

  Future getOrder() async {
    try {
      order = await OrderService().getSuccessOrder(selectedTimeslot!);
    } catch (err) {
      Fluttertoast.showToast(msg: err.toString());
    }
  }

  void rescheduleAppointment() {
    Get.toNamed('/consultation-date-picker',
        arguments: [selectedTimeslot!.doctor, selectedTimeslot]);
  }
  
  /*void toChatLawyer() async {
    // String lawyerUserId = await LawyerService().getUserId(lawyer);
    print(lawyer.lawyerId);
    print(lawyer.lawyerName);
    print(lawyer.lawyerPicture);
    if (lawyer.lawyerId!.isEmpty) {
      Fluttertoast.showToast(msg: 'Lawyer no longger exist'.tr);
      return;
    }
    final otherUser = types.User(
      id: lawyer.lawyerId!,
      firstName: lawyer.lawyerName,
      imageUrl: lawyer.lawyerPicture,
    );

    final room = await FirebaseChatCore.instance.createRoom(
      otherUser,
    );
    Get.toNamed('/chat', arguments: [room, lawyer]);
  }*/

}
