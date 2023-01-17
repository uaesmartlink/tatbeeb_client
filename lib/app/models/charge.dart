import 'doctor_category_model.dart';

// class Doctor {
//   Doctor(
//       {this.doctorId,
//       this.doctorName,
//       this.doctorPicture,
//       this.doctorPrice,
//       this.doctorShortBiography,
//       this.doctorCategory,
//       this.doctorHospital,
//       this.accountStatus});
//   static const String _doctorId = 'doctorId';
//   static const String _doctorName = 'doctorName';
//   static const String _doctorPicture = 'doctorPicture';
//   static const String _doctorPrice = 'doctorBasePrice';
//   static const String _doctorShortBiography = 'doctorBiography';
//   static const String _doctorCategory = 'doctorCategory';
//   static const String _doctorHospital = 'doctorHospital';
//   static const String _accountStatus = 'accountStatus';
//   String? doctorId;
//   String? doctorName;
//   String? doctorPicture;
//   int? doctorPrice;
//   String? doctorShortBiography;
//   DoctorCategory? doctorCategory;
//   String? doctorHospital;
//   String? accountStatus;

//   factory Doctor.fromJson(Map<String, dynamic> data) {
//     return Doctor(
//         doctorId: data[_doctorId],
//         doctorName: data[_doctorName],
//         doctorPicture: data[_doctorPicture],
//         doctorPrice: data[_doctorPrice],
//         doctorShortBiography: data[_doctorShortBiography],
//         doctorCategory: data[_doctorCategory] != null
//             ? DoctorCategory.fromJson(data[_doctorCategory])
//             : null,
//         doctorHospital: data[_doctorHospital],
//         accountStatus: data[_accountStatus]);
//   }
//    Map<String, dynamic> toJson() => {
//         _doctorId: doctorId,
//         _doctorName: doctorName,
//         _doctorPicture: doctorPicture,
//         _doctorPrice: doctorPrice,
//         _doctorShortBiography: doctorShortBiography,_doctorCategory: doctorCategory
//       };
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'charge.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class Charge {
  Charge({
    this.id,
    this.chargeId,
    this.userId,
    this.currency,
    this.createdAt,
    this.amount,
    this.status,

  });

  String? id;
  @JsonKey(name: 'chargeId')
  String? chargeId;
  @JsonKey(name: 'currency')
  String? currency;
  @JsonKey(name: 'createdAt')
  DateTime? createdAt;
  @JsonKey(name: 'amount')
  double? amount;
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'userId')
  String? userId;

  factory Charge.fromJson(Map<String, dynamic> json) => _$ChargeFromJson(json);

  Map<String, dynamic> toJson() => ChargeToJson(this);

  factory Charge.fromFirestore(DocumentSnapshot doc) =>
      Charge.fromJson(doc.data()! as Map<String, dynamic>)..id = doc.id;

}
