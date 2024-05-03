import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/app/modules/home/views/home_view.dart';
import 'package:flutter_final/app/modules/login/controllers/login_controller.dart';
import 'package:flutter_final/app/modules/login/views/login_view.dart';
import 'package:flutter_final/app/modules/mytickets/views/list_my_tickets.dart';
import 'package:flutter_final/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter_final/app/modules/profile/update_profile.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:http/io_client.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String firebaseTokenKeySharePref = 'firebaseToken';
const String uuidKeySharePref = 'uuid';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImageController imageController = Get.put(ImageController());
  final LoginController logineController = Get.put(LoginController());
  final loginController = Get.put(LoginController());
  HttpClient createHttpClient() {
    return HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }

// This function creates an IOClient using the custom HttpClient
  IOClient createIOClient() {
    return IOClient(createHttpClient());
  }

  @override
  void initState() {
    imageController
        .fetchImageUrl(logineController.passenger?.passengerId ?? '');
    print("some contr:${imageController.imageUrl}");
    // loginController.logout();
    super.initState();
  }
  //     final loginController = Get.put(LoginController());
  // @override
  // void initState() {
  //   loginController.logout();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<LoginController>(
          builder: (_) {
            return Column(
              // mainAxisSize: MainAxisSize.max,
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GetBuilder<ImageController>(
                        builder: (_) => SizedBox(
                          width: 70,
                          height: 70,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                60), // half of the width (radius)
                            child: Obx(
                              () => imageController.imageUrl.isNotEmpty
                                  ? Image.network(
                                      imageController.imageUrl.value,
                                      loadingBuilder: (BuildContext context,
                                          child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Column(
                                          children: [
                                            CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      (loadingProgress
                                                              .expectedTotalBytes ??
                                                          1)
                                                  : null,
                                            ),
                                          ],
                                        );
                                      },
                                    )
                                  : Text('Image URL is empty.'),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                        height: 50,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${_.passenger?.username} ',
                            style: GoogleFonts.notoSansLao(
                              fontWeight: FontWeight.bold,
                              fontSize: 20, color: Colors.blueAccent,
                              // Other text style properties can be added here
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '+856 ${_.passenger?.phoneNumber}',
                            style: GoogleFonts.notoSansLao(
                              fontWeight: FontWeight.bold,
                              fontSize: 15, color: Colors.black,
                              // Other text style properties can be added here
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.pink[100],
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          // color: Colors.deepPurple,
                          child: Lottie.network(
                            'https://lottie.host/5a575f5a-1bf6-43ec-8cb6-147fdccf4040/rfOEOJTi7q.json',
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "ສະບາຍດີ",
                                    style: GoogleFonts.notoSansLao(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19, color: Colors.white,
                                      // Other text style properties can be added here
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "ຂໍໃຫ້ທ່ານເດີນທາງດ້ວຍ",
                                    style: GoogleFonts.notoSansLao(
                                      fontSize: 15, color: Colors.white,
                                      // Other text style properties can be added here
                                    ),
                                  ),
                                  Text(
                                    "ຄວາມປອດໄພ",
                                    style: GoogleFonts.notoSansLao(
                                      fontSize: 15, color: Colors.white,
                                      // Other text style properties can be added here
                                    ),
                                  ),
                                  Text(
                                    "ແລະສະຫວັດດີພາບ",
                                    style: GoogleFonts.notoSansLao(
                                      fontSize: 15, color: Colors.white,
                                      // Other text style properties can be added here
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white.withOpacity(0.1),
                        ),
                        child: Icon(
                          Icons.settings_rounded,
                          size: 30,
                          color: Colors.deepPurple,
                        ),
                      ),
                      title: Text(
                        "ຕັ້ງຄ່າ",
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
                          child: Icon(
                            CupertinoIcons.person_alt_circle,
                            size: 30,
                            color: Colors.blue,
                          ),
                        ),
                        title: Text(
                          "ແກ້ໄຂຂໍ້ມູນຈີງ",
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
                        child: Icon(
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
                        Get.defaultDialog(
                          title: "ທ່ານຕ້ອງການອອກຈາກລະບົບແທ້ບໍ່",
                          titleStyle: TextStyle(
                            fontSize: 18,
                          ),
                          content: Container(),
                          textConfirm: "ແມ່ນ",
                          textCancel: "ບໍ່ແມ່ນ",
                          confirmTextColor: Colors.white,
                          onConfirm: () async {
                            await logout();
                          },
                          onCancel: () {},
                        );
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
              ],
            );
          },
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
              color: Colors.red,
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

    //   return Scaffold(
    //     backgroundColor: Color(0xffffffff),
    //     body: ListView(
    //       padding: EdgeInsets.all(12),
    //       physics: BouncingScrollPhysics(),
    //       children: [
    //         Container(
    //           height: 35,
    //         ),
    //         userTile(),
    //         divider(),
    //         colorTiles(),
    //         divider(),
    //         bwTiles(),
    //       ],
    //     ),
    //     bottomNavigationBar: BottomNavigationBar(
    //       items: const <BottomNavigationBarItem>[
    //         BottomNavigationBarItem(
    //           icon: ImageIcon(
    //             AssetImage("assets/icons/beranda.png"),
    //           ),
    //           label: "ໜ້າຫຼັກ",
    //         ),
    //         BottomNavigationBarItem(
    //           icon: ImageIcon(
    //             AssetImage("assets/icons/ticket.png"),
    //           ),
    //           label: "ປີ້ຂອງຂ້ອຍ",
    //         ),
    //         BottomNavigationBarItem(
    //           icon: ImageIcon(
    //             AssetImage("assets/icons/profile.png"),
    //             color: Colors.red,
    //           ),
    //           label: "ບັນຊີຂອງຂ້ອຍ",
    //         ),
    //       ],
    //       onTap: (int index) {
    //         if (index == 0) {
    //           Navigator.push(
    //             context,
    //             MaterialPageRoute(builder: (context) => HomeView()),
    //           );
    //         } else if (index == 1) {
    //           Navigator.push(
    //             context,
    //             MaterialPageRoute(builder: (context) => ListMyTickets()),
    //           );
    //         } else if (index == 2) {
    //           Navigator.push(
    //             context,
    //             MaterialPageRoute(builder: (context) => ProfileScreen()),
    //           );
    //         }
    //       },
    //     ),
    //   );
    // }

    // Widget userTile() {
    //   return GetBuilder<LoginController>(
    //     builder: (_) {
    //       return ListTile(
    //         leading: GetBuilder<ImageController>(
    //           builder: (_) {
    //             if (imageController.imageUrl.value.isEmpty) {
    //               // Placeholder widget when the image URL is empty
    //               return Placeholder();
    //             } else {
    //               return ClipRRect(
    //                 borderRadius: BorderRadius.circular(60),
    //                 child: Image.network(
    //                   imageController.imageUrl.value,
    //                   loadingBuilder:
    //                       (BuildContext context, child, loadingProgress) {
    //                     if (loadingProgress == null) return child;
    //                     return Center(
    //                       child: CircularProgressIndicator(
    //                         value: loadingProgress.expectedTotalBytes != null
    //                             ? loadingProgress.cumulativeBytesLoaded /
    //                                 (loadingProgress.expectedTotalBytes ?? 1)
    //                             : null,
    //                       ),
    //                     );
    //                   },
    //                 ),
    //               );
    //             }
    //           },
    //         ),
    //         title: Text(
    //           '${_.passenger?.username}',
    //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    //         ),
    //         subtitle: Text(
    //           '+856 ${_.passenger?.phoneNumber}',
    //           style: TextStyle(fontSize: 18),
    //         ),
    //       );
    //     },
    //   );
    // }

    // Widget divider() {
    //   return Padding(
    //     padding: EdgeInsets.all(8.0),
    //     child: Divider(
    //       thickness: 1.5,
    //     ),
    //   );
    // }

    // Widget bwTiles() {
    //   return Column(
    //     children: [
    //       bwTile(Icons.info_outline, "ອອກຈາກລະບົບ"),
    //       bwTile(Icons.border_color_outlined, "ຮັກສາລະບົບ"),
    //       bwTile(Icons.textsms_outlined, "ຄໍາຄິດເຫັນ"),
    //     ],
    //   );
    // }

    // Widget bwTile(IconData icon, String text) {
    //   return colorTile(icon, Colors.black, text);
    // }

    // Widget colorTiles() {
    //   return Column(
    //     children: [
    //       colorTile(Icons.person_outlined, Colors.deepPurple, "ຂໍ້ມູນຜູ້ໃຊ້"),
    //       colorTile(Icons.settings_outlined, Colors.blue, "ຕັ້ງຄ່າ"),
    //       colorTile(Icons.person_outlined, Colors.pink, "ການເງີນ"),
    //       colorTile(Icons.person_outlined, Colors.amber, "ລາຍການ"),
    //     ],
    //   );
    // }

    // Widget colorTile(IconData icon, Color color, String text) {
    //   return ListTile(
    //     leading: Container(
    //       child: Icon(icon, color: color), // corrected the placement of 'color'
    //       height: 45,
    //       width: 45,
    //       decoration: BoxDecoration(
    //         color: color
    //             .withOpacity(0.09), // corrected the method name to 'withOpacity'
    //         borderRadius: BorderRadius.circular(18),
    //       ),
    //     ),
    //     title: Text(
    //       text,
    //       style: TextStyle(fontWeight: FontWeight.w500), // corrected 'fontWeight'
    //     ),
    //     trailing: Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20),
    //   );
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(firebaseTokenKeySharePref, '');
    prefs.setString(uuidKeySharePref, '');
    prefs.clear();
    Get.offAll(() => LoginView());
  }
}
