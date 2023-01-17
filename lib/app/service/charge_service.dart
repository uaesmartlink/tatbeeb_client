import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/charge.dart';

class ChargeService {
  Future chargeBalance(Charge charge) async {
    /* var chargeSabed = await FirebaseFirestore.instance
        .collection('DoctorTimeslot')
        .add(charage);*/
    try {
      CollectionReference charges =
          FirebaseFirestore.instance.collection('Charges');
      String id = charge.chargeId.toString();
      charges.doc(id).set(
        {
          'chargeId': charge.chargeId,
          'userId': charge.userId,
          'currency': charge.currency,
          'createdAt': charge.createdAt,
          'amount': charge.amount,
          'status': charge.status,
        },
      );
      print('=====');
      print('success');
      print('=====');

    } catch (error) {
      print('=====');
      print(error);
      print('=====');

    }
  }
}
