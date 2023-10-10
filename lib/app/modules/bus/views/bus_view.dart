import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/app/modules/home/views/home_view.dart';
import 'package:flutter_final/app/modules/search_tickets/views/search_tickets.dart';
import 'package:get/get.dart';
// import 'package:mytsel/app/modules/home/views/home_view.dart';
// import 'package:mytsel/app/modules/search_tickets/views/search_tickets.dart';
// import 'package:mytsel/app/routes/app_pages.dart';

// import '../controllers/search_controller.dart';

class BusView extends StatefulWidget {
  const BusView({Key? key}) : super(key: key);

  @override
  _BusViewState createState() => _BusViewState();
}

const Color pColor = Color(0xFFEC2028);

class _BusViewState extends State<BusView> {
  DateTime selectedDate = DateTime.now();
  // final FocusNode _focus = FocusNode();
  // final FocusNode _focusNode = FocusNode();
  // @override
  // void initState() {
  //   super.initState();
  //   _focus.addListener(_onFocusChange);
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _focus.removeListener(_onFocusChange);
  //   _focus.dispose();
  // }
  // void _onFocusChange() {
  //   Get.offAllNamed('/search_to'); // Navigate to the '/search_to' route
  //   // Get.offAllNamed('/search_form'); // Navigate to the '/search_form' route
  // }

  // void _onFocusChange2() {
  //   Get.offAllNamed('/search_form'); // Navigate to the '/search_to' route
  //   // Get.offAllNamed('/search_form'); // Navigate to the '/search_form' route
  // }

  final FocusNode _focus = FocusNode();
  final FocusNode _focusN = FocusNode();

  @override
  void initState() {
    super.initState();

    _focus.addListener(_onFocusChange);
    _focusN.addListener(_onFocusChange2);
  }

  @override
  void dispose() {
    super.dispose();

    _focus.removeListener(_onFocusChange);
    _focus.dispose();

    _focusN.removeListener(_onFocusChange2);
    _focusN.dispose();
  }

  void _onFocusChange() {
    Get.offAllNamed('/search_to');
  }

  void _onFocusChange2() {
    Get.offAllNamed('/search_form');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white60,
      body: Container(
        // color: Colors.white70,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3.5,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      pColor.withOpacity(0.8),
                      pColor,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeView()),
                                  );
                                },
                                child: Icon(CupertinoIcons.chevron_left,
                                    color: Colors.white),
                              ),
                              Icon(
                                CupertinoIcons.bus,
                                color: Colors.white,
                              )
                            ],
                          ),
                          // Icon(CupertinoIcons.chevron_left, color: Colors.white),
                          Container(
                            // SingleChildScrollView
                            margin: EdgeInsets.only(top: 50, bottom: 20),
                            width: MediaQuery.of(context).size.width,
                            height: 250,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  spreadRadius: 3,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _onFocusChange2();
                                    },
                                    child: TextField(
                                      focusNode: _focusN,
                                      decoration: InputDecoration(
                                        hintText: "ໄຊຍະບູລີ",
                                        hintStyle: TextStyle(fontSize: 15),
                                        prefixIcon: Icon(
                                          CupertinoIcons.circle_filled,
                                          size: 10.0,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _onFocusChange();
                                    },
                                    child: TextField(
                                      focusNode: _focus,
                                      decoration: InputDecoration(
                                        hintText: "ຫຼວງພະບາງ",
                                        hintStyle: TextStyle(fontSize: 15),
                                        prefixIcon: Icon(
                                          CupertinoIcons.circle_filled,
                                          size: 10.0,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // SizedBox(height: 40),
                                  SizedBox(height: 30),
                                  GestureDetector(
                                    onTap: () async {
                                      final DateTime? dateTime =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: selectedDate,
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(3000),
                                      );
                                      if (dateTime != null) {
                                        setState(() {
                                          selectedDate = dateTime;
                                        });
                                      }
                                    },
                                    child: Text(
                                      "${selectedDate.day} -${selectedDate.month} -${selectedDate.year}",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),

                                  SizedBox(height: 20),
                                  Column(
                                    children: [
                                      SizedBox(
                                        width:
                                            350, // Set the width of the SizedBox
                                        height:
                                            50, // Set the height of the SizedBox
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Search_tickets()),
                                            );
                                            // Add your button click logic here
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Color(
                                                0xFFEC2028), // Button background color
                                          ),
                                          //  Color(0xFFEC2028);
                                          child: Text(
                                            'ກວດສອບປີ້',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "ຄົ້ນຫາລ້າສຸດຂອງທ່ານ",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "ລົບທັງໝົດ",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      height: 500,
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: 140,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    // blurRadius: 1,
                                    // spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "ໄຊຍະບູລີ",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Icon(CupertinoIcons.arrow_right),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          "ຫຼວງພະບາງ",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        // SizedBox(
                                        //   height: 20,
                                        // ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    //  mainAxisAlignment: MainAxisAlignment.start,

                                    Text(
                                      "${selectedDate.day} -${selectedDate.month} -${selectedDate.year}",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
