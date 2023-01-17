// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'charge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Charge _$ChargeFromJson(Map<String, dynamic> json) => Charge(
      chargeId: json['chargeId'] as String?,
      userId: json['userId'] as String?,
      currency: json['currency'] as String?,
      createdAt: json['createdAt'] as DateTime?,
      amount: double.parse(json['amount'].toString()),
      status: json['status'] as String?,
    );

Map<String, dynamic> ChargeToJson(Charge instance) => <String, dynamic>{
      'chargeId': instance.chargeId,
      'userId': instance.userId,
      'currency': instance.currency,
      'createdAt': instance.createdAt,
      'amount': instance.amount,
      'status': instance.status,
    };
