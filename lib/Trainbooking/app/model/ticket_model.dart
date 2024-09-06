import 'package:cloud_firestore/cloud_firestore.dart';

class Ticket {
  String ticketId;
  String ticketName;
  int price;
  int bookingPrice;

  Ticket(
      {required this.ticketId,
      required this.ticketName,
      required this.price,
      required this.bookingPrice});

  factory Ticket.fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return Ticket(
      ticketId: snapshot.id,
      ticketName: data['name'],
       price: data['price'],
        bookingPrice:data['booking_price']
    );
  }

}
