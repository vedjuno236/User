import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/app/model/booking_model.dart';
import 'package:flutter_final/app/modules/home/views/home_view.dart';
import 'package:flutter_final/app/modules/mytickets/controllers/my_tickets_controller.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter_final/app/modules/mytickets/views/list_my_tickets.dart';
import 'package:flutter_final/app/modules/profile/views/profile_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../const/formatter.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

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

  String qrData = '';
  @override
  void initState() {
    super.initState();
    fetchDataFromFirestore();
  }

  void fetchDataFromFirestore() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('Payment').get();

    if (snapshot.docs.isNotEmpty) {
      QueryDocumentSnapshot firstDocument = snapshot.docs.first;
      Map<String, dynamic>? data =
          firstDocument.data() as Map<String, dynamic>?;

      if (data != null) {
        String paymentId = firstDocument.id;
        setState(() {
          qrData = ' $paymentId';
        });
      } else {
        setState(() {
          qrData = '';
        });
      }
    } else {
      setState(() {
        qrData = '';
      });
    }
    print('qrData: $qrData');
  }

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
                                child: const Icon(CupertinoIcons.chevron_left,
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
                          const SizedBox(height: 10),
                          RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'ໝາຍເລກສັ່ງຊື້ :',
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: ' ${widget.bookingModel.bookingId}\n',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                                const TextSpan(
                                  text: 'ເວລາສັ່ງຊື້ :',
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.black),
                                ),
                                TextSpan(
                                  text:
                                      '${DateFormat('dd-MM-yyyy ').format(widget.bookingModel.bookDate)}:  ',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                                TextSpan(
                                  text: '${DateFormat(
                                    "hh:mm:ss",
                                  ).format(widget.bookingModel.time)}', // Use getlaosTime() to get the time in Laos timezone
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // SingleChildScrollView
                            margin: const EdgeInsets.only(top: 50, bottom: 20),
                            width: MediaQuery.of(context).size.width,
                            height: 200,

                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
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
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        formatDuration(
                                            widget.bookingModel.departures
                                                .routes.departureTime,
                                            widget.bookingModel.departures
                                                .routes.arrivalTime),
                                        style: const TextStyle(fontSize: 15),
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
                                            style:
                                                const TextStyle(fontSize: 15),
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
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.bookingModel.departures.routes
                                            .departureStation.stationName,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        widget.bookingModel.departures.routes
                                            .arrivalStation.stationName,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),

                                  // GetBuilder<MyTicketsController>(
                                  //   builder: (_) {
                                  //     return _.isCheckQR.isTrue ||
                                  //             widget.bookingModel.status ==
                                  //                 "cancel" ||
                                  //             widget.bookingModel.status ==
                                  //                 "checked"
                                  //         ? SizedBox()
                                  //         : Row(
                                  //             mainAxisAlignment:
                                  //                 MainAxisAlignment.end,
                                  //             children: [
                                  //               GestureDetector(
                                  //                 onTap: () {
                                  //                   AwesomeDialog(
                                  //                     context: context,
                                  //                     animType: AnimType.scale,
                                  //                     dialogType:
                                  //                         DialogType.info,
                                  //                     body: Center(
                                  //                       child: Text(
                                  //                         'ທ່ານຕ້ອງການຍົກເລີກປີ້ແມ່ນບໍ່.',
                                  //                         style: GoogleFonts
                                  //                             .notoSansLao(
                                  //                                 fontSize: 15),
                                  //                       ),
                                  //                     ),
                                  //                     btnCancelOnPress: () {},
                                  //                     btnOkOnPress: () async {
                                  //                       await _firestore
                                  //                           .collection(
                                  //                               "Booking")
                                  //                           .doc(widget
                                  //                               .bookingModel
                                  //                               .bookingId)
                                  //                           .update({
                                  //                         "status": "cancel"
                                  //                       });
                                  //                       _.updateBookingList(
                                  //                           widget.bookingModel,
                                  //                           widget.bookingModel
                                  //                               .bookingId,
                                  //                           "cancel");
                                  //                       Navigator.of(context)
                                  //                           .pop();
                                  //                     },
                                  //                   )..show();

                                  Obx(
                                    () {
                                      final myController =
                                          Get.find<MyTicketsController>();
                                      return myController.isCheckQR.isTrue ||
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
                                                    AwesomeDialog(
                                                      context: context,
                                                      animType: AnimType.scale,
                                                      dialogType:
                                                          DialogType.info,
                                                      body: Center(
                                                        child: Text(
                                                          'ທ່ານຕ້ອງການຍົກເລີກປີ້ແມ່ນບໍ່.',
                                                          style: GoogleFonts
                                                              .notoSansLao(
                                                                  fontSize: 15),
                                                        ),
                                                      ),
                                                      btnCancelOnPress: () {},
                                                      btnOkOnPress: () async {
                                                        await _firestore
                                                            .collection(
                                                                "Booking")
                                                            .doc(widget
                                                                .bookingModel
                                                                .bookingId)
                                                            .update({
                                                          "status": "cancel"
                                                        });
                                                        myController
                                                            .updateBookingList(
                                                          widget.bookingModel,
                                                          widget.bookingModel
                                                              .bookingId,
                                                          "cancel",
                                                        );
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ).show();
                                                  },
                                                  child: Container(
                                                    width: 150,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      gradient:
                                                          const LinearGradient(
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
                                                        const EdgeInsets.all(
                                                            16.0),
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
                            margin: const EdgeInsets.only(top: 1, bottom: 5),
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                            decoration: const BoxDecoration(
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
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        "${oCcy.format(widget.bookingModel.ticket.price)} KIP",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${widget.bookingModel.departures.buses.busName} | ບ່ອນນັ່ງ ${widget.bookingModel.seat}",
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            "ທະບຽນລົດ ${widget.bookingModel.departures.buses.carnamber} ",
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ),
                                        ],
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
                                                          child: Column(
                                                            children: [
                                                              const Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Icon(Icons
                                                                      .close),
                                                                  Text(
                                                                    "QR code",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          17,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Text(
                                                                widget
                                                                    .bookingModel
                                                                    .bookingId,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 17,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                        Obx(() {
                                                          final myController =
                                                              Get.find<
                                                                  MyTicketsController>();

                                                          return SizedBox(
                                                            width: 200,
                                                            height: 200,
                                                            child: Stack(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              children: [
                                                                QrImageView(
                                                                  data: widget
                                                                      .bookingModel
                                                                      .bookingId,
                                                                  version:
                                                                      QrVersions
                                                                          .auto,
                                                                  size: 250,
                                                                ),
                                                                myController.isCheckQR
                                                                            .isTrue ||
                                                                        widget.bookingModel.status ==
                                                                            "checked"
                                                                    ? const Icon(
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
                                                        const SizedBox(
                                                            height: 5),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                Text(
                                                                  widget
                                                                      .bookingModel
                                                                      .departures
                                                                      .routes
                                                                      .departureStation
                                                                      .stationName,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                SizedBox(
                                                                  height: 20,
                                                                  child: Image
                                                                      .asset(
                                                                          "assets/icons/icon_left.png"),
                                                                ),
                                                                Text(
                                                                  widget
                                                                      .bookingModel
                                                                      .departures
                                                                      .routes
                                                                      .arrivalStation
                                                                      .stationName,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                const Text(
                                                                  "ເວລາອອກເດີນທາງ  :",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                Text(
                                                                  DateFormat(
                                                                          "EEEE/dd/MM/yyyy")
                                                                      .format(widget
                                                                          .bookingModel
                                                                          .bookDate),
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ],
                                                            ),
                                                            Text(
                                                              "ຊື່ ແລະ ນາມສະກຸນ: ${widget.bookingModel.passenger.username}",
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          15),
                                                            ),
                                                            Text(
                                                              "ບັດປະຈໍາຕົວ: ${widget.bookingModel.passenger.idCard}",
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          15),
                                                            ),
                                                            Text(
                                                              "${widget.bookingModel.departures.buses.busName} | ບ່ອນນັ່ງ ${widget.bookingModel.seat}",
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          15),
                                                            ),
                                                            Text(
                                                              ' ${widget.bookingModel.bookingId}',
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  DateFormat(
                                                                    "hh:mm:ss  :",
                                                                  ).format(widget
                                                                      .bookingModel
                                                                      .time),
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        15, // Adjust the font size as needed
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    width: 5),
                                                                Text(
                                                                  DateFormat(
                                                                          "dd/MM/yyyy")
                                                                      .format(widget
                                                                          .bookingModel
                                                                          .time),
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ],
                                                            ),
                                                            Obx(() {
                                                              final myController =
                                                                  Get.find<
                                                                      MyTicketsController>();

                                                              return myController
                                                                          .isCheckQR
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
                                                                          myController
                                                                              .setCheckQR(true);
                                                                          await _firestore
                                                                              .collection(
                                                                                  "Booking")
                                                                              .doc(widget
                                                                                  .bookingModel.bookingId)
                                                                              .update({
                                                                            "status":
                                                                                "checked"
                                                                          });
                                                                          myController.updateBookingList(
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
                                                            })
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.redAccent),
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
                                                  const Text(
                                                    "QR code",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
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
                          const SizedBox(height: 5),
                          Container(
                            margin: const EdgeInsets.only(top: 1, bottom: 5),
                            width: MediaQuery.of(context).size.width,
                            height: 170,
                            decoration: DottedDecoration(
                              shape: Shape.box,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
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
                            margin: const EdgeInsets.only(top: 1, bottom: 5),
                            width: MediaQuery.of(context).size.width,
                            height: 140,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
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
              color: Colors.redAccent,
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
}
