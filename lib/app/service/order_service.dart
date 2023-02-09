import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hallo_doctor_client/app/models/order_model.dart';
import 'package:hallo_doctor_client/app/models/time_slot_model.dart';
import 'package:hallo_doctor_client/app/service/user_service.dart';

class OrderService {
  Future<Appointment> getSuccessOrder(TimeSlot timeSlot) async {
    try {
      var orderSnapshot = await FirebaseFirestore.instance
          .collection('Appointment')
          .where('timeSlotId', isEqualTo: timeSlot.timeSlotId)
          .where('status', isEqualTo: 'payment_success')
          .limit(1)
          .get();
      var data = orderSnapshot.docs.elementAt(0).data();
      data['orderId'] = orderSnapshot.docs.elementAt(0).reference.id;
      Appointment order = Appointment.fromMap(data);
      return order;
    } on FirebaseException catch (e) {
      return Future.error(e.message!);
    }
  }

  Future<Appointment> getOrder(TimeSlot timeSlot,String timeSlotId) async {
    try {
      print("ZZZ1");
      var orderData = await FirebaseFirestore.instance
          .collection('Appointment')
          .where('userId', isEqualTo: UserService().getUserId())
          .where('timeSlotId', isEqualTo: timeSlotId)
          .get();
      print("ZZZ2");

      //print('order length : ${orderData.docs.length}');
      var data = orderData.docs.elementAt(0).data();
      print("ZZZ3");

      data['orderId'] = orderData.docs.elementAt(0).reference.id;
      print("ZZZ4");
      data['amount'] = data['amount'].toDouble();
      print(data);
      Appointment order = Appointment.fromMap(data);
      print("ZZZ5");

      return order;
    } on Exception catch (e) {
      return Future.error(e.toString());
    }
  }

  Future confirmOrder(TimeSlot timeSlot,String timeSlotId) async {
    try {
      print("XXX1");
      var order = await getOrder(timeSlot,timeSlotId);
      print("XXX2");
      return setOrderToComplete(order);

    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<void> setOrderToComplete(Appointment order) async {
    await FirebaseFirestore.instance
        .collection("Appointment")
        .doc(order.orderId)
        .update({'status': 'success'});
  }
}
