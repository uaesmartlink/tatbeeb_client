import 'package:cloud_functions/cloud_functions.dart';

class PaymentService {
  /*
  Future<String> getClientSecret(String timeSlotId, String uid) async {
    try {
      var callable =FirebaseFunctions.instance.httpsCallable('purchaseTimeslot');
      final results = await callable({'timeSlotId': timeSlotId, 'userId': uid});
      var clientSecret = results.data;
      return clientSecret;
    } catch (e) {
      //print(e.toString());
      return Future.error(e.toString());
    }
  }*/
  Future<void> makePayment(String timeSlotId, String uid ,double amount,int duration) async {
    try {
      var callable = FirebaseFunctions.instance.httpsCallable('purchaseTimeslot');
      //final results =
      await callable({'timeSlotId': timeSlotId, 'userId': uid, 'amount':amount,'duration':duration});

      //var clientSecret = results.data;
      //return clientSecret;
    } catch (e) {
      //print(e.toString());
      return Future.error(e.toString());
    }
  }

  Future<String> getSecret(double amount, String uid) async {
    try {
      var callable = FirebaseFunctions.instance.httpsCallable('chargeBalance');
      final results = await callable({'amount': amount, 'userId': uid});
      var clientSecret = results.data;
      return clientSecret;
    } catch (e) {
      //print(e.toString());
      return Future.error(e.toString());
    }
  }
}
