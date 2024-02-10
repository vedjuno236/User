import 'package:flutter_final/app/model/departures_model.dart';
import 'package:flutter_final/app/model/passengers_model.dart';
import 'package:flutter_final/app/model/ticket_model.dart';


class BookingModel{
  final String bookingId;
  final Departures departures;
  final DateTime expiredTime;
  final String seat;
  final String status;
  final Ticket ticket;
  final DateTime bookDate;
  final Passenger passenger;

  BookingModel( {required this.bookingId,required this.departures, required this.expiredTime, required this.seat, required this.status, required this.ticket, required this.bookDate, required this.passenger});

}