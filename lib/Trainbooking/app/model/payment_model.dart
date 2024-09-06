import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_final/app/model/booking_model.dart';
class PaymentModel {
  String paymentid;
  List<BookingModel> booking_id;
  String description;
  Timestamp pay_date;
  String payment_method;
  String image_payment;
  String total;
  String user_id;

  PaymentModel({
    required this.paymentid,
    required this.booking_id,
    required this.description,
    required this.pay_date,
    required this.payment_method,
    required this.image_payment,
    required this.total,
    required this.user_id,
  });


   Map<String, dynamic> toMap() {
  return {
    'paymentid': this.paymentid,
    'booking_id': this.booking_id.map((booking) => booking.toString()).toList(),
    'description': this.description,
    'pay_date': this.pay_date,
    'payment_method': this.payment_method,
    'image_payment': this.image_payment,
    'total': this.total,
    'user_id': this.user_id,
  };
}

   }
  
 

