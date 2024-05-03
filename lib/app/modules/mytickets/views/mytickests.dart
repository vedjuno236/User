import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/app/model/booking_model.dart';
import 'package:flutter_final/app/modules/mytickets/controllers/my_tickets_controller.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../const/formatter.dart';

class Mytickests extends StatefulWidget {
  final BookingModel bookingModel;
  const Mytickests({Key? key, required this.bookingModel}) : super(key: key);

  @override
  _MytickestsState createState() => _MytickestsState();
}

const Color rColor = Colors.redAccent;
const Color oColor = Colors.orangeAccent;

class _MytickestsState extends State<Mytickests> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3.5,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Colors.red,
                    Colors.red,
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
            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(CupertinoIcons.chevron_left,
                                    color: Colors.white),
                              ),
                              const Text(
                                "ການຊໍາລະສໍາເລັດ",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              const Text(
                                "ກົດລະບຽບ",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                            ],
                          ),
                          GetBuilder<MyTicketsController>(
                            builder: (_) {
                              // Check if bookingList is not empty
                              if (_.bookingList.isNotEmpty) {
                                var booking = _.bookingList
                                    .first; // Access the first booking
                                return Column(
                                  children: [
                                    Text(
                                      'ໝາຍເລກສັ່ງຊື້ ${booking.bookingId}',
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                    // Display other information about the booking as needed
                                  ],
                                );
                              } else {
                                // Handle the case when bookingList is empty
                                return Text(
                                  'No bookings available',
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.white),
                                );
                              }
                            },
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
                                        DateFormat("MM/dd EEEE").format(
                                            widget.bookingModel.bookDate),
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        formatDuration(
                                            widget.bookingModel.departures
                                                .routes.departureTime,
                                            widget.bookingModel.departures
                                                .routes.arrivalTime),
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        DateFormat("hh:mm a", "en-US").format(
                                            widget.bookingModel.departures
                                                .routes.departureTime),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            widget.bookingModel.departures.buses
                                                .busName,
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          // Icon(Icons.arrow_back_sharp),
                                          SizedBox(
                                            // Set the desired width
                                            height:
                                                20, // Set the desired height
                                            child: Image.asset(
                                                "assets/icons/icon_left.png"),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        DateFormat("hh:mm a", "en-US").format(
                                            widget.bookingModel.departures
                                                .routes.arrivalTime),
                                        style: TextStyle(
                                            fontSize: 20,
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
                                        widget.bookingModel.departures.routes
                                            .departureStation.stationName,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        widget.bookingModel.departures.routes
                                            .arrivalStation.stationName,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  // GetBuilder<MyTicketsController>(builder: (_) {
                                  //   return _.isCheckQR.isTrue ||
                                  //           widget.bookingModel.status ==
                                  //               "cancel" ||
                                  //           widget.bookingModel.status ==
                                  //               "checked"
                                  //       ? SizedBox()
                                  //       : Row(
                                  //           mainAxisAlignment:
                                  //               MainAxisAlignment.end,
                                  //           children: [
                                  //             GestureDetector(
                                  //               onTap: () async {
                                  //                 await _firestore
                                  //                     .collection("Booking")
                                  //                     .doc(widget.bookingModel
                                  //                         .bookingId)
                                  //                     .update(
                                  //                         {"status": "cancel"});
                                  //                 _.updateBookingList(
                                  //                     widget.bookingModel,
                                  //                     widget.bookingModel
                                  //                         .bookingId,
                                  //                     "cancel");
                                  //               },
                                  //               child: Container(
                                  //                 width: 150,
                                  //                 height: 50,
                                  //                 decoration: BoxDecoration(
                                  //                   gradient: LinearGradient(
                                  //                     colors: <Color>[
                                  //                       Colors.redAccent,
                                  //                       Colors.orangeAccent,
                                  //                     ],
                                  //                   ),
                                  //                   borderRadius:
                                  //                       BorderRadius.circular(
                                  //                           5.0),
                                  //                 ),
                                  //                 padding: EdgeInsets.all(16.0),
                                  //                 child: const Text(
                                  //                   "ຍົກເລີກປີ້",
                                  //                   style: TextStyle(
                                  //                       fontSize: 15,
                                  //                       fontWeight:
                                  //                           FontWeight.bold,
                                  //                       color: Colors.white),
                                  //                   textAlign: TextAlign.center,
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ],
                                  //         );
                                  // }),

                                  // GetBuilder<MyTicketsController>(builder: (_) {
                                  //   return _.isCheckQR.isTrue ||
                                  //           widget.bookingModel.status ==
                                  //               "cancel" ||
                                  //           widget.bookingModel.status ==
                                  //               "checked"
                                  //       ? SizedBox()
                                  //       : Row(
                                  //           mainAxisAlignment:
                                  //               MainAxisAlignment.end,
                                  //           children: [
                                  //             GestureDetector(
                                  //               onTap: () async {
                                  //                 await showDialog(
                                  //                   context: context,
                                  //                   builder: (context) =>
                                  //                       AlertDialog(
                                  //                     actions: [
                                  //                       TextButton(
                                  //                         onPressed: () {
                                  //                           Navigator.of(
                                  //                                   context)
                                  //                               .pop();
                                  //                         },
                                  //                         child: Text('ອອກ'),
                                  //                       ),

                                  //                       Text('ຕົກລົງ')
                                  //                     ],
                                  //                     contentPadding:
                                  //                         EdgeInsets.all(20.0),
                                  //                     content: Text(
                                  //                         'ທ່ານຕ້ອງການຍົກເລີກປີ້ແມ່ນບໍ່'),
                                  //                   ),
                                  //                 );
                                  //                 // await _firestore
                                  //                 //     .collection("Booking")
                                  //                 //     .doc(widget.bookingModel
                                  //                 //         .bookingId)
                                  //                 //     .update(
                                  //                 //         {"status": "cancel"});
                                  //                 // _.updateBookingList(
                                  //                 //     widget.bookingModel,
                                  //                 //     widget.bookingModel
                                  //                 //         .bookingId,
                                  //                 //     "cancel");
                                  //               },
                                  //               child: Container(
                                  //                 width: 150,
                                  //                 height: 50,
                                  //                 decoration: BoxDecoration(
                                  //                   gradient: LinearGradient(
                                  //                     colors: <Color>[
                                  //                       Colors.redAccent,
                                  //                       Colors.orangeAccent,
                                  //                     ],
                                  //                   ),
                                  //                   borderRadius:
                                  //                       BorderRadius.circular(
                                  //                           5.0),
                                  //                 ),
                                  //                 padding: EdgeInsets.all(16.0),
                                  //                 child: const Text(
                                  //                   "ຍົກເລີກປີ້",
                                  //                   style: TextStyle(
                                  //                     fontSize: 15,
                                  //                     fontWeight:
                                  //                         FontWeight.bold,
                                  //                     color: Colors.white,
                                  //                   ),
                                  //                   textAlign: TextAlign.center,
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ],
                                  //         );
                                  // }),

                                  GetBuilder<MyTicketsController>(
                                    builder: (_) {
                                      return _.isCheckQR.isTrue ||
                                              widget.bookingModel.status ==
                                                  "cancel" ||
                                              widget.bookingModel.status ==
                                                  "checked"
                                          ? SizedBox()
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.defaultDialog(
                                                      title:
                                                          "ທ່ານຕ້ອງການຍົກເລີກປີ້ແມ່ນບໍ່",
                                                      titleStyle:
                                                          const TextStyle(
                                                              fontSize: 15,
                                                              color: Colors
                                                                  .redAccent),
                                                      content: Container(),
                                                      textConfirm: "ຕົກລົງ",
                                                      textCancel: "ອອກ",
                                                      confirmTextColor:
                                                          Colors.white,
                                                      onConfirm: () async {
                                                        await _firestore
                                                            .collection(
                                                                "Booking")
                                                            .doc(widget
                                                                .bookingModel
                                                                .bookingId)
                                                            .update({
                                                          "status": "cancel"
                                                        });
                                                        _.updateBookingList(
                                                            widget.bookingModel,
                                                            widget.bookingModel
                                                                .bookingId,
                                                            "cancel");
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      onCancel: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
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
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                    padding:
                                                        EdgeInsets.all(16.0),
                                                    child: const Text(
                                                      "ຍົກເລີກປີ້",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                    },
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
                                        widget.bookingModel.passenger.username,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        "${oCcy.format(widget.bookingModel.ticket.price)} KIP",
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
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "${widget.bookingModel.departures.buses.busName} | ບ່ອນນັ່ງ ${widget.bookingModel.seat}",
                                        style: const TextStyle(
                                            fontSize: 15, color: Colors.white),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 140,
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
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: const Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Icon(Icons.close),
                                                              Text("QR code"),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(height: 5),
                                                        Text(
                                                          "ທ່ານສາມາດໃຊ້ QR ນີ້ເຂົ້າໄປສະຖານີ ເພື່ອຂື້ນລົດ ຫຼື ໄປທີປ່ອງຂາຍປີ້ເພື່ອແລກເອົາປີ້ເຈ້ຍໄດ້ ກະລຸນາຮັກສາລະຫັດ QR ຂອງທ່ານໃຫ້ດີ",
                                                          style: TextStyle(
                                                              fontSize: 15),
                                                        ),
                                                        GetBuilder<
                                                                MyTicketsController>(
                                                            builder: (_) {
                                                          return SizedBox(
                                                            width: 200,
                                                            height: 200,
                                                            child: Stack(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              children: [
                                                                // QrImageView
                                                                QrImageView(
                                                                  data:
                                                                      "www.google.com", // Replace with your QR code data
                                                                  size: 250,
                                                                ),
                                                                _.isCheckQR.isTrue ||
                                                                        widget.bookingModel.status ==
                                                                            "checked"
                                                                    ? Icon(
                                                                        Icons
                                                                            .check,
                                                                        size:
                                                                            100,
                                                                        color: Colors
                                                                            .green,
                                                                      )
                                                                    : SizedBox()
                                                              ],
                                                            ),
                                                          );
                                                        }),
                                                        SizedBox(height: 5),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "ຊື່ ແລະ ນາມສະກຸນ: ${widget.bookingModel.passenger.username}",
                                                              style: TextStyle(
                                                                  fontSize: 15),
                                                            ),
                                                            Text(
                                                              "ບັດປະຈໍາຕົວ: ${widget.bookingModel.passenger.idCard}",
                                                              style: TextStyle(
                                                                  fontSize: 15),
                                                            ),
                                                            Text(
                                                              "${widget.bookingModel.departures.buses.busName} | ບ່ອນນັ່ງ ${widget.bookingModel.seat}",
                                                              style: TextStyle(
                                                                  fontSize: 15),
                                                            ),
                                                            GetBuilder<
                                                                    MyTicketsController>(
                                                                builder: (_) {
                                                              return _.isCheckQR
                                                                          .isTrue ||
                                                                      widget.bookingModel
                                                                              .status ==
                                                                          "checked"
                                                                  ? const SizedBox()
                                                                  : SizedBox(
                                                                      height:
                                                                          45,
                                                                      width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                      child:
                                                                          ElevatedButton(
                                                                        onPressed:
                                                                            () async {
                                                                          _.setCheckQR(
                                                                              true);
                                                                          await _firestore
                                                                              .collection(
                                                                                  "Booking")
                                                                              .doc(widget
                                                                                  .bookingModel.bookingId)
                                                                              .update({
                                                                            "status":
                                                                                "checked"
                                                                          });
                                                                          _.updateBookingList(
                                                                              widget.bookingModel,
                                                                              widget.bookingModel.bookingId,
                                                                              "checked");
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          "ທົດລອງສະແກນສຳເລັດ",
                                                                          style: TextStyle(
                                                                              fontSize: 16,
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          backgroundColor:
                                                                              Colors.blueAccent,
                                                                        ),
                                                                      ),
                                                                    );
                                                            }),
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
                                                    MainAxisAlignment
                                                        .spaceAround,
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
                                                  Icon(CupertinoIcons
                                                      .arrow_right)
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
            ),
          ],
        ),
      ),
    );
  }
}
