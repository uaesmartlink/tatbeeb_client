class Appointment {
  Appointment(
      {this.orderId, this.status, this.currency, this.amount, this.timeSlotId});
  String? orderId;
  String? status;
  String? currency;
  double? amount;
  String? timeSlotId;
  static const String _orderId = 'orderId';
  static const String _status = 'status';
  static const String _currency = 'currency';
  static const String _amount = 'amount';
  static const String _timeSlotId = 'timeSlotId';
  factory Appointment.fromMap(Map<String, dynamic> map) {

    return Appointment(
        orderId: map[_orderId],
        status: map[_status],
        currency: map[_currency],
        amount: map[_amount],
        timeSlotId: map[_timeSlotId]);
  }
}
