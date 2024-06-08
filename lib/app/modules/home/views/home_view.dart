import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/app/modules/bus/views/bus_view.dart';
import 'package:flutter_final/app/modules/login/controllers/login_controller.dart';
import 'package:flutter_final/app/modules/mytickets/views/list_my_tickets.dart';
import 'package:flutter_final/app/modules/profile/views/profile_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  // final loginController = Get.put(LoginController());
  final LoginController logineController = Get.put(LoginController());

  static final String title = 'Custom & Google Fonts';
  // HomeView(Passenger passenger);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Row(
          children: [
            const Text(
              "Hi, ",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            GetBuilder<LoginController>(
              builder: (loginController) {
                final username = loginController.passenger?.username ?? '';
                return Text(
                  '$username',
                  style: const TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                  ),
                );
              },
            )
          ],
        ),
        actions: [
GestureDetector(
  onTap: () {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child:const  Text('ອອກ',style: TextStyle(fontSize: 20),selectionColor: Colors.redAccent,),
          )
        ],
        contentPadding: const EdgeInsets.all(5.0),
        content: Container(
          padding: EdgeInsets.all(5.0),
          child:Image.asset('assets/images/bclone.png')
        ),
      ),
    );
  },
            child: Container(
              margin: EdgeInsets.only(right: 20),
              width: 30,
              height: 30,
              child: Image.asset(
                "assets/icons/qr.png",
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
        backgroundColor: Color(0xFFEC2028),
        elevation: 0,
      ),
      body: Stack(
        children: [
          ClipPath(
            clipper: ClipPathClass(),
            child: Container(
              height: 200,
              width: Get.width,
              color: Color(0xFFEC2028),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 75),
            child: Column(
              children: [
                Column(
                  children: [
                    ClipPath(
                      clipper: ClipInfoClass(),
                      child: Container(
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFE52D27),
                              Color(0xFFB31217),
                            ],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    // Icon(MdiIcons., size: 30),
                                    Image.asset(
                                      "assets/icons/ic-coin.png",
                                      height: 30,
                                      width: 30,
                                      color: Color(0xFFF7B731),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "ຄະແນນ",
                                      style: GoogleFonts.notoSansLao(
                                          // Use camelCase and avoid spaces
                                          color: Colors.blue,
                                          fontSize: 12
                                          // Other text style properties can be added here
                                          ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    // Icon(MdiIcons., size: 30),
                                    Image.asset(
                                      "assets/icons/kip.png",
                                      height: 30,
                                      width: 30,
                                      color: Color(0xFFF7B731),
                                    ),
                                    SizedBox(width: 10),
                                    const Text(
                                      "ຍອດເງີນຂອງຂ້ອຍ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    // Icon(MdiIcons., size: 30),
                                    Image.asset(
                                      "assets/icons/ic-wallet.png",
                                      height: 30,
                                      width: 30,
                                      color: Color(0xFFF7B731),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            const Divider(
                              color: Colors.black,
                            ),
                            const SizedBox(height: 10),
                            const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "10 000 Kip",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "ເຊື່ອມຕໍ່ໃໝ່ !",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "ເປີດໃຊ້ດຽວນີ້ !",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                  ],
                ),
                Container(
                  height: 7,
                  color: Colors.grey[300],
                ),
                Expanded(
                  child: Container(
                    // color: Colors.purple,
                    child: Column(
                      children: [
                        // body
                        Expanded(
                          child: ListView(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            children: [
                              SizedBox(height: 20),
                              Text(
                                "ລາຍການ",
                                style: GoogleFonts.notoSansLao(
                                    // Use camelCase and avoid spaces
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                    // Other text style properties can be added here
                                    ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.error,
                                              animType: AnimType.bottomSlide,
                                              showCloseIcon: true,
                                              title: "ຂໍອະໄພ",
                                              titleTextStyle:
                                                  GoogleFonts.notoSansLao(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                              desc:
                                                  "ກໍາລັງພັດທະນາຈະເປີດໃຫ້ໄວໆນີ້",
                                              descTextStyle:
                                                  GoogleFonts.notoSansLao(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                              btnOkOnPress: () {})
                                          .show();
                                    },
                                    child: ItemKategori(
                                      title: "ເຄື່ອງບີນ",
                                      icon: "assets/icons/roaming.png",
                                      style: GoogleFonts.notoSansLao(
                                          // Use camelCase and avoid spaces
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15
                                          // Other text style properties can be added here
                                          ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.error,
                                              animType: AnimType.bottomSlide,
                                              showCloseIcon: true,
                                              title: "ຂໍອະໄພ",
                                              titleTextStyle:
                                                  GoogleFonts.notoSansLao(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                              desc:
                                                  "ກໍາລັງພັດທະນາຈະເປີດໃຫ້ໄວໆນີ້",
                                              descTextStyle:
                                                  GoogleFonts.notoSansLao(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                              btnOkOnPress: () {})
                                          .show();
                                    },
                                    child: ItemKategori(
                                      title: "ລົດໄຟ",
                                      icon: "assets/icons/trans.png",
                                      style: GoogleFonts.notoSansLao(
                                          // Use camelCase and avoid spaces
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15
                                          // Other text style properties can be added here
                                          ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: const BusView(),
                                        ),
                                      );
                                    },
                                    child: ItemKategori(
                                      title: "ລົດເມ",
                                      icon: "assets/icons/bus.png",
                                      style: GoogleFonts.notoSansLao(
                                          // Use camelCase and avoid spaces
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15
                                          // Other text style properties can be added here
                                          ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.error,
                                              animType: AnimType.bottomSlide,
                                              showCloseIcon: true,
                                              title: "ຂໍອະໄພ",
                                              titleTextStyle:
                                                  GoogleFonts.notoSansLao(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                              desc:
                                                  "ກໍາລັງພັດທະນາຈະເປີດໃຫ້ໄວໆນີ້",
                                              descTextStyle:
                                                  GoogleFonts.notoSansLao(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                              btnOkOnPress: () {})
                                          .show();
                                    },
                                    child: ItemKategori(
                                      title: "ລົດທ່ອງທ່ຽວ",
                                      icon: "assets/icons/electric.png",
                                      style: GoogleFonts.notoSansLao(
                                          // Use camelCase and avoid spaces
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15
                                          // Other text style properties can be added here
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ),
                              const SizedBox(height: 20),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Text(
                                  //   "ຕົວເລືອກຖ້ຽວໂດຍສານສໍາລັບທ່ານ",
                                  //   style: TextStyle(
                                  //     fontSize: 18,
                                  //     fontWeight: FontWeight.bold,
                                  //   ),
                                  // ),
                                  Text(
                                    "ຕົວເລືອກຖ້ຽວໂດຍສານສໍາລັບທ່ານ",
                                    style: GoogleFonts.notoSansLao(
                                        // Use camelCase and avoid spaces
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18
                                        // Other text style properties can be added here
                                        ),
                                  ),
                                 const  Text(
                                    "ທັງໝົດ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    ItemTerbaru(
                                      image: "assets/images/img-1.png",
                                    ),
                                    ItemTerbaru(
                                      image: "assets/images/img-2.png",
                                    ),
                                    ItemTerbaru(
                                      image: "assets/images/img-3.png",
                                    ),
                                    ItemTerbaru(
                                      image: "assets/images/img-1.png",
                                    ),
                                    ItemTerbaru(
                                      image: "assets/images/img-2.png",
                                    ),
                                    ItemTerbaru(
                                      image: "assets/images/img-3.png",
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                        // Navigation
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          height: 60,
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Color.fromARGB(255, 128, 125, 125),
                              ),
                            ),
                          ),
                          // color: Colors.amber,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ItemNav(
                                icon: "beranda",
                                status: true,
                                title: "ໜ້າຫຼັກ",
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Navigate to the "Home" screen when tapped
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ListMyTickets()),
                                  );
                                },
                                child: ItemNav(
                                  icon: "ticket",
                                  status: false,
                                  title: "ປີ້ຂອງຂ້ອຍ",
                                ),
                              ),
                              GestureDetector(
                                // onTap: () {
                                //   Get.offAllNamed(Routes.LOGIN);
                                // },
                                onTap: () {
                                  // Navigate to the "Home" screen when tapped
                                  Navigator.push(
                                      context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) => ProfileScreen()),
                                      // );
                                      PageTransition(
                                        type: PageTransitionType.bottomToTop,
                                        child: ProfileScreen(),
                                      ));
                                },
                                child: ItemNav(
                                  icon: "profile",
                                  status: false,
                                  title: "ບັນຊີຂອງຂ້ອຍ",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }



}

class ItemTerbaru extends StatelessWidget {
  ItemTerbaru({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      width: Get.width * 0.7,
      height: 130,
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
  
}

class ItemKategori extends StatelessWidget {
  ItemKategori({
    Key? key,
    required this.title,
    required this.icon,
    required this.style,
  }) : super(key: key);

  final String title;
  final String icon;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          child: Image.asset(
            icon,
            // color: Color(0xFFF7B731),
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

class ItemNav extends StatelessWidget {
  ItemNav({
    Key? key,
    required this.status,
    required this.icon,
    required this.title,
  }) : super(key: key);

  final bool status;
  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 30,
          child: Image.asset(
            (status == true)
                ? "assets/icons/$icon-active.png"
                : "assets/icons/$icon.png",
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Text(
              status ? "$title" : "$title",
              style: TextStyle(
                color: (status == true)
                    ? Color.fromARGB(255, 103, 32, 236)
                    : Color(0xFF747D8C),
              ),
            ),

            // Text(
            //   "ໜ້າຫຼັກ",
            //   style: TextStyle(
            //     color: (status == true)
            //         ? Color.fromARGB(255, 103, 32, 236)
            //         : Color(0xFF747D8C),
            //   ),
            // ),
          ],
        ),
      ],
    );
  }
}

class StatusCard extends StatelessWidget {
  StatusCard({
    Key? key,
    required this.title,
    required this.data,
    required this.satuan,
  }) : super(key: key);

  final String title;
  final String data;
  final String satuan;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        width: Get.width * 0.25,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            RichText(
              text: TextSpan(
                text: data,
                style: const TextStyle(
                  fontSize: 22,
                  color: Color(0xFFEC2028),
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: " $satuan",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF747D8C),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ClipInfoClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width - 50, size.height);
    path.lineTo(size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class ClipPathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 60,
    );
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
