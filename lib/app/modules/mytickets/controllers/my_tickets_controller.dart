import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_final/app/const/shared_pref_key.dart';
import 'package:flutter_final/app/model/booking_model.dart';
import 'package:flutter_final/app/model/departures_model.dart';
import 'package:flutter_final/app/model/passengers_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../model/bus_type_model.dart';
import '../../../model/buses_model.dart';
import '../../../model/routes_model.dart';
import '../../../model/stations_model.dart';
import '../../../model/ticket_model.dart';

class MyTicketsController extends GetxController {
  @override
  void onInit() {
    setCheckQR(false);
    super.onInit();
  }

  @override
  onClose() {
    setCheckQR(false);
    super.onClose();
  }

  RxList<BookingModel> bookingList = <BookingModel>[].obs;
  RxBool isLoading = false.obs;
  RxBool isCheckQR = false.obs;
  void updateBookingList(
      BookingModel bookingModel, String targetBookingId, String status) {
    // Example: Update the values of the BookingModel with bookingId '1'
    BookingModel updatedBooking = BookingModel(
        bookingId: bookingModel.bookingId,
        departures: bookingModel.departures,
        expiredTime: bookingModel.expiredTime,
        seat: bookingModel.seat,
        status: status,
        ticket: bookingModel.ticket,
        bookDate: bookingModel.bookDate,
        time: bookingModel.time,
        passenger: bookingModel.passenger);
    // Find the index of the item with the matching bookingId
    int index = bookingList
        .indexWhere((booking) => booking.bookingId == targetBookingId);
    // Update the item if found
    if (index != -1) {
      bookingList[index] = updatedBooking;
    }
    update();
  }

  void setCheckQR(bool isCheckQR) {
    this.isCheckQR.value = isCheckQR;
    update();
  }

  void setLoading(isLoading) {
    this.isLoading.value = isLoading;
    update();
  }

  Future<void> getMyListTicket() async {
    bookingList.clear();
    setLoading(true);

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      print("check uuidSharedPre:${prefs.getString(uuidKeySharePref)}");
      QuerySnapshot queryBooking = await FirebaseFirestore.instance
          .collection('Booking')
          .where("user_id", isEqualTo: prefs.getString(uuidKeySharePref))
          .get();

      print("check booking data:${queryBooking.docs.length}");
      for (var element in queryBooking.docs) {
        DocumentSnapshot departureDoc = await FirebaseFirestore.instance
            .collection('Departures')
            .doc(element['departure_id'])
            .get();

        // Fetch related documents
        DocumentSnapshot routeDoc = await FirebaseFirestore.instance
            .collection('Routes')
            .doc(departureDoc['route_id'])
            .get();
        DocumentSnapshot busDoc = await FirebaseFirestore.instance
            .collection('Buses')
            .doc(departureDoc['bus_id'])
            .get();
        var busSnapshot = busDoc.data() as Map<String, dynamic>;
        DocumentSnapshot busTypeDoc = await FirebaseFirestore.instance
            .collection('BusType')
            .doc(busSnapshot['bus_type_id'])
            .get();

        var routeSnapshot = routeDoc.data() as Map<String, dynamic>;
        DocumentSnapshot departureStationDoc = await FirebaseFirestore.instance
            .collection('Stations')
            .doc(routeSnapshot['departure_station_id'])
            .get();
        DocumentSnapshot arrivalStationDoc = await FirebaseFirestore.instance
            .collection('Stations')
            .doc(routeSnapshot['arrival_station_id'])
            .get();

        Stations departureStation = Stations(
          stationId: departureStationDoc.id,
          stationName: departureStationDoc["name"],
        );

        Stations arrivalStation = Stations(
          stationId: arrivalStationDoc.id,
          stationName: arrivalStationDoc["name"],
        );

        Routes route = Routes(
          routeId: routeDoc.id,
          arrivalStation: arrivalStation,
          arrivalTime: routeDoc["arrival_time"].toDate(),
          departureStation: departureStation,
          departureTime: routeDoc["departure_time"].toDate(),
        );

        List<Ticket> ticketList = [];
        for (var element in busSnapshot["ticket_id"].toList()) {
          DocumentSnapshot ticketDoc = await FirebaseFirestore.instance
              .collection('Tickets')
              .doc(element)
              .get();

          ticketList.add(Ticket.fromSnapshot(ticketDoc));
        }

        Buses bus = Buses(
            busId: busDoc.id,
            busName: busSnapshot["name"],
            busType: BusType.fromSnapshot(busTypeDoc),
            capacity: busSnapshot["capacity"],
            carnamber: busSnapshot["carnamber"],
            capacityVIP: busSnapshot["capacity_vip"],
            tickets: ticketList);

        DocumentSnapshot ticketDoc = await FirebaseFirestore.instance
            .collection('Tickets')
            .doc(element["ticket_id"])
            .get();
        Ticket ticket = Ticket.fromSnapshot(ticketDoc);

        Departures departure =
            Departures(departureId: departureDoc.id, routes: route, buses: bus);

        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('Passengers')
            .where(FieldPath.documentId, isEqualTo: element["passenger_id"])
            .get();

        Passenger passenger = Passenger.fromSnapshot(querySnapshot.docs.first);

        bookingList.add(BookingModel(
          bookingId: element.id,
          departures: departure,
          expiredTime: element["expired_time"].toDate(),
          seat: element["seat"],
          status: element["status"],
          ticket: ticket,
          bookDate: element["book_date"].toDate(),

          //
          time: element["time"].toDate(),
          //
          passenger: passenger,
        ));
      }

      print("bookingList:$bookingList");
      setLoading(false);
    } catch (e) {
      setLoading(false);
      print("get booking list error:$e");
    }
  }
}
