
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/app/const/shared_pref_key.dart';
import 'package:flutter_final/app/modules/home/views/home_view.dart';
import 'package:flutter_final/app/modules/login/controllers/login_controller.dart';
import 'package:flutter_final/app/modules/login/views/login_view.dart';
import 'package:flutter_final/app/modules/mytickets/views/list_my_tickets.dart';
import 'package:flutter_final/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter_final/app/modules/profile/views/announced.dart';
import 'package:flutter_final/app/modules/profile/views/service.dart';
import 'package:flutter_final/app/modules/profile/views/update_profile.dart';
import 'package:flutter_final/app/modules/profile/views/edit_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:http/io_client.dart';
import 'package:flutter_final/app/modules/register/controllers/register_controller.dart';
import 'package:flutter_final/app/service/firebase_firestore_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _value = 1;
  late DateTime datetime;
  late RegisterController registerController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseFirestoreService firebaseFirestoreService =
      FirebaseFirestoreService();
  File? imageFile, profileImage;

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

    imageController
        .fetchImageUrl(logineController.passenger?.passengerId ?? '');
    print("some contr:${imageController.imageUrl}");
    // loginController.logout();
    super.initState();
  }

  File? selectedIMage;

  final ImageController imageController = Get.put(ImageController());
  final LoginController logineController = Get.put(LoginController());
  final loginController = Get.put(LoginController());
  HttpClient createHttpClient() {
    return HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }

  IOClient createIOClient() {
    return IOClient(createHttpClient());
  }
  bool isLaoSelected = false;
  bool isEnglishSelected = false;

  void _toggleLaoSelection(bool? value) {
    setState(() {
      isLaoSelected = value ?? false;
      if (isLaoSelected) {
        isEnglishSelected = false;
      }
    });
  }

  void _toggleEnglishSelection(bool? value) {
    setState(() {
      isEnglishSelected = value ?? false;
      if (isEnglishSelected) {
        isLaoSelected = false;
      }
    });
  }

  void _showLanguageSelector() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              height: 400,
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ພາສາ',
                          style: GoogleFonts.notoSansLao(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context); // Close the bottom sheet
                          },
                          child: Icon(Icons.cancel),
                        ),
                      ],
                    ),
                  ),
                  const Divider(color: Colors.black12),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ພາສາລາວ',
                          style: GoogleFonts.notoSansLao(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        Checkbox(
                          value: isLaoSelected,
                          onChanged: (bool? value) {
                            setState(() {
                              isLaoSelected = value ?? false;
                              if (isLaoSelected) {
                                isEnglishSelected = false;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Divider(color: Colors.black12),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'English',
                          style: GoogleFonts.notoSansLao(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        Checkbox(
                          value: isEnglishSelected,
                          onChanged: (bool? value) {
                            setState(() {
                              isEnglishSelected = value ?? false;
                              if (isEnglishSelected) {
                                isLaoSelected = false;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const Divider(color: Colors.black12),
                  const SizedBox(height: 25),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(); // Close the current screen
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
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
                          "ແອັບ",
                          style: GoogleFonts.notoSansLao(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: Builder(
                  builder: (context) => HomeView(),
                ),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: kDefaultPadding / 2),
            child: Row(
              children: [
                Container(
                  child: const Icon(
                    Icons.qr_code,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: Builder(
                          builder: (context) => EditView(),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: kOtherColor,
          child: Column(children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(kDefaultPadding * 2),
                  bottomLeft: Radius.circular(kDefaultPadding * 2),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(children: [
                    registerController.profileImage == null
                        ? Center(
                            child: GestureDetector(
                              onTap: () {
                                showfileImagePickerOption(context);
                              },
                              child: GetBuilder<ImageController>(
                                builder: (_) => SizedBox(
                                  width: 120,
                                  height: 120,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(60),
                                    child: Obx(
                                      () => imageController.imageUrl.isNotEmpty
                                          ? Image.network(
                                              imageController.imageUrl.value,
                                              loadingBuilder: (
                                                BuildContext context,
                                                Widget child,
                                                ImageChunkEvent?
                                                    loadingProgress,
                                              ) {
                                                return child;
                                              },
                                            )
                                          : Container(),
                                    ),
                                  ),
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
                                backgroundImage:
                                    FileImage(registerController.profileImage!),
                              ),
                            ),
                          ),
                    Positioned(
                      bottom: 0,
                      left: 195,
                      child: IconButton(
                        onPressed: () {
                          showImagePickerOption(context);
                        },
                        icon: const Icon(
                          Icons.add_a_photo,
                          color: Colors.black26,
                          size: 30,
                        ),
                      ),
                    ),
                  ]),
                  kWidthSizedBox,
                  GetBuilder<LoginController>(
                    builder: (_) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${_.passenger?.username}',
                            style: TextStyle(fontSize: 19, color: Colors.white),
                          ),
                          Text(
                            '+856 ${_.passenger?.phoneNumber}',
                            style: TextStyle(fontSize: 19, color: Colors.white),
                          )
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showLanguageSelector(); // Add additional widgets as needed
                      },
                      child: ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white.withOpacity(0.1),
                          ),
                          child: const Icon(
                            Icons.language,
                            size: 30,
                            color: Colors.deepPurple,
                          ),
                        ),
                        title: Text(
                          "ພາສາ",
                          style: GoogleFonts.notoSansLao(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            // Other text style properties can be added here
                          ),
                        ),
                        trailing: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.grey.withOpacity(0.1),
                          ),
                          child: const Icon(Icons.arrow_forward_ios, size: 20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdateProfile()),
                        );
                      },
                      child: ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white.withOpacity(0.1),
                          ),
                          child: const Icon(
                            CupertinoIcons.compass,
                            size: 30,
                            color: Colors.blue,
                          ),
                        ),
                        title: Text(
                          "ຂໍ້ກໍານົດແລະນະໂຍບາຍ",
                          style: GoogleFonts.notoSansLao(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            // Other text style properties can be added here
                          ),
                        ),
                        trailing: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.grey.withOpacity(0.1),
                          ),
                          child: Icon(Icons.arrow_forward_ios, size: 20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Divider(),
                    ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white.withOpacity(0.1),
                        ),
                        child: const Icon(
                          CupertinoIcons.person_3_fill,
                          size: 30,
                          color: Colors.pink,
                        ),
                      ),
                      title: Text(
                        "ກ່ຽວກັບພວກເຮົາ",
                        style: GoogleFonts.notoSansLao(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          // Other text style properties can be added here
                        ),
                      ),
                      trailing: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.grey.withOpacity(0.1),
                        ),
                        child: const Icon(Icons.arrow_forward_ios, size: 20),
                      ),
                    ),
                    SizedBox(height: 15),
                 
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Servicedata()),
                        );
                      },
                      child: ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white.withOpacity(0.1),
                          ),
                          child: const Icon(
                            CupertinoIcons.square_line_vertical_square,
                            size: 30,
                            color: Colors.pink,
                          ),
                        ),
                        title: Text(
                          "ຂໍ້ມູນການບໍລິການ",
                          style: GoogleFonts.notoSansLao(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            // Other text style properties can be added here
                          ),
                        ),
                        trailing: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.grey.withOpacity(0.1),
                          ),
                          child: const Icon(Icons.arrow_forward_ios, size: 20),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap:(){
Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Announced()),
                        );
                      },
                      child: ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white.withOpacity(0.1),
                          ),
                          child: const Icon(
                            CupertinoIcons.news,
                            size: 30,
                            color: Colors.pink,
                          ),
                        ),
                        title: Text(
                          "ປະກາດ",
                          style: GoogleFonts.notoSansLao(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            // Other text style properties can be added here
                          ),
                        ),
                        trailing: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.grey.withOpacity(0.1),
                          ),
                          child: const Icon(Icons.arrow_forward_ios, size: 20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white.withOpacity(0.1),
                        ),
                        child: const Icon(
                          CupertinoIcons.lock_rotation,
                          size: 30,
                          color: Colors.amber,
                        ),
                      ),
                      onTap: () {
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.scale,
                          dialogType: DialogType.info,
                          body: Center(
                            child: Text(
                              'ທ່ານຕ້ອງການອອກຈາກລະບົບບໍ່.',
                              style: GoogleFonts.notoSansLao(fontSize: 15),
                            ),
                          ),
                          btnCancelOnPress: () {},
                          btnOkOnPress: () async {
                            await logout();
                          },
                        )..show();
                      },
                      title: Text(
                        "ອອກຈາກລະບົບ",
                        style: GoogleFonts.notoSansLao(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          // Other text style properties can be added here
                        ),
                      ),
                      trailing: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.grey.withOpacity(0.1),
                        ),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/icons/beranda.png"),
            ),
            label: "ໜ້າຫຼັກ",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/icons/ticket.png"),
            ),
            label: "ປີ້ຂອງຂ້ອຍ",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/icons/profile.png"),
              color: Color(0xFF3A5A98),
            ),
            label: "ບັນຊີຂອງຂ້ອຍ",
          ),
        ],
        onTap: (int index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeView()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ListMyTickets()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          }
        },
      ),
    );
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

//colors
const Color kPrimaryColor = Color(0xFFE74C3C);
const Color kSecondaryColor = Color(0xFF6789CA);
const Color kTextBlackColor = Color(0xFFFFFFFF);
const Color kTextWhiteColor = Color(0xFFFFFFFF);
const Color kContainerColor = Color(0xFFFFFFFF);
const Color kOtherColor = Color(0xFFF4F6F7);
const Color kTextLightColor = Color(0xFFFFFFFF);
const Color kErrorBorderColor = Color(0xFFE74C3C);

//default value
const kDefaultPadding = 20.0;

const sizedBox = SizedBox(
  height: kDefaultPadding,
);
const kWidthSizedBox = SizedBox(
  width: kDefaultPadding,
);

const kHalfSizedBox = SizedBox(
  height: kDefaultPadding / 2,
);

const kHalfWidthSizedBox = SizedBox(
  width: kDefaultPadding / 2,
);

Future<void> logout() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(firebaseTokenKeySharePref, '');
  prefs.setString(uuidKeySharePref, '');
  prefs.clear();
  Get.offAll(() => LoginView());
}
