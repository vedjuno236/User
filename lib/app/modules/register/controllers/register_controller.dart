import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/app/model/passengers_model.dart';
import 'package:flutter_final/app/modules/register/views/otp_register_view.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../const/shared_pref_key.dart';
import '../../../service/firebase_firestore_service.dart';
import '../../home/views/home_view.dart';
import '../../login/controllers/login_controller.dart';

class RegisterController extends GetxController {
  var checkC = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  String smsCode = 'xxxx', phoneCode = '';
  String verificationId = '';
  bool onEditing = true;
  Passenger? passenger;
  Map<String, bool> checkedPassenger = {};

  File? imageFile,profileImage;
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController idCardController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  DateTime dobDateTime = DateTime.now();

  final FirebaseFirestoreService firebaseFirestoreService =
  FirebaseFirestoreService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final loginController = Get.find<LoginController>();

  void clearFormData() {
    nameController.clear();
    surnameController.clear();
    phoneNumberController.clear();
    dobController.clear();
    idCardController.clear();
    imageFile = null;
    update();
  }

  void setVerificationId(String verificationId) {
    this.verificationId = verificationId;
    update();
  }

  void setDobDateTime(DateTime dob) {
    dobDateTime = dob;
    update();
  }

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

  Future<void> signInPhone(String fullName,String email,String phoneNumber,String idCard,DateTime dob,File? profile,File? idCardImage,String phoneCode) async {

    if (phoneNumberController.text.length == 10) {
      try {
        await auth.verifyPhoneNumber(
          timeout: const Duration(seconds: 120),
          phoneNumber: phoneCode.isEmpty
              ? '+856${phoneNumberController.text}'
              : '$phoneCode${phoneNumberController.text}',
          verificationCompleted: (PhoneAuthCredential credential) async {
            // ANDROID ONLY!

            // Sign the user in (or link) with the auto-generated credential
            await auth.signInWithCredential(credential);


            Get.to(()=>HomeView());
          },
          verificationFailed: (FirebaseAuthException e) {
            if (e.code == 'invalid-phone-number') {
              print('The provided phone number is not valid.');
            }

            // Handle other errors
          },
          codeSent: (String verificationId, int? resendToken) async {
            // Update the UI - wait for the user to enter the SMS code

            Get.to(()=>OtpRegisterView(verificationId: verificationId,fullName: fullName,email: email,dob: dob,idCard: idCard,phoneNumber: phoneNumber,profile: profile,idCardImage: idCardImage,phoneCode:phoneCode));
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
      } catch (e) {
        print("Error sign in phone : $e");
      }
    }
  }

  Future<void> signInAuthCredential( String verificationId,String fullName,String email,String phoneNumber,String idCard,DateTime dob,File? profile,File? idCardImage,String phoneCode) async {
    if (verificationId.isNotEmpty && smsCode.isNotEmpty) {
      try {
        PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode);
        // Sign the user in (or link) with the credential
        final UserCredential credential =
            await auth.signInWithCredential(phoneAuthCredential);
        final idToken = await credential.user!.getIdToken();

        bool isSubmit = await _submitForm(credential.user?.uid ?? '',fullName,email,phoneNumber,idCard,dob,profile,idCardImage,phoneCode);

        if (isSubmit == true) {
          // Obtain shared preferences.
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString(firebaseTokenKeySharePref, idToken ?? '');
          prefs.setString(uuidKeySharePref, credential.user?.uid ?? '');
          Get.to(()=>HomeView());
          clearFormData();
        }
      } catch (e) {
        print("Error signInAuthCredential : $e");
      }
    }
  }

  Future<bool> _submitForm(String userId,String fullName,String email,String phoneNumber,String idCard,DateTime dob,File? profile,File? idCardImage,String phoneCode) async {
    try {


      //upload image
      String imageUrl = await firebaseFirestoreService.uploadImage(
          '${idCardImage?.path}', '${idCardImage?.path.split('/').last}');

      //upload image
      String profileImageUrl = await firebaseFirestoreService.uploadImage(
          '${profile?.path}', '${profile?.path.split('/').last}');
      //add Data To Cloud FireStore

      DocumentReference documentReference =
          await _firestore.collection("Passengers").add({
        "user_id": userId,
        "id_card_image_url": imageUrl,
        "name": fullName,
        "phone_number": phoneCode + phoneNumber,
        "dob": Timestamp.fromDate(dob),
        "id_card": int.tryParse(idCard),
        "passenger_relation": [],
        "email": email,
        "profile_image_url": profileImageUrl
      });

      loginController.passengerList
          .add(Passenger.fromSnapshot(await documentReference.get()));

      QuerySnapshot passengerQuery = await FirebaseFirestore.instance
          .collection('Passengers')
          .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .get();
      final passenger = Passenger.fromSnapshot(passengerQuery.docs.first);
      loginController.setPassenger(passenger);

      return true;
    } catch (e) {
      print("Add User Failed!!! :$e");
      return false;
    }
  }
}
