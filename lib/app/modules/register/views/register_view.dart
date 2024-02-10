import 'dart:io';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/app/modules/register/controllers/register_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../service/firebase_firestore_service.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late DateTime datetime;
  late RegisterController registerController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseFirestoreService firebaseFirestoreService =
      FirebaseFirestoreService();
  File? imageFile, profileImage;

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

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      registerController.signInPhone(
          registerController.nameController.text +
              " " +
              registerController.surnameController.text,
          registerController.emailController.text,
          registerController.phoneNumberController.text,
          registerController.idCardController.text,
          registerController.dobDateTime,
          registerController.profileImage,
          registerController.imageFile,
          registerController.phoneCode);
    }
  }

  @override
  void initState() {
    registerController = RegisterController();

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
          'ລົງທະບຽນເຂົ້າໃຊ້ລະບົບ',
          style: TextStyle(
            color: Colors.white, // Change the color to your preferred color
            fontSize: 20.0, // Adjust the font size if needed
            fontWeight: FontWeight.bold, // Adjust the font weight if needed
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        // children: [
        child: Container(
          margin: const EdgeInsets.only(left: 0, top: 10, right: 0, bottom: 50),
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
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  registerController.profileImage == null
                      ? Center(
                          child: GestureDetector(
                            onTap: () {
                              getProfileImage(source: ImageSource.camera);
                            },
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.grey[200],
                              child: const Icon(
                                Icons.camera_alt,
                                size: 60,
                                color:
                                    Colors.grey, // Set your desired icon color
                              ),
                            ),
                          ),
                        )
                      : Center(
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                FileImage(registerController.profileImage!),
                          ),
                        ),
                  const Row(
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
                  // TextFormField(
                  //   controller: registerController.nameController,
                  //   decoration: const InputDecoration(
                  //       hintText: 'ກະລຸນາປ້ອນຊື່',
                  //       hintStyle: TextStyle(
                  //           fontSize: 20, fontWeight: FontWeight.w500)),
                  // ),
                  TextFormField(
                    controller: registerController.nameController,
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
                    controller: registerController.surnameController,
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
                                        registerController.setDobDateTime(date);
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
                    controller: registerController.dobController,
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
                    controller: registerController.emailController,
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
                    controller: registerController.phoneNumberController,
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
                                  setState(() {
                                    selectedCountry = value;
                                    registerController.phoneCode =
                                        selectedCountry.phoneCode;
                                  });
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
                      suffixIcon:
                          registerController.phoneNumberController.text.length >
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
                    controller: registerController.idCardController,
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
                    child: registerController.imageFile == null
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
                                image: FileImage(registerController.imageFile!),
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
                        "ຢືນຢັນ",
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
        registerController.imageFile = File(file!.path);
      });
    }
  }

  void getProfileImage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(
        source: source,
        maxWidth: 300,
        maxHeight: 300,
        imageQuality: 70 //0 - 100
        );

    if (file?.path != null) {
      setState(() {
        registerController.profileImage = File(file!.path);
      });
    }
  }
}
