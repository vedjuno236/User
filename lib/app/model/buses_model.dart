import 'bus_type_model.dart';
import 'ticket_model.dart';


class Buses {
  String busId;
  String busName;
  String carnamber;
  BusType busType;
  int capacity;
  bool isCapacityAvailable;
  int capacityVIP;
  bool isCapacityVipAvailable;
  List<Ticket> tickets;

  Buses({
    required this.busId,
    required this.busType,
    required this.capacity,
    required this.carnamber,
    required this.busName,
    required this.capacityVIP,
    required this.tickets,
    this.isCapacityAvailable = true,
    this.isCapacityVipAvailable = true,
  });
}
