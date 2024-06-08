import 'dart:io';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/app/modules/register/controllers/register_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/quickalert.dart';
import '../../../service/firebase_firestore_service.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  int _value = 1;
  late DateTime datetime;
  //
  // DateTime seletedatetime = DateTime.now();
  //
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
          // registerController.genderController,
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

  Uint8List? _image;
  File? selectedIMage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text(
          'ລົງທະບຽນເຂົ້າໃຊ້ລະບົບ',
          style: GoogleFonts.notoSansLao(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
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
                offset: Offset(
                  5.0,
                  5.0,
                ),
                blurRadius: 10.0,
                spreadRadius: 2.0,
              ), //BoxShadow
              BoxShadow(
                color: Colors.white,
                offset: Offset(0.0, 0.0),
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
              child: Column(children: [
                Column(
                  children: [
                    Stack(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          registerController.profileImage == null
                              ? Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      showfileImagePickerOption(context);
                                    },
                                    child: CircleAvatar(
                                      radius: 60,
                                      backgroundColor: Colors.grey[200],
                                      child: const Icon(
                                        Icons.people_sharp,
                                        size: 60,
                                        color: Colors.black12,
                                      ),
                                    ),
                                  ),
                                )
                              : Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      showfileImagePickerOption(context);
                                    },
                                    child: CircleAvatar(
                                      radius: 60,
                                      backgroundImage: FileImage(
                                          registerController.profileImage!),
                                    ),
                                  ),
                                ),
                          Positioned(
                              bottom: -0,
                              left: 195,
                              child: IconButton(
                                  onPressed: () {
                                    // showImagePickerOption(context);
                                      showfileImagePickerOption(context);

                                  },
                                  icon: const Icon(
                                    Icons.add_a_photo,
                                    color: Colors.black26,
                                    size: 30,
                                  )))
                        ]),
                    Row(
                      children: [
                        Text(
                          'ຊື່ ',
                          style: GoogleFonts.notoSansLao(
                            fontSize: 19,
                          ),
                        ),
                        Text(
                          "*",
                          style: TextStyle(fontSize: 20, color: Colors.red),
                        ),
                      ],
                    ),
                    TextFormField(
                      controller: registerController.nameController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 207, 207, 207)),
                          borderRadius: BorderRadius.circular(8.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 207, 207, 207)),
                          borderRadius: BorderRadius.circular(8.5),
                        ),
                        prefixIcon:
                            const Icon(Icons.person, color: Colors.black12),
                        hintText: "ກະລຸນາປ້ອນຊື່",
                        hintStyle: GoogleFonts.notoSansLao(
                          color: Colors.black12,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ກະລຸນາປ້ອນຊື່ກ່ອນ';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
              const     SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          'ນາມສະກຸນ ',
                          style: GoogleFonts.notoSansLao(
                            fontSize: 19,
                          ),
                        ),
                      const   Text(
                          "*",
                          style: TextStyle(fontSize: 20, color: Colors.red),
                        ),
                      ],
                    ),
                    TextFormField(
                      controller: registerController.surnameController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 207, 207, 207)),
                          borderRadius: BorderRadius.circular(8.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 207, 207, 207)),
                          borderRadius: BorderRadius.circular(8.5),
                        ),
                        prefixIcon: Icon(Icons.person, color: Colors.black12),
                        hintText: "ກະລຸນາປ້ອນນາມສະກຸນ",
                        hintStyle: GoogleFonts.notoSansLao(
                          color: Colors.black12,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ກະລຸນາປ້ອນນາມສະກຸນ';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          'ວັນເດືອນປີເກີດ ',
                          style: GoogleFonts.notoSansLao(
                            fontSize: 19,
                          ),
                        ),
                        const Text(
                          "*",
                          style: TextStyle(fontSize: 20, color: Colors.red),
                        ),
                      ],
                    ),
                   
                    TextField(
                      readOnly: true,
                      onTap: () async {
                        final selectedDate = await showDatePicker(
                          context: context,
                          initialDate: datetime,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(3000),
                        );

                        if (selectedDate != null) {
                          setState(() {
                            datetime = selectedDate;
                            registerController.setDobDateTime(selectedDate);
                          });
                        }
                      },
                      controller: registerController.dobController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 207, 207, 207)),
                          borderRadius: BorderRadius.circular(8.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 207, 207, 207)),
                          borderRadius: BorderRadius.circular(8.5),
                        ),
                        prefixIcon: const Icon(Icons.data_array,
                            color: Color.fromARGB(31, 199, 160, 160)),
                        hintText: datetime != null
                            ? "${datetime.day.toString().padLeft(2, '0')}/${datetime.month.toString().padLeft(2, '0')}/${datetime.year}"
                            : '', // Format the date
                        hintStyle: GoogleFonts.notoSansLao(
                          color: Colors.grey.shade600,
                        ),
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
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 207, 207, 207)),
                          borderRadius: BorderRadius.circular(8.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 207, 207, 207)),
                          borderRadius: BorderRadius.circular(8.5),
                        ),
                        prefixIcon: Icon(Icons.email, color: Colors.black12),
                        hintText: "ກະລຸນາປ້ອນອີເມວ",
                        hintStyle: GoogleFonts.notoSansLao(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ກະລຸນາປ້ອນອີເມວກ່ອນ';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          'ເບີໂທຕິດຕໍ່ ',
                          style: GoogleFonts.notoSansLao(
                            fontSize: 19,
                          ),
                        ),
                        const Text(
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
                        suffixIcon: registerController
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
                    Row(
                      children: [
                        Text(
                          'ປະເພດເອກະສານຢັງຢືນ ',
                          style: GoogleFonts.notoSansLao(
                            fontSize: 19,
                          ),
                        ),
                        const Text(
                          "*",
                          style: TextStyle(fontSize: 20, color: Colors.red),
                        ),
                      ],
                    ),
                    TextFormField(
                      controller: registerController.idCardController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 207, 207, 207)),
                          borderRadius: BorderRadius.circular(8.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 207, 207, 207)),
                          borderRadius: BorderRadius.circular(8.5),
                        ),
                        prefixIcon: const Icon(Icons.usb_rounded,
                            color: Colors.black12),
                        hintText: "ID ບັດປະຈໍາຕົວ",
                        hintStyle: GoogleFonts.notoSansLao(
                          color: Colors.black12,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return "ຫ້າມປ້ອນຕົວອັກສອນ";
                        } else {
                          return null;
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            Text(
                              'ເພດ ',
                              style: GoogleFonts.notoSansLao(
                                fontSize: 19,
                              ),
                            ),
                            const Text(
                              "*",
                              style: TextStyle(fontSize: 20, color: Colors.red),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 1,
                              groupValue: _value,
                              onChanged: (value) {
                                setState(() {
                                  _value = value as int;
                                });
                              },
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            const Text(
                              "ຊາຍ",
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 2,
                              groupValue: _value,
                              onChanged: (value) {
                                setState(() {
                                  _value = value as int;
                                });
                              },
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            const Text(
                              "ຍີງ",
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'ຖ່າຍຮູບເອກະສານບັດປະຈໍາຕົວ',
                          style: GoogleFonts.notoSansLao(
                            fontSize: 19,
                          ),
                        ),
                        const Text(
                          "*",
                          style: TextStyle(fontSize: 20, color: Colors.red),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    GestureDetector(
                      onTap: () async {
                        // getImage(source: ImageSource.camera);
                        showImagePickerOption(context);
                      },
                      child: registerController.imageFile == null
                          ? Container(
                              // width: 310,
                              width: MediaQuery.of(context).size.width,
                              height: 440,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    width: 1, color: Colors.redAccent),
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
                                      FileImage(registerController.imageFile!),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                    width: 1, color: Colors.redAccent),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: GestureDetector(
                                onTap: () async {
                                  // getImage(source: ImageSource.camera);
                                  showImagePickerOption(context);
                                },
                                child: const Text(
                                  '',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _submitForm(context);
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.loading,
                            text: 'ກໍາລັງລົງທະບຽນ',
                            cancelBtnTextStyle: GoogleFonts.notoSansLao(
                                color: Colors.white, fontSize: 25),
                          );
                        }
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
              ]),
            ),
          ),
        ),
      ),
    );
  }

  void getImage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(
        source: source, maxWidth: 300, maxHeight: 300, imageQuality: 70);

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

//Galleryfile
  Future _pickfileImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      if (returnImage?.path != null) {
        setState(() {
          registerController.profileImage = File(returnImage!.path);
        });
      }
    });
    Navigator.of(context).pop();
  }

//Camerafile
  Future _pickfileImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnImage?.path != null) {
      setState(() {
        registerController.profileImage = File(returnImage!.path);
      });
    }
    Navigator.of(context).pop();
  }

//Galleryimage
  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      if (returnImage?.path != null) {
        setState(() {
          registerController.imageFile = File(returnImage!.path);
        });
      }
    });
    Navigator.of(context).pop();
  }

//Cameraimage
  Future _pickImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnImage?.path != null) {
      setState(() {
        registerController.imageFile = File(returnImage!.path);
      });
    }
    Navigator.of(context).pop();
  }

  void showfileImagePickerOption(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4.5,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _pickfileImageFromGallery();
                      },
                      child: SizedBox(
                        child: Column(
                          children: [
                            const Icon(
                              Icons.image,
                              size: 50,
                              color: Colors.redAccent,
                            ),
                            Text(
                              "ເລືອກຈາກອະລາບໍ້າ",
                              style: GoogleFonts.notoSansLao(fontSize: 17),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _pickfileImageFromCamera();
                      },
                      child: SizedBox(
                        child: Column(
                          children: [
                            const Icon(
                              Icons.camera_alt,
                              color: Colors.redAccent,
                              size: 50,
                            ),
                            Text(
                              "ກ້ອງຖ່າຍຮູບ",
                              style: GoogleFonts.notoSansLao(fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4.5,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _pickImageFromGallery();
                      },
                      child: SizedBox(
                        child: Column(
                          children: [
                            const Icon(
                              Icons.image,
                              size: 50,
                              color: Colors.redAccent,
                            ),
                            Text(
                              "ເລືອກຈາກອະລາບໍ້າ",
                              style: GoogleFonts.notoSansLao(fontSize: 17),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _pickImageFromCamera();
                      },
                      child: SizedBox(
                        child: Column(
                          children: [
                            const Icon(
                              Icons.camera_alt,
                              color: Colors.redAccent,
                              size: 50,
                            ),
                            Text(
                              "ກ້ອງຖ່າຍຮູບ",
                              style: GoogleFonts.notoSansLao(fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
