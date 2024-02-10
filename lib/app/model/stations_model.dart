import 'package:cloud_firestore/cloud_firestore.dart';

class Stations {
  String stationId;
  String stationName;


  Stations({
    required this.stationId,
    required this.stationName,
  });

  // Factory method to create a User instance from a DocumentSnapshot
  factory Stations.fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return Stations(
      stationId: snapshot.id,
      stationName: data['name'],
    );
  }


}
