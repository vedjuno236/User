import 'package:flutter/material.dart';
import 'package:flutter_final/app/modules/bus/views/bus_view.dart';
import 'package:flutter_final/app/modules/profile/profile_screen.dart';
import 'package:flutter_final/app/routes/app_pages.dart';
import 'package:get/get.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: RichText(
          text: TextSpan(
            text: "Hi, ",
            style: TextStyle(
              fontSize: 18,
            ),
            children: [
              TextSpan(
                text: "vedjuno",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.offAllNamed(Routes.LOGIN);
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
                        decoration: BoxDecoration(
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
                                      "assets/icons/kip.png",
                                      height: 30,
                                      width: 30,
                                      color: Color(0xFFF7B731),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
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
                                    SizedBox(width: 10),
                                    Text(
                                      "ຜູ້ຈ່າຍເງີນ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Divider(
                              color: Colors.black,
                            ),
                            SizedBox(height: 10),
                            Row(
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
                                 const Text(
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
                                Text(
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // children: [
                        //   StatusCard(
                        //     title: "Internet",
                        //     data: "12.19",
                        //     satuan: "GB",
                        //   ),
                        //   StatusCard(
                        //     title: "Telepon",
                        //     data: "0",
                        //     satuan: "Min",
                        //   ),
                        //   StatusCard(
                        //     title: "SMS",
                        //     data: "23",
                        //     satuan: "SMS",
                        //   ),
                        // ],
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
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ItemKategori(
                                    title: "ເຄື່ອງບີນ",
                                    icon: "assets/icons/roaming.png",
                                  ),
                                  ItemKategori(
                                    title: "ລົດໄຟ",
                                    icon: "assets/icons/trans.png",
                                  ),
                                  GestureDetector(
                                   
                                    onTap: () {
                                     
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BusView()),
                                      );
                                    },
                                    child: ItemKategori(
                                      title: "ລົດເມ",
                                      icon: "assets/icons/bus.png",
                                    ),
                                  ),
                                  ItemKategori(
                                    title: "ລົດທ່ອງທ່ຽວ",
                                    icon: "assets/icons/electric.png",
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              
                              ),
                              SizedBox(height: 20),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "ຕົວເລືອກຖ້ຽວໂດຍສານສໍາລັບທ່ານ",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
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
                                      image: "assets/images/images-1.png",
                                    ),
                                    ItemTerbaru(
                                      image: "assets/images/images-2.png",
                                    ),
                                    ItemTerbaru(
                                      image: "assets/images/images-1.png",
                                    ),
                                    ItemTerbaru(
                                      image: "assets/images/images-2.png",
                                    ),
                                    ItemTerbaru(
                                      image: "assets/images/images-1.png",
                                    ),
                                    ItemTerbaru(
                                      image: "assets/images/images-2.png",
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
                          height: 80,
                          decoration: BoxDecoration(
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
                                  Get.offAllNamed(Routes.LOGIN);
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
                                    MaterialPageRoute(
                                        builder: (context) => ProfileScreen()),
                                  );
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
  }) : super(key: key);

  final String title;
  final String icon;

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
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            RichText(
              text: TextSpan(
                text: data,
                style: TextStyle(
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
