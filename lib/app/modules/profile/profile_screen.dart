import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_final/app/const/shared_pref_key.dart';
import 'package:flutter_final/app/modules/home/views/home_view.dart';
import 'package:flutter_final/app/modules/login/controllers/login_controller.dart';
import 'package:flutter_final/app/modules/login/views/login_view.dart';
import 'package:flutter_final/app/modules/mytickets/views/list_my_tickets.dart';
import 'package:flutter_final/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter_final/app/modules/profile/update_profile.dart';
import 'package:get/get.dart';
import 'dart:io';
// import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text("ຂໍ້ມູນສ່ວນຕົວ"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<LoginController>(
          builder: (_) {
            return Column(
              children: [
                GetBuilder<ImageController>(
                  builder: (_) => SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          60), // half of the width (radius)
                      child: Obx(
                        () => imageController.imageUrl.isNotEmpty
                            ? Image.network(
                                imageController.imageUrl.value,
                                loadingBuilder: (BuildContext context, child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  (loadingProgress
                                                          .expectedTotalBytes ??
                                                      1)
                                              : null,
                                    ),
                                  );
                                },
                              )
                            : Text('Image URL is empty.'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text('${_.passenger?.username} ',
                    style: TextStyle(
                      fontSize: 19,
                    )),
                Text('${_.passenger?.idCard}',
                    style: TextStyle(
                      fontSize: 15,
                    )),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      side: BorderSide.none,
                      shape: const StadiumBorder(),
                    ),
                    child: const Text(
                      "ແກ້ໄຂຂໍ້ມູນ",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const SizedBox(height: 10),
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
                        child: Icon(Icons.settings_rounded, size: 40),
                      ),
                      title: const Text(
                        "ຕັ້ງຄ່າ",
                        style: TextStyle(fontSize: 18),
                      ),
                      trailing: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.grey.withOpacity(0.1),
                        ),
                        child: const Icon(CupertinoIcons.arrow_right, size: 20),
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
                          child:
                              Icon(CupertinoIcons.person_alt_circle, size: 40),
                        ),
                        title: const Text(
                          "ຢືນຢັນຂໍ້ມູນຈີງ",
                          style: TextStyle(fontSize: 18),
                        ),
                        trailing: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.grey.withOpacity(0.1),
                          ),
                          child: Icon(CupertinoIcons.arrow_right, size: 20),
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
                        child: Icon(CupertinoIcons.person_3_fill, size: 40),
                      ),
                      title: const Text(
                        "ກ່ຽວກັບພວກເຮົາ",
                        style: TextStyle(fontSize: 18),
                      ),
                      trailing: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.grey.withOpacity(0.1),
                        ),
                        child: const Icon(CupertinoIcons.arrow_right, size: 20),
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
                          size: 40,
                          color: Colors.blue,
                        ),
                      ),
                      title: GestureDetector(
                        onTap: () async {
                          // Call the logout function when tapped
                          await logout();
                        },
                        child: const Text(
                          "ອອກຈາກລະບົບ",
                          style: TextStyle(fontSize: 18),
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
                          CupertinoIcons.arrow_right,
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
  }
}

Future<void> logout() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(firebaseTokenKeySharePref, '');
  prefs.setString(uuidKeySharePref, '');
  prefs.clear();
  Get.offAll(() => LoginView());
}
