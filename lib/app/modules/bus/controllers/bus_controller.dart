import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_final/app/model/stations_model.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../model/bus_type_model.dart';
import '../../../model/buses_model.dart';

import '../../../model/departures_model.dart';
import '../../../model/routes_model.dart';
import '../../../model/ticket_model.dart';

class BusController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  BusType? busType;
  String departureStation = "ເລືອກສະຖານີ";
  String arrivalStation = "ເລືອກສະຖານີ";
  String departureStationId="",arrivalStationId="";
  DateTime selectedDate = DateTime.now();
  Departures? departure;
  Ticket? ticket;

  void setDeparture(Departures? departures){
    departure = departures;
    update();
  }

  void setTicket(Ticket? ticket){
    this.ticket = ticket;
    update();
  }

  void setSelectedDate(DateTime selectedDate){
    this.selectedDate = selectedDate;
    update();
  }

  void setDepartureStation(String departureStationId,String departureStation) {
    this.departureStationId = departureStationId;
    this.departureStation=departureStation;
    update();
  }

  void setArrivalStation(String arrivalStationId,String arrivalStation) {
    this.arrivalStationId=arrivalStationId;
    this.arrivalStation=arrivalStation;
    update();
  }

  @override
  void onInit() {
    getDeparture();
    super.onInit();
  }


  RxList<Departures> departureList = <Departures>[].obs;
  RxList<Departures> searchAvailableBusesList = <Departures>[].obs;

  Future<void> getDeparture() async {
    try {
      // Get departures for the selected date
      QuerySnapshot departureQuery = await FirebaseFirestore.instance.collection('Departures').get();

      List<Departures> _departureList = [];

      for (var departureDoc in departureQuery.docs) {
        var departureData = departureDoc.data() as Map<String, dynamic>;

        // Fetch related documents
        DocumentSnapshot routeDoc = await FirebaseFirestore.instance.collection('Routes').doc(departureData['route_id']).get();
        DocumentSnapshot busDoc = await FirebaseFirestore.instance.collection('Buses').doc(departureData['bus_id']).get();
        var busSnapshot = busDoc.data() as Map<String, dynamic>;
        DocumentSnapshot busTypeDoc = await FirebaseFirestore.instance.collection('BusType').doc(busSnapshot['bus_type_id']).get();

        var routeSnapshot = routeDoc.data() as Map<String, dynamic>;
        DocumentSnapshot departureStationDoc = await FirebaseFirestore.instance.collection('Stations').doc(routeSnapshot['departure_station_id']).get();
        DocumentSnapshot arrivalStationDoc = await FirebaseFirestore.instance.collection('Stations').doc(routeSnapshot['arrival_station_id']).get();

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

        for(var element in busSnapshot["ticket_id"].toList()){
          DocumentSnapshot ticketDoc = await FirebaseFirestore.instance.collection('Tickets').doc(element).get();

          ticketList.add(Ticket.fromSnapshot(ticketDoc));
        }

        Buses bus = Buses(
          busId: busDoc.id,
          busName: busSnapshot["name"],
          busType: BusType.fromSnapshot(busTypeDoc),
          capacity: busSnapshot["capacity"],
          capacityVIP: busSnapshot["capacity_vip"],
          tickets:ticketList
        );

        Departures departure = Departures(departureId: departureDoc.id, routes: route, buses: bus);
         _departureList.add(departure);

      }

      departureList.value = _departureList;
      update();
    } catch (e) {
      print('Error fetching available buses: $e');
    }
  }

  Future<void> getAvailableBusesOnDate() async {

     try {
      List<Departures> _departureList=[];
      if(DateFormat("yyyy-MM-dd").format(selectedDate) == DateFormat("yyyy-MM-dd").format(DateTime.now())){

        DateFormat timeFormat = DateFormat('HH:mm:ss');
        String nowTimeStr = timeFormat.format(DateTime.now()) ;

        _departureList = departureList.where((element) =>
        element.routes.departureStation.stationId == departureStationId &&
            element.routes.arrivalStation.stationId == arrivalStationId &&
        timeFormat.parse(timeFormat.format(element.routes.departureTime)).isAfter(timeFormat.parse(nowTimeStr))
        ).toList();

      }else {

        _departureList = departureList.where((element) =>
        element.routes.departureStation.stationId == departureStationId &&
            element.routes.arrivalStation.stationId == arrivalStationId).toList();

      }

      for(int i=0; i < _departureList.length; i++){
        // Calculate the start and end of the target date
        DateTime startDate = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
        DateTime endDate = startDate.add(const Duration(days: 1));

        QuerySnapshot capacityQuerySnapshot = await FirebaseFirestore.instance.collection('Booking').where('departure_id', isEqualTo: _departureList[i].departureId).where('book_date',isGreaterThanOrEqualTo: startDate).where('book_date',isLessThan: endDate).where("ticket_id",isEqualTo: _departureList[i].buses.tickets.first.ticketId).get();


        QuerySnapshot capacityVipQuerySnapshot = await FirebaseFirestore.instance.collection('Booking').where('departure_id', isEqualTo: _departureList[i].departureId).where('book_date',isGreaterThanOrEqualTo: startDate).where('book_date',isLessThan: endDate).where("ticket_id",isEqualTo: _departureList[i].buses.tickets.last.ticketId).get();

        int countCapacity = _departureList[i].buses.capacity <=0 ? 10000 :capacityQuerySnapshot.size;
        int countCapacityVip =_departureList[i].buses.capacityVIP <=0 ? 10000 : capacityVipQuerySnapshot.size;
        if(countCapacity >= _departureList[i].buses.capacity && countCapacityVip >= _departureList[i].buses.capacityVIP){
          _departureList.removeAt(i);
        }else if(countCapacity >= _departureList[i].buses.capacity){
          _departureList[i].buses.isCapacityAvailable = false;
        }else if(countCapacityVip >= _departureList[i].buses.capacityVIP){
          _departureList[i].buses.isCapacityVipAvailable = false;
        }
      }

      searchAvailableBusesList.value = _departureList;
      update();
    } catch (e) {
      print('Error fetching available buses: $e');
    }
  }


}
