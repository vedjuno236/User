import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/app/model/passengers_model.dart';
import 'package:flutter_final/app/modules/login/views/login_view.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../const/shared_pref_key.dart';
import '../../home/views/home_view.dart';

const String loggedInFlagKey = 'isLoggedIn';

class LoginController extends GetxController {
  Timer? _timer;
  int remainingSeconds = 1;
  final time = 'ຂໍລະຫັດ OTP'.obs;
  // final RxBool tapOnTextField = false.obs;
  bool isRunning = false;
  bool isTapOnTextField = false;
  RxString isLogin = "login_page".obs;
  var checkC = false.obs;
  TextEditingController phoneC = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  String smsCode = 'xxxx', phoneCode = '';
  String verificationId = '';
  bool onEditing = true;
  Passenger? passenger;
  List<Passenger> passengerList = [];

  Map<String, bool> checkedPassenger = {};
  void setCheckedPassengerRelation(String key, bool value) {
    checkedPassenger[key] = value;
    update();
  }

  void setPassenger(Passenger passenger) {
    this.passenger = passenger;

    update();
  }

  void setSmsCode(String smsCode) {
    this.smsCode = smsCode;
    update();
  }

  void setPhoneCode(String phoneCode) {
    this.phoneCode = phoneCode;
    update();
  }

  void setOnEditOTP(bool onEdit) {
    onEditing = onEdit;

    update();
  }

  @override
  void onInit() {
    getPassengerList();
    super.onInit();
  }

  @override
  void onClose() {
    phoneC.dispose();
    // if (_timer != null) {
    //   _timer!.cancel();
    // }

    super.onClose();
  }

  @override
  void onReady() {
    _startTimer(60);
    super.onReady();
  }

  void _startTimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainingSeconds = seconds;
    _timer = Timer.periodic(duration, (Timer timer) {
      if (remainingSeconds == 0) {
        timer.cancel();
      } else {
        int minutes = remainingSeconds ~/ 60;
        int seconds = (remainingSeconds % 60);
        time.value = minutes.toString().padLeft(2, "0") +
            ":" +
            seconds.toString().padLeft(2, "0");
        remainingSeconds--;
        // print('NO');
      }
    });
  }

  void setTapOnTextField(bool value) {
    isTapOnTextField = value;
    if (value) {
      if (_timer != null && !_timer!.isActive) {
        _startTimer(remainingSeconds);
      }
    }
  }

  Future<void> signInPhone(BuildContext context) async {
    if (phoneC.text.length == 10) {
      try {
        await auth.verifyPhoneNumber(
          timeout: const Duration(seconds: 60),
          phoneNumber: phoneCode.isEmpty
              ? '+856${phoneC.text}'
              : '$phoneCode${phoneC.text}',
          verificationCompleted: (PhoneAuthCredential credential) async {
            // ANDROID ONLY!
            // Sign the user in (or link) with the auto-generated credential
            await auth.signInWithCredential(credential);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeView()),
            );
          },
          verificationFailed: (FirebaseAuthException e) {
            if (e.code == 'invalid-phone-number') {
              print('The provided phone number is not valid.');
            }

            // Handle other errors
          },
          codeSent: (String verificationId, int? resendToken) async {
            // Update the UI - wait for the user to enter the SMS code

            this.verificationId = verificationId;
            update();
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
      } catch (e) {
        print("Error sign in phone : $e");
      }
    }
  }

  Future<void> signInAuthCredential(BuildContext context) async {
    print("SIAC check");
    if (verificationId.isNotEmpty && smsCode.isNotEmpty) {
      print("SIAC2 check");
      try {
        PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode);
        // Sign the user in (or link) with the credential
        final UserCredential credential =
            await auth.signInWithCredential(phoneAuthCredential);

        final idToken = await credential.user!.getIdToken();
        final uuid = await credential.user!.uid;

        // print("ID Token {$idToken}");
        // Retrieve the user ID from shared preferences
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        String? storedUserId = prefs.getString(uuidKeySharePref);
        print("storedUserId:${prefs.getString(uuidKeySharePref)}");

        QuerySnapshot passengerQuery = await FirebaseFirestore.instance
            .collection('Passengers')
            .where("user_id", isEqualTo: storedUserId ?? uuid)
            .get();

        print("Passenger Query Result: ${passengerQuery.docs}");
        if (passengerQuery.docs.isNotEmpty) {
          // Create a Passenger object using the first document in the query result
          passenger = Passenger.fromSnapshot(passengerQuery.docs.first);

          prefs.setString(firebaseTokenKeySharePref, idToken ?? '');
          prefs.setString(uuidKeySharePref, credential.user?.uid ?? '');

          // Navigate to HomeView
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeView()),
          );
        } else {
          print("No User Login Data");
        }
      } catch (e) {
        print("Error signInAuthCredential : $e");
      }
    }
  }

  Future<void> getUserLogged() async {
    // Retrieve the user ID from shared preferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUserId = prefs.getString(uuidKeySharePref);
    print("storedUserId:${prefs.getString(uuidKeySharePref)}");
    print("storedUserId:$storedUserId");
    if (storedUserId != null) {
      QuerySnapshot passengerQuery = await FirebaseFirestore.instance
          .collection('Passengers')
          .where("user_id", isEqualTo: storedUserId)
          .get();

      if (passengerQuery.docs.isNotEmpty) {
        // Create a Passenger object using the first document in the query result
        passenger = Passenger.fromSnapshot(passengerQuery.docs.first);
      }
    }
  }

  Future<void> checkLoggedIn() async {
    isLogin.value = "loading_page";
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? idToken = prefs.getString(firebaseTokenKeySharePref);
      // final String? uid = prefs.getString(uuidKeySharePref);
      // final bool isLoggedIn = prefs.getBool(loggedInFlagKey) ?? false;

      // if (idToken != null && uid != null && isLoggedIn) {
      //   // User is already logged in
      //   // You can navigate to the HomeView or perform any other actions
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(builder: (context) => HomeView()),
      //   );
      // }

      if (idToken?.isNotEmpty == true) {
        isLogin.value = "home_page";

        // Get.offAll(() => HomeView());

        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => HomeView()),
        // );
      } else {
        isLogin.value = "login_page";
      }

      // if (idToken != null && idToken.isNotEmpty) {
      //   isLogin.value = true;
      //   Get.offAll(() => HomeView());
      // } else {
      //   isLogin.value = false;
      // }
      print("check token :$idToken | ${isLogin.value}");
    } catch (e) {
      print("Error checking login status: $e");
      isLogin.value = "login_page";
    }
  }

  Future<void> getPassengerList() async {
    try {
      QuerySnapshot passengerQuery =
          await FirebaseFirestore.instance.collection('Passengers').get();
      for (final element in passengerQuery.docs) {
        passengerList.add(Passenger.fromSnapshot(element));
      }
      uuidKeySharePref = passenger?.userId ?? '';
      firebaseTokenKeySharePref = passenger?.userId ?? '';

      print("PassengerList:${passengerList.length}");
    } catch (e) {
      print("error getPassengerList:$e");
    }
  }

  void setUserId(String userId) {
    phoneC.text = userId;
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(firebaseTokenKeySharePref, '');
    prefs.setString(uuidKeySharePref, '');

    Get.offAll(() => LoginView());
  }

//   Future<Passenger?> _getPassengerFromFirestore(String userId) async {
//     DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
//         .instance
//         .collection('Passengers')
//         .doc(userId)
//         .get();

//     if (snapshot.exists) {
//       return Passenger.fromSnapshot(snapshot);
//     } else {
//       return null;
//     }
//   }
}
