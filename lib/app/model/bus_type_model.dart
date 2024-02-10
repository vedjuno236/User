import 'package:cloud_firestore/cloud_firestore.dart';

class BusType {
  String busTypeId;
  String busTypeName;


  BusType({
    required this.busTypeId,
    required this.busTypeName,
  });

  // Factory method to create a User instance from a DocumentSnapshot
  factory BusType.fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return BusType(
      busTypeId: snapshot.id,
      busTypeName: data['name'],
    );
  }

}
