import 'dart:io';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/app/modules/book_tickets/views/add_passengers.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:get/get.dart';

class AddAContact extends StatefulWidget {
  const AddAContact({Key? key}) : super(key: key);

  @override
  _AddAContactState createState() => _AddAContactState();
}

File? imageFile;
final TextEditingController phoneController = TextEditingController();
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

// phoneController.selection = TextSelection.fromPosition(
//   TextPosition(
//     offset: phoneController.text.length,
//   ),
// );
class _AddAContactState extends State<AddAContact> {
  late DateTime datetime;
  void initState() {
    datetime = DateTime.now();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: const Text('ເພີ່ມຜູ້ຕິດຕໍ່'),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddPassengers()),
            );
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        // children: [
        child: Container(
          margin:const EdgeInsets.only(left: 20, top: 10, right: 10, bottom: 50),
          height: 1100,
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
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                TextFormField(
                  decoration: const InputDecoration(
                      hintText: 'ກະລຸນາປ້ອນຊື່',
                      hintStyle:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
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
                  decoration: const InputDecoration(
                      hintText: 'ກະລຸນາປ້ອນນາມສະກຸນ',
                      hintStyle:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                ),
                SizedBox(height: 5),
                GestureDetector(
                  onTap: () {
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
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  child: const Row(
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
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: datetime
                        .toIso8601String()
                        .split('T')[0], // Extract the date part
                    hintStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
                  decoration: const InputDecoration(
                      hintText: 'ກະລຸນາປ້ອນອີເມວ',
                      hintStyle:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
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
                  cursorColor: Colors.purple,
                  controller: phoneController,
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
                    hintText: "020 12345678",
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
                    suffixIcon: phoneController.text.length > 9
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
              const  SizedBox(height: 5),
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
                  decoration: const InputDecoration(
                      hintText: 'ກະລຸນາID ບັດປະຈໍາຕົວ',
                      hintStyle:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                ),
             const   SizedBox(height: 10),
                if (imageFile != null)
                  Container(
                    width: 300,
                    height: 300,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image: FileImage(imageFile!), fit: BoxFit.cover),
                      border: Border.all(width: 8, color: Colors.black),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  )
                else
                  Container(
                    width: 310,
                    height: 500,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 8, color: Colors.black12),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/card.png'),
                        GestureDetector(
                          onTap: () {
                            getImage(source: ImageSource.camera);
                          },
                          child: const Text('ກົດເພື່ອອັບໂຫລດຮູບພາບ',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
              const  SizedBox(
                  height: 10,
                ),
                Container(
                  width: 300,
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
              ],
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
        imageFile = File(file!.path);
      });
    }
  }
}
