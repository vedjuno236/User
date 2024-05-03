import 'package:cloud_firestore/cloud_firestore.dart';

class Passenger {
  String passengerId;
  String username;
  String userId;
  String idCard;
  DateTime dob;
  String email;
  String phoneNumber;
  // String gender;
  List<dynamic> passengerRelation;

  Passenger({
    required this.passengerId,
    required this.username,
    required this.userId,
    // required this.gender,
    required this.idCard,
    required this.dob,
    required this.email,
    required this.phoneNumber,
    required this.passengerRelation,
  });

  // Factory method to create a User instance from a DocumentSnapshot
  factory Passenger.fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return Passenger(
      passengerId: snapshot.id,
      username: data['name'],
      userId: data['user_id'],
      idCard: data['id_card'].toString(),
      dob: data['dob'].toDate(),
      email: data['email'],
      // gender: data['gender'],
      passengerRelation: data['passenger_relation'].toList(),
      phoneNumber: data['phone_number'].toString(),
    );
  }

  String isAdult() {
    // Calculate age based on the difference between the current date and the date of birth
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - dob.year;

    // Check if the birthday has occurred this year
    if (currentDate.month < dob.month ||
        (currentDate.month == dob.month && currentDate.day < dob.day)) {
      age--;
    }

    // Check if the passenger is at least 15 years old
    return age >= 18 ? "ຜູ້ໃຫຍ່" : "ເດັກນ້ອຍ";
  }
}
