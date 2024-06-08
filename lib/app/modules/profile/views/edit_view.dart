// import 'package:flutter/material.dart';
// import 'package:flutter_final/app/modules/login/controllers/login_controller.dart';
// import 'package:flutter_final/app/modules/profile/views/profile_screen.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:page_transition/page_transition.dart';

// class EditView extends StatefulWidget {
//   const EditView({Key? key}) : super(key: key);

//   @override
//   _EditViewState createState() => _EditViewState();
// }

// class _EditViewState extends State<EditView> {
//   late DateTime datetime;
//   DateTime seletedatetime = DateTime.now();

//   void initState() {
//     // registerController = RegisterController();

//     datetime = DateTime.now();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.redAccent,
//         centerTitle: true,
//         title: Text(
//           'ຂໍ້ມູນສ່ວນໂຕ',
//           style: GoogleFonts.notoSansLao(
//               fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white
//               // Other text style properties can be added here
//               ),
//         ),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               PageTransition(
//                 type: PageTransitionType.rightToLeft,
//                 child: Builder(
//                   builder: (context) => ProfileScreen(),
//                 ),
//               ),
//             );
//           },
//           icon: const Icon(
//             Icons.arrow_back_ios,
//             color: Colors.white,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           child: Padding(
//             padding: EdgeInsets.all(15.0),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Text(
//                       'ຊື່ ',
//                       style: GoogleFonts.notoSansLao(
//                         fontSize: 18,
//                         // Other text style properties can be added here
//                       ),
//                     ),
//                     Text(
//                       "*",
//                       style: TextStyle(fontSize: 20, color: Colors.red),
//                     ),
//                   ],
//                 ),
//                 GetBuilder<LoginController>(
//                   builder: (_) {
//                     return TextFormField(
//                       decoration: InputDecoration(
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                               color: Color.fromARGB(255, 207, 207, 207)),
//                           borderRadius: BorderRadius.circular(8.5),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                               color: Color.fromARGB(255, 207, 207, 207)),
//                           borderRadius: BorderRadius.circular(8.5),
//                         ),
//                         prefixIcon: Icon(Icons.person, color: Colors.black12),
//                         hintText: _.passenger?.username ??
//                             "ປ້ອນຊື່", // Use a default value if passenger is null
//                         hintStyle: GoogleFonts.notoSansLao(
//                           color: Colors.black54,
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'ກະລຸນາປ້ອນຊື່ກ່ອນ';
//                         }
//                         return null;
//                       },
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                     );
//                   },
//                 ),
//                 SizedBox(height: 5),
//                 Row(
//                   children: [
//                     Text(
//                       'ນາມສະກຸນ ',
//                       style: GoogleFonts.notoSansLao(
//                         fontSize: 18,
//                         // Other text style properties can be added here
//                       ),
//                     ),
//                     Text(
//                       "*",
//                       style: TextStyle(fontSize: 20, color: Colors.red),
//                     ),
//                   ],
//                 ),
//                 GetBuilder<LoginController>(
//                   builder: (_) {
//                     return TextFormField(
//                       decoration: InputDecoration(
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                               color: Color.fromARGB(255, 207, 207, 207)),
//                           borderRadius: BorderRadius.circular(8.5),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                               color: Color.fromARGB(255, 207, 207, 207)),
//                           borderRadius: BorderRadius.circular(8.5),
//                         ),
//                         prefixIcon: Icon(Icons.person, color: Colors.black12),
//                         hintText: _.passenger?.username ??
//                             "ປ້ອນຊື່", // Use a default value if passenger is null
//                         hintStyle: GoogleFonts.notoSansLao(
//                           color: Colors.black54,
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'ກະລຸນາປ້ອນນາມສະກຸນ';
//                         }
//                         return null;
//                       },
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                     );
//                   },
//                 ),
//                 SizedBox(height: 5),
//                 const Row(
//                   children: [
//                     Text(
//                       'ວັນເດືອນປີເກີດ ',
//                       style: TextStyle(fontSize: 19),
//                     ),
//                     Text(
//                       "*",
//                       style: TextStyle(fontSize: 20, color: Colors.red),
//                     ),
//                   ],
//                 ),
//                 GetBuilder<LoginController>(
//                   builder: (_) {
//                     return TextField(
//                       readOnly: true,
//                       onTap: () async {
//                         final selectedDate = await showDatePicker(
//                           context: context,
//                           initialDate: datetime,
//                           firstDate: DateTime(2000),
//                           lastDate: DateTime(3000),
//                         );

//                         if (selectedDate != null) {
//                           setState(() {
//                             datetime = selectedDate;
//                             // registerController.setDobDateTime(selectedDate);
//                           });
//                         }
//                       },
//                       decoration: InputDecoration(
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                               color: Color.fromARGB(255, 207, 207, 207)),
//                           borderRadius: BorderRadius.circular(8.5),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                               color: Color.fromARGB(255, 207, 207, 207)),
//                           borderRadius: BorderRadius.circular(8.5),
//                         ),
//                         prefixIcon: const Icon(Icons.data_array,
//                             color: Color.fromARGB(31, 199, 160, 160)),
//                         hintText: _.passenger?.dob != null
//                             ? DateFormat('dd-MM-yyyy').format(_.passenger!.dob)
//                             : "",
//                         hintStyle: GoogleFonts.notoSansLao(
//                           color: Colors.grey.shade600,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//                 SizedBox(height: 5),
//                 Row(
//                   children: [
//                     Text(
//                       'ອີເມວ',
//                       style: GoogleFonts.notoSansLao(
//                         fontSize: 19,
//                       ),
//                     ),
//                     Text(
//                       "*",
//                       style: TextStyle(fontSize: 20, color: Colors.red),
//                     ),
//                   ],
//                 ),
//                 GetBuilder<LoginController>(
//                   builder: (_) {
//                     return TextFormField(
//                       decoration: InputDecoration(
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                               color: Color.fromARGB(255, 207, 207, 207)),
//                           borderRadius: BorderRadius.circular(8.5),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                               color: Color.fromARGB(255, 207, 207, 207)),
//                           borderRadius: BorderRadius.circular(8.5),
//                         ),
//                         prefixIcon: Icon(Icons.person, color: Colors.black12),
//                         hintText: _.passenger?.email ??
//                             "ປ້ອນຊື່ອີເມວ", // Use a default value if passenger is null
//                         hintStyle: GoogleFonts.notoSansLao(
//                           color: Colors.black54,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//                 const SizedBox(height: 5),
//                 const Row(
//                   children: [
//                     Text(
//                       'ປະເພດເອກະສານຢັງຢືນ ',
//                       style: TextStyle(fontSize: 19),
//                     ),
//                     Text(
//                       "*",
//                       style: TextStyle(fontSize: 20, color: Colors.red),
//                     ),
//                   ],
//                 ),
//                 GetBuilder<LoginController>(
//                   builder: (_) {
//                     return TextFormField(
//                       decoration: InputDecoration(
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                               color: Color.fromARGB(255, 207, 207, 207)),
//                           borderRadius: BorderRadius.circular(8.5),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                               color: Color.fromARGB(255, 207, 207, 207)),
//                           borderRadius: BorderRadius.circular(8.5),
//                         ),
//                         prefixIcon: Icon(Icons.person, color: Colors.black12),
//                         hintText: _.passenger?.idCard ??
//                             "ປ້ອນຊື່ID", // Use a default value if passenger is null
//                         hintStyle: GoogleFonts.notoSansLao(
//                           color: Colors.black54,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: 50,
//                   decoration: BoxDecoration(
//                     gradient: const LinearGradient(
//                       colors: <Color>[
//                         Colors.redAccent,
//                         Colors.orangeAccent,
//                       ],
//                     ),
//                     borderRadius: BorderRadius.circular(5.0),
//                   ),
//                   padding: const EdgeInsets.all(16.0),
//                   child: Text(
//                     "ຢືນຢັນການແກ້ໄຂ",
//                     style: GoogleFonts.notoSansLao(
//                       // Use camelCase and avoid spaces
//                       color: Colors.white, fontSize: 16,
//                       // fontSize: 12
//                       // Other text style properties can be added here
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_final/app/modules/login/controllers/login_controller.dart';
import 'package:flutter_final/app/modules/profile/views/profile_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class EditView extends StatefulWidget {
  const EditView({Key? key}) : super(key: key);

  @override
  _EditViewState createState() => _EditViewState();
}

class _EditViewState extends State<EditView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late DateTime datetime;
  DateTime selectedDatetime = DateTime.now();

  @override
  void initState() {
    datetime = DateTime.now();
    super.initState();
  }

  void _saveForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      Get.find<LoginController>().updatePassengerDetails(
        name: _nameController.text,
        dob: datetime,
        email: _emailController.text,
        idCard: _idCardController.text,
      );
      // Provide feedback to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('ແກ້ໄຂສໍາເລັດ')),
      );
    }
  }

  // Controllers for form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _idCardController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: Text(
          'ຂໍ້ມູນສ່ວນໂຕ',
          style: GoogleFonts.notoSansLao(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: Builder(
                  builder: (context) => ProfileScreen(),
                ),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'ຊື່ ',
                        style: GoogleFonts.notoSansLao(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "*",
                        style: TextStyle(fontSize: 20, color: Colors.red),
                      ),
                    ],
                  ),
                  GetBuilder<LoginController>(
                    builder: (_) {
                      // _nameController.text = _.passenger?.username ?? '';
                      return TextFormField(
                        controller: _nameController,
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
                          hintText: "ປ້ອນຊື່",
                          hintStyle: GoogleFonts.notoSansLao(
                            color: Colors.black54,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'ກະລຸນາປ້ອນຊື່ກ່ອນ';
                          }
                          return null;
                        },
                      );
                    },
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        'ນາມສະກຸນ ',
                        style: GoogleFonts.notoSansLao(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "*",
                        style: TextStyle(fontSize: 20, color: Colors.red),
                      ),
                    ],
                  ),
                  GetBuilder<LoginController>(
                    builder: (_) {
                      // _surnameController.text = _.passenger?.username ?? '';
                      return TextFormField(
                        controller: _surnameController,
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
                          hintText: "ປ້ອນນາມສະກຸນ",
                          hintStyle: GoogleFonts.notoSansLao(
                            color: Colors.black54,
                          ),
                        ),
                      );
                    },
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
                  GetBuilder<LoginController>(
                    builder: (_) {
                      return TextFormField(
                        readOnly: true,
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
                          prefixIcon: const Icon(Icons.calendar_today,
                              color: Colors.black12),
                          hintText: _.passenger?.dob != null
                              ? DateFormat('dd-MM-yyyy')
                                  .format(_.passenger!.dob)
                              : "",
                          hintStyle: GoogleFonts.notoSansLao(
                            color: Colors.grey.shade600,
                          ),
                        ),
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
                            });
                          }
                        },
                      );
                    },
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        'ອີເມວ',
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
                  GetBuilder<LoginController>(
                    builder: (_) {
                      // _emailController.text = _.passenger?.email ?? '';
                      return TextFormField(
                        controller: _emailController,
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
                          hintText: "ປ້ອນອີເມວ",
                          hintStyle: GoogleFonts.notoSansLao(
                            color: Colors.black54,
                          ),
                        ),
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'ກະລຸນາປ້ອນອີເມວ';
                        //   }
                        //   if (!GetUtils.isEmail(value)) {
                        //     return 'ກະລຸນາປ້ອນອີເມວທີ່ຖືກຕ້ອງ';
                        //   }
                        //   return null;
                        // },
                      );
                    },
                  ),
                  SizedBox(height: 5),
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
                  GetBuilder<LoginController>(
                    builder: (_) {
                      // _idCardController.text = _.passenger?.idCard ?? '';
                      return TextFormField(
                        controller: _idCardController,
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
                          hintText: "ປ້ອນ ID",
                          hintStyle: GoogleFonts.notoSansLao(
                            color: Colors.black54,
                          ),
                        ),
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'ກະລຸນາປ້ອນ ID';
                        //   }
                        //   return null;
                        // },
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      _saveForm();
                      Navigator.of(context).pop(); // Close the current screen
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
                      child: Text(
                        "ຢືນຢັນການແກ້ໄຂ",
                        style: GoogleFonts.notoSansLao(
                          color: Colors.white,
                          fontSize: 16,
                        ),
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
}
