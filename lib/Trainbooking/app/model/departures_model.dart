import 'buses_model.dart';
import 'routes_model.dart';


class Departures {
  String departureId;
  Routes routes;
  Buses buses;

  Departures({
    required this.departureId,
    required this.routes,
    required this.buses,
  });

}
