import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hallo_doctor_client/app/models/doctor_category_model.dart';
import 'package:hallo_doctor_client/app/models/doctor_model.dart';
import 'package:hallo_doctor_client/app/models/time_slot_model.dart';

class DoctorService {
  //Added by N
  //Get list of all doctor schedule base on time slot
  Future<List<TimeSlot>> getAllDoctorTimeSlotNow() async{
    try {
      //List<TimeSlot> listTimeslot = [];
      QuerySnapshot doctorScheduleRef =await FirebaseFirestore.instance
          .collection('DoctorTimeslot')
          .where('available', isEqualTo: true)
          .get();
       var listTimeslot=doctorScheduleRef.docs.map((doc) {
        var data=doc.data() as Map<String,dynamic>;
        data['timeSlotId'] = doc.reference.id;
        TimeSlot timeSlot = TimeSlot.fromJson(data);
        return timeSlot;
      }).toList();
       if (doctorScheduleRef.docs.isEmpty) return [];
      return listTimeslot;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
  //End by N

  //Get list of Doctor schedule base on doctor id
  Future<List<TimeSlot>> getDoctorTimeSlot(Doctor doctor) async {
    try {
      print('doctor id : ${doctor.doctorId!}');
      //List<TimeSlot> listTimeslot = [];
      QuerySnapshot doctorScheduleRef = await FirebaseFirestore.instance
          .collection('DoctorTimeslot')
          .where('doctorId', isEqualTo: doctor.doctorId)
          .get();
      var listTimeslot = doctorScheduleRef.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data['timeSlotId'] = doc.reference.id;
        TimeSlot timeSlot = TimeSlot.fromJson(data);

        return timeSlot;
      }).toList();
      print('length : ${listTimeslot.length}');
      if (doctorScheduleRef.docs.isEmpty) return [];
      return listTimeslot;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

// Get doctor and all its property
  Future<Doctor> getDoctorDetail(String doctorId) async {
    var doctorSnapshot = await FirebaseFirestore.instance
        .collection('Doctors')
        .doc(doctorId)
        .get();
    Doctor doctor =
        Doctor.fromJson(doctorSnapshot.data() as Map<String, dynamic>);
    doctor.doctorId = doctorId;
    return doctor;
  }

  Future<List<Doctor>> getListDoctorByCategory(
      DoctorCategory doctorCategory) async {
    try {
      List<Doctor> listDoctor = [];
      var listDoctorQuery = await FirebaseFirestore.instance
          .collection('Doctors')
          .where('doctorCategory.categoryId',
              isEqualTo: doctorCategory.categoryId)
          .where('accountStatus', isEqualTo: 'active')
          .get();

      if (listDoctorQuery.docs.isEmpty) return [];
       listDoctorQuery.docs.map((doc) {
        var data = doc.data();
        data['doctorId'] = doc.reference.id;
        Doctor doctor = Doctor.fromJson(data);
        listDoctor.add(doctor);
      }).toList();
      //print('list doctor : $list');
      return listDoctor;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<Doctor>> getTopRatedDoctor({int limit = 10}) async {
    try {
      var topRatedDoctor = await FirebaseFirestore.instance
          .collection('TopRatedDoctor')
          .limit(limit)
          .get();
      List<String> listIdTopRatedDoctor = topRatedDoctor.docs.map((doc) {
        String myList =
            (doc.data()['doctorId'] as String).replaceAll(RegExp(r"\s+"), "");
        return myList;
      }).toList();

      //print('list top rated : $listIdTopRatedDoctor');
      if (listIdTopRatedDoctor.isEmpty) return [];
      var doctorRef = await FirebaseFirestore.instance
          .collection('Doctors')
          .where(FieldPath.documentId, whereIn: listIdTopRatedDoctor)
          .get();
      //print('length : ${doctorRef.docs.length}');
      List<Doctor> listTopRatedDoctor = doctorRef.docs.map((doc) {
        var data = doc.data();
        data['doctorId'] = doc.reference.id;
        Doctor doctor = Doctor.fromJson(data);
        return doctor;
      }).toList();
      return listTopRatedDoctor;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<Doctor>> searchDoctor(String doctorName) async {
    try {
      //print('doctor name : $doctorName');
      if (doctorName.isEmpty) return [];
      var doctorRef = await FirebaseFirestore.instance
          .collection('Doctors')
        /*   .where('doctorName',
                isGreaterThanOrEqualTo: doctorName,
                isLessThan: doctorName +'z',
               doctorName.substring(0, doctorName.length - 1) +
                    String.fromCharCode(
                        doctorName.codeUnitAt(doctorName.length - 1) + 1)
          )*/
          .get();
          List<Doctor> listDoctor = [];
          doctorRef.docs.forEach((element) {
            var data = element.data();
            data['doctorId'] = element.reference.id;
            Doctor doctor = Doctor.fromJson(data);
            if(doctor.doctorName?.toLowerCase().contains(doctorName.toLowerCase()) == true)
              listDoctor.add(doctor);
          });
     /* List<Doctor> listDoctor = doctorRef.docs.map((doc) {
        var data = doc.data();
        data['doctorId'] = doc.reference.id;
        Doctor doctor = Doctor.fromJson(data);
        return doctor;
      }).toList();*/
      listDoctor.removeWhere((element) => element.accountStatus != 'active');
      //print('data searchnya : $listDoctor');
      return listDoctor;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<String> getUserId(Doctor doctor) async {
    try {
      var user = await FirebaseFirestore.instance
          .collection('Users')
          .where('doctorId', isEqualTo: doctor.doctorId)
          .get();
      //print('doc element${user.docs.length}');
      if (user.docs.isEmpty) return '';
      return user.docs.elementAt(0).id;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
