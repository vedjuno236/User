import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/app/model/passengers_model.dart';
import 'package:flutter_final/app/modules/book_tickets/controller/book_ticket_controller.dart';
import 'package:flutter_final/app/modules/login/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../service/firebase_firestore_service.dart';

class AddAContact extends StatefulWidget {
  const AddAContact({Key? key}) : super(key: key);

  @override
  _AddAContactState createState() => _AddAContactState();
}

class _AddAContactState extends State<AddAContact> {
  late DateTime datetime;
  late BookTicketController bookTicketController;
  late LoginController loginController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseFirestoreService firebaseFirestoreService =
      FirebaseFirestoreService();

  Country selectedCountry = Country(
    phoneCode: "856",
    countryCode: "LAOS",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "Laos",
    example: "Laos",
    displayName: "Laos",
    displayNameNoCountryCode: "LAOS",
    e164Key: "",
  );

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        //upload image
        String imageUrl = await firebaseFirestoreService.uploadImage(
            '${bookTicketController.imageFile?.path}',
            '${bookTicketController.imageFile?.path.split('/').last}');
        //add Data To Cloud FireStore

        DocumentReference documentReference =
            await _firestore.collection("Passengers").add({
          "user_id": '',
          "id_card_image_url": imageUrl,
          "name": bookTicketController.nameController.text +
              " " +
              bookTicketController.surnameController.text,
          "phone_number": selectedCountry.phoneCode +
              bookTicketController.phoneNumberController.text,
          "dob": Timestamp.fromDate(datetime),
          "id_card": int.tryParse(bookTicketController.idCardController.text),
          "passenger_relation": [],
          "email": bookTicketController.emailController.text
        });

        await _firestore
            .collection("Passengers")
            .doc(loginController.passenger?.passengerId)
            .update({
          "passenger_relation": FieldValue.arrayUnion([documentReference.id])
        });

        loginController.passengerList
            .add(Passenger.fromSnapshot(await documentReference.get()));

        QuerySnapshot passengerQuery = await FirebaseFirestore.instance
            .collection('Passengers')
            .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
            .get();
        final passenger = Passenger.fromSnapshot(passengerQuery.docs.first);
        loginController.setPassenger(passenger);

        bookTicketController.clearFormData();
        Navigator.of(context).pop();
      } catch (e) {
        print("Add Contact Failed!!! :$e");
      }
    }
  }

  @override
  void initState() {
    bookTicketController = BookTicketController();
    loginController = Get.find<LoginController>();

    datetime = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: const Text(
          'ເພີ່ມຜູ້ຕິດຕໍ່',
          style: TextStyle(
              color: Colors.white), // Specify the color using TextStyle
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        // children: [
        child: Container(
          margin: const EdgeInsets.only(left: 0, top: 10, right: 0, bottom: 50),
          // height: 1100,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: <Color>[
              Colors.white,
              Colors.white,
            ]),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: const Offset(
                  5.0,
                  5.0,
                ),
                blurRadius: 10.0,
                spreadRadius: 2.0,
              ), //BoxShadow
              BoxShadow(
                color: Colors.white,
                offset: const Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ), //BoxShadow
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'ຊື່ ',
                        style: TextStyle(fontSize: 19),
                      ),
                      Text(
                        "*",
                        style: TextStyle(fontSize: 20, color: Colors.red),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: bookTicketController.nameController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(5.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(5.5),
                      ),
                      prefixIcon: Icon(Icons.person, color: Colors.blue),
                      hintText: "ກະລຸນາປ້ອນຊື່",
                      hintStyle: GoogleFonts.notoSansLao(
                        // Use camelCase and avoid spaces
                        color: Colors.blue,
                        // fontSize: 12
                        // Other text style properties can be added here
                      ),
                      filled: true,
                      fillColor: Colors.blue[50],
                    ),
                  ),
                  SizedBox(height: 5),
                  const Row(
                    children: [
                      Text(
                        'ນາມສະກຸນ ',
                        style: TextStyle(fontSize: 19),
                      ),
                      Text(
                        "*",
                        style: TextStyle(fontSize: 20, color: Colors.red),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: bookTicketController.surnameController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(5.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(5.5),
                      ),
                      prefixIcon: Icon(Icons.person, color: Colors.blue),
                      hintText: "ກະລຸນາປ້ອນນາມສະກຸນ",
                      // hintStyle: TextStyle(color: Colors.blue),
                      hintStyle: GoogleFonts.notoSansLao(
                        // Use camelCase and avoid spaces
                        color: Colors.blue,
                        // fontSize: 12
                        // Other text style properties can be added here
                      ),
                      filled: true,
                      fillColor: Colors.blue[50],
                    ),
                  ),
                  SizedBox(height: 5),

                  const Row(
                    children: [
                      Text(
                        'ວັນເດືອນປີເກີດ ',
                        style: TextStyle(fontSize: 19),
                      ),
                      Text(
                        "*",
                        style: TextStyle(fontSize: 20, color: Colors.red),
                      ),
                    ],
                  ),
                  TextField(
                    readOnly: true, // Set to true to enable onTap functionality
                    onTap: () {
                      // Action to perform when the TextField is tapped
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('ຢືນຢັນ'),
                                ),
                                Expanded(
                                  child: CupertinoDatePicker(
                                    initialDateTime: datetime,
                                    mode: CupertinoDatePickerMode.date,
                                    minimumDate: DateTime(2000),
                                    maximumDate: DateTime.now().add(
                                      const Duration(days: 2 * 365),
                                    ),
                                    onDateTimeChanged: (date) {
                                      setState(() {
                                        datetime = date;
                                        // registerController.setDobDateTime(date);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    controller: bookTicketController.dobController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(5.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(5.5),
                      ),
                      prefixIcon: Icon(Icons.data_array, color: Colors.blue),
                      hintText: datetime
                          .toIso8601String()
                          .split('T')[0], // Extract the date part
                      hintStyle: GoogleFonts.notoSansLao(
                        color: Colors.blue,
                      ),
                      filled: true,
                      fillColor: Colors.blue[50],
                    ),
                  ),

                  // GestureDetector(
                  //   onTap: () {
                  //     showCupertinoModalPopup(
                  //         context: context,
                  //         builder: (context) {
                  //           return Container(
                  //             height: MediaQuery.of(context).size.height * 0.4,
                  //             color: Colors.white,
                  //             child: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.end,
                  //               children: [
                  //                 TextButton(
                  //                   onPressed: () {
                  //                     Navigator.pop(context);
                  //                   },
                  //                   child: Text('ຢືນຢັນ'),
                  //                 ),
                  //                 Expanded(
                  //                   child: CupertinoDatePicker(
                  //                     initialDateTime: datetime,
                  //                     mode: CupertinoDatePickerMode.date,
                  //                     minimumDate: DateTime(2000),
                  //                     maximumDate: DateTime.now().add(
                  //                       const Duration(days: 2 * 365),
                  //                     ),
                  //                     onDateTimeChanged: (date) {
                  //                       setState(() {
                  //                         datetime = date;
                  //                       });
                  //                     },
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           );
                  //         });
                  //   },
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Row(
                  //         children: [
                  //           Text(
                  //             'ວັນເດືອນປີເກີດ ',
                  //             style: TextStyle(fontSize: 19),
                  //           ),
                  //           Text(
                  //             "*",
                  //             style: TextStyle(fontSize: 20, color: Colors.red),
                  //           ),
                  //         ],
                  //       ),
                  //       TextFormField(
                  //         controller: bookTicketController.dobController,
                  //         decoration: InputDecoration(
                  //           enabledBorder: OutlineInputBorder(
                  //             borderSide: BorderSide(color: Colors.transparent),
                  //             borderRadius: BorderRadius.circular(5.5),
                  //           ),
                  //           focusedBorder: OutlineInputBorder(
                  //             borderSide: BorderSide(color: Colors.transparent),
                  //             borderRadius: BorderRadius.circular(5.5),
                  //           ),
                  //           prefixIcon:
                  //               Icon(Icons.data_array, color: Colors.blue),
                  //           hintText: datetime
                  //               .toIso8601String()
                  //               .split('T')[0], // Extract the date part
                  //           hintStyle: GoogleFonts.notoSansLao(
                  //             // Use camelCase and avoid spaces
                  //             color: Colors.blue,
                  //             // fontSize: 12
                  //             // Other text style properties can be added here
                  //           ),
                  //           filled: true,
                  //           fillColor: Colors.blue[50],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: 5),
                  const Row(
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(fontSize: 19),
                      ),
                      Text(
                        "*",
                        style: TextStyle(fontSize: 20, color: Colors.red),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: bookTicketController.emailController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(5.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(5.5),
                      ),
                      prefixIcon: Icon(Icons.email, color: Colors.blue),
                      hintText: "ກະລຸນາປ້ອນອີເມວ",
                      // hintStyle: TextStyle(color: Colors.blue),
                      hintStyle: GoogleFonts.notoSansLao(
                        // Use camelCase and avoid spaces
                        color: Colors.blue,
                        // fontSize: 12
                        // Other text style properties can be added here
                      ),
                      filled: true,
                      fillColor: Colors.blue[50],
                    ),
                  ),
                  SizedBox(height: 5),
                  const Row(
                    children: [
                      Text(
                        'ເບີໂທຕິດຕໍ່ ',
                        style: TextStyle(fontSize: 19),
                      ),
                      Text(
                        "*",
                        style: TextStyle(fontSize: 20, color: Colors.red),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: bookTicketController.phoneNumberController,
                    cursorColor: Colors.purple,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    // onChanged: (value) {
                    //   setState(() {
                    //     phoneController.text = value;
                    //   });
                    // },
                    decoration: InputDecoration(
                      hintText: "20 XXXXXXXX",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.grey.shade600,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      prefixIcon: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            showCountryPicker(
                                context: context,
                                countryListTheme: const CountryListThemeData(
                                  bottomSheetHeight: 550,
                                ),
                                onSelect: (value) {
                                  // setState(() {
                                  //   selectedCountry = value;
                                  // });
                                });
                          },
                          child: Text(
                            "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      suffixIcon: bookTicketController
                                  .phoneNumberController.text.length >
                              9
                          ? Container(
                              height: 30,
                              width: 30,
                              margin: const EdgeInsets.all(10.0),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                              ),
                              child: const Icon(
                                Icons.done,
                                color: Colors.white,
                                size: 20,
                              ),
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Row(
                    children: [
                      Text(
                        'ປະເພດເອກະສານຢັງຢືນ ',
                        style: TextStyle(fontSize: 19),
                      ),
                      Text(
                        "*",
                        style: TextStyle(fontSize: 20, color: Colors.red),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: bookTicketController.idCardController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(5.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(5.5),
                      ),
                      prefixIcon: Icon(Icons.usb_rounded, color: Colors.blue),
                      hintText: "ID ບັດປະຈໍາຕົວ",
                      // hintStyle: TextStyle(color: Colors.blue),
                      hintStyle: GoogleFonts.notoSansLao(
                        // Use camelCase and avoid spaces
                        color: Colors.blue,
                        // fontSize: 12
                        // Other text style properties can be added here
                      ),
                      filled: true,
                      fillColor: Colors.blue[50],
                    ),
                  ),
                  const SizedBox(height: 10),

                  GestureDetector(
                    onTap: () async {
                      getImage(source: ImageSource.camera);
                    },
                    child: bookTicketController.imageFile == null
                        ? Container(
                            // width: 310,
                            width: MediaQuery.of(context).size.width,
                            height: 440,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(width: 1, color: Colors.redAccent),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/id-card.png'),
                                GestureDetector(
                                  onTap: () async {
                                    getImage(source: ImageSource.camera);
                                  },
                                  child: const Text(
                                    'ກົດເພື່ອອັບໂຫລດຮູບພາບເອກະສານ',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            width: MediaQuery.of(context).size.width,
                            height: 440,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                image:
                                    FileImage(bookTicketController.imageFile!),
                                fit: BoxFit.cover,
                              ),
                              border:
                                  Border.all(width: 1, color: Colors.redAccent),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                getImage(source: ImageSource.camera);
                              },
                              child: const Text(
                                '',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                  ),

                  // bookTicketController.imageFile == null
                  //     ? Container(
                  //         width: MediaQuery.of(context).size.width,
                  //         height: 700,
                  //         alignment: Alignment.center,
                  //         decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           border: Border.all(width: 8, color: Colors.black12),
                  //           borderRadius: BorderRadius.circular(12.0),
                  //         ),
                  //         child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             Image.asset('assets/images/card.png'),
                  //             GestureDetector(
                  //               onTap: () async {
                  //                 getImage(source: ImageSource.camera);
                  //               },
                  //               child: const Text('ກົດເພື່ອອັບໂຫລດຮູບພາບ',
                  //                   style: TextStyle(
                  //                       fontSize: 18,
                  //                       fontWeight: FontWeight.bold)),
                  //             ),
                  //           ],
                  //         ),
                  //       )
                  //     : Container(
                  //         width: MediaQuery.of(context).size.width,
                  //         height: 540,
                  //         alignment: Alignment.center,
                  //         decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           image: DecorationImage(
                  //               image:
                  //                   FileImage(bookTicketController.imageFile!),
                  //               fit: BoxFit.cover),
                  //           border: Border.all(width: 8, color: Colors.black),
                  //           borderRadius: BorderRadius.circular(12.0),
                  //         ),
                  //       ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      _submitForm(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: <Color>[
                            Colors.redAccent,
                            Colors.orangeAccent,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: const Text(
                        "ສໍາເລັດ",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void getImage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(
        source: source,
        maxWidth: 300,
        maxHeight: 300,
        imageQuality: 70 //0 - 100
        );

    if (file?.path != null) {
      setState(() {
        bookTicketController.imageFile = File(file!.path);
      });
    }
  }
}
