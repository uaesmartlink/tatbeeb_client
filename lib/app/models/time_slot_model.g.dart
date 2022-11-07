// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_slot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeSlot _$TimeSlotFromJson(Map<String, dynamic> json) => TimeSlot(
      timeSlotId: json['timeSlotId'] as String?,
      timeSlot: TimeSlot._dateTimeFromJson(json['timeSlot'] as Timestamp?),
      duration: json['duration'] as int?,
      price: double.parse(json['price'].toString()),
      bookedAmount: double.parse((json['bookedAmount'])??0.0.toString()) ,
      bookedDuration: json['bookedDuration'] as int?,
      available: json['available'] as bool?,
      doctorid: json['doctorId'] as String?,
      doctor: json['doctor'] == null
          ? null
          : Doctor.fromJson(json['doctor'] as Map<String, dynamic>),
      purchaseTime:
          TimeSlot._dateTimeFromJson(json['purchaseTime'] as Timestamp?),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$TimeSlotToJson(TimeSlot instance) => <String, dynamic>{
      'timeSlotId': instance.timeSlotId,
      'timeSlot': TimeSlot._dateTimeToJson(instance.timeSlot),
      'duration': instance.duration,
      'price': instance.price,
      'bookedDuration': instance.bookedDuration,
      'bookedAmount': instance.bookedAmount,
      'available': instance.available,
      'doctorId': instance.doctorid,
      'doctor': TimeSlot.doctorToJson(instance.doctor),
      'purchaseTime': TimeSlot._dateTimeToJson(instance.purchaseTime),
      'status': instance.status,
    };
