import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hallo_doctor_client/app/models/time_slot_model.dart';

class TimeSlotService {
  Future<List<TimeSlot>> getListAppointment(User user) async {
    try {
      print(user.displayName);
      var userId = user.uid;
      print("XAX");

      var documentSnapshot = await FirebaseFirestore.instance
          .collection('DoctorTimeslot')
          .where('bookByWho.userId', isEqualTo: userId)
          .where('charged', isEqualTo: true)
          .get();
      if (documentSnapshot.docs.isEmpty) {
        return [];
      }
      print("XAX");
      List<TimeSlot> listTimeslot = documentSnapshot.docs.map((doc) {
        var data = doc.data();
        data['timeSlotId'] = doc.reference.id;
        TimeSlot timeSlot = TimeSlot.fromJson(data);
        return timeSlot;
      }).toList();
      return listTimeslot;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<TimeSlot> getTimeSlotById(String timeslotId) async {
    try {
      var timeslotRef = await FirebaseFirestore.instance
          .collection('DoctorTimeslot')
          .doc(timeslotId)
          .get();

      TimeSlot timeslot = TimeSlot.fromFirestore(timeslotRef);
      print("MMM");
      timeslot.timeSlotId = timeslotId;
      print("MMM");
      return timeslot;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future rescheduleTimeslot(
      TimeSlot timeSlotNow, TimeSlot timeslotChanged) async {
    try {
      var callable =
          FirebaseFunctions.instance.httpsCallable('rescheduleTimeslot');
      await callable({
        'timeSlotIdNow': timeSlotNow.timeSlotId,
        'timeslotChanged': timeslotChanged.timeSlotId
      });
    } on FirebaseFunctionsException catch (e) {
      return Future.error(e.message!);
    }
  }

  Future<void> updateTimeslotAvailable(timeSlotId) async {
    try {
      var callable =
          FirebaseFunctions.instance.httpsCallable('updateTimeslotAvailable');
      await callable({'timeSlotId': timeSlotId});
    } on FirebaseFunctionsException catch (e) {
      return Future.error(e.message!);
    }
  }

  Future updateTimeSlot(TimeSlot timeSlot, double bookedAmount,
      int bookedDuration, String userId) async {
    try {
      await FirebaseFirestore.instance
          .collection('DoctorTimeslot')
          .doc(timeSlot.timeSlotId)
          .update({
        'bookedAmount': bookedAmount,
        'bookedDuration': bookedDuration,
        "bookByWho.userId": userId,
        "charged": true,
      });
    } catch (e) {
      return Future.error(e);
    }
  }

  Future deleteTimeSlot(TimeSlot timeSlot) async {
    try {
      await FirebaseFirestore.instance
          .collection('DoctorTimeslot')
          .doc(timeSlot.timeSlotId)
          .delete();
      print('success delete timeslot');
    } catch (e) {
      return Future.error(e);
    }
  }
}
