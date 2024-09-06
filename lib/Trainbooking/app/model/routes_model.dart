
import 'package:flutter_final/app/model/stations_model.dart';

class Routes {
  String routeId;
  DateTime arrivalTime;
  DateTime departureTime;
  Stations departureStation;
  Stations arrivalStation;

  Routes({
    required this.routeId,
    required this.arrivalTime,
    required this.departureTime,
    required this.departureStation,
    required this.arrivalStation,
  });
}
