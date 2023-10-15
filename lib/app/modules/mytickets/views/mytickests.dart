import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/app/modules/home/views/home_view.dart';
import 'package:flutter_final/app/modules/search_tickets/views/search_tickets.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:qr_flutter/qr_flutter.dart';
// import 'package:qr_flutter/qr_flutter.dart';

class Mytickests extends StatefulWidget {
  const Mytickests({Key? key}) : super(key: key);

  @override
  _MytickestsState createState() => _MytickestsState();
}

const Color rColor = Colors.redAccent;
const Color oColor = Colors.orangeAccent;

class _MytickestsState extends State<Mytickests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Colors.red,
                    Colors.red,
                    // rColor.withOpacity(0.8),
                    // rColor,
                    // oColor.withOpacity(0.5),
                    // oColor,
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
                            Text(
                              "ການສໍາລະຊາເລັດ",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                            Text(
                              "ກົດລະບຽບ",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                          ],
                        ),
                        Container(
                          // SingleChildScrollView
                          margin: EdgeInsets.only(top: 50, bottom: 20),
                          width: MediaQuery.of(context).size.width,
                          height: 200,

                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                Colors.white,
                                Colors.white,
                              ],
                            ),
                            // image: DecorationImage(
                            //   image: AssetImage("assets/images/back.png"),
                            //   fit: BoxFit.cover,
                            // ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "ວັນພະຫັດ",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      "1h 27m",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "13:10",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "ລົດຕູ້",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        // Icon(Icons.arrow_back_sharp),
                                        SizedBox(
                                          width: 200, // Set the desired width
                                          height: 20, // Set the desired height
                                          child: Image.asset(
                                              "assets/icons/icon_left.png"),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "14:31",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "ຫຼວງພະບາງ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "ຫຼວງນໍ້າທາ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Search_tickets()),
                                        );
                                      },
                                      child: Container(
                                        width: 150,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: <Color>[
                                              Colors.redAccent,
                                              Colors.orangeAccent,
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        padding: EdgeInsets.all(16.0),
                                        child: Text(
                                          "ຍົກເລີກປີ້",
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
                              ],
                            ),
                            // ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 1, bottom: 5),
                          width: MediaQuery.of(context).size.width,
                          height: 150,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                Colors.orangeAccent,
                                Colors.white,
                              ],
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              topRight: Radius.circular(80),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "ທ ເວດ ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      "100 000 Kip",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "ລົດຕູ້ | ບ່ອນນັ່ງ 1A",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 150,
                                          height: 40,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                  title: Column(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            const Icon(
                                                                Icons.close),
                                                            const Text(
                                                                "QR code"),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 5),
                                                      Text(
                                                        "ທ່ານສາມາດໃຊ້ QR ນີ້ເຂົ້າໄປສະຖານີ ເພື່ອຂື້ນລົດ ຫຼື ໄປທີປ່ອງຂາຍປີ້ເພື່ອແລກເອົາປີ້ເຈ້ຍໄດ້ ກະລຸນາຮັກສາລະຫັດ QR ຂອງທ່ານໃຫ້ດີ",
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                      SizedBox(
                                                        width: 200,
                                                        height: 200,
                                                        child: QrImageView(
                                                          data: 'data',
                                                          version:
                                                              QrVersions.auto,
                                                          size: 50,
                                                        ),
                                                      ),
                                                      SizedBox(height: 5),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "ຊື່ ແລະ ນາມສະກຸນ: ທ ເວດ ທໍາມະວົງ",
                                                            style: TextStyle(
                                                                fontSize: 15),
                                                          ),
                                                          Text(
                                                            "ບັດປະຈໍາຕົວ: 03-19 001361",
                                                            style: TextStyle(
                                                                fontSize: 15),
                                                          ),
                                                          Text(
                                                            "ລົດຕູ້ VIP1 | ບ່ອນນັ່ງ 1",
                                                            style: TextStyle(
                                                                fontSize: 15),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors
                                                    .redAccent // Button background color
                                                ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                SizedBox(
                                                  width: 30,
                                                  child: Image.asset(
                                                    "assets/icons/qrticket.png",
                                                  ),
                                                ),
                                                Text(
                                                  "QR code",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                                Icon(CupertinoIcons.arrow_right)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          margin: EdgeInsets.only(top: 1, bottom: 5),
                          width: MediaQuery.of(context).size.width,
                          height: 170,
                          decoration: DottedDecoration(
                            shape: Shape.box,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "ໝາຍເຫດ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "1 ທ່ານສາມາດເຂົ້າສະຖານີໂດຍໃຊ້ຄິວອາໂຄ້ດໃນປີ້ ຫຼື ປ່ຽນ ເປັນປີ້ເຈົ້າຢູ່ຄູ່ປ່ອງ",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  "2ທ່ານສາມາດບັນທືກຮູບໜ້າຈໍຂໍ້ມູນລົດໃນປະຈຸບັນນີ້ ເພື່ອສະດວກໃນການກວດກາບ່ອນນັ່ງເວລາຂື້ນລົດ",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 1, bottom: 5),
                          width: MediaQuery.of(context).size.width,
                          height: 140,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/img-3.png"),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(10),
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
    );
  }
}
