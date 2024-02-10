import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/app/modules/book_tickets/controller/book_ticket_controller.dart';
import 'package:flutter_final/app/modules/bus/controllers/bus_controller.dart';
import 'package:flutter_final/app/modules/home/views/home_view.dart';
import 'package:flutter_final/app/modules/mytickets/views/list_my_tickets.dart';
import 'package:flutter_final/app/modules/profile/profile_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:external_app_launcher/external_app_launcher.dart';

import '../../../const/app_info.dart';
import '../../login/controllers/login_controller.dart';

class BcelPaymentPage extends StatefulWidget {
  const BcelPaymentPage({Key? key}) : super(key: key);

  @override
  State<BcelPaymentPage> createState() => _BcelPaymentPageState();
}

class _BcelPaymentPageState extends State<BcelPaymentPage> {
  late BookTicketController bookTicketController;
  late LoginController loginController;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late BusController busController;
  @override
  void initState() {
    bookTicketController = Get.put(BookTicketController());
    busController = Get.put(BusController());
    loginController = Get.put(LoginController());
    super.initState();
  }

  Future<bool> bookingTicket() async {
    try {
      DateTime startDate = DateTime(busController.selectedDate.year,
          busController.selectedDate.month, busController.selectedDate.day);

      DateTime endDate = startDate.add(const Duration(days: 1));

      QuerySnapshot capacityQuerySnapshot = await FirebaseFirestore.instance
          .collection('Booking')
          .where('departure_id',
              isEqualTo: busController.departure?.departureId)
          .where('book_date', isGreaterThanOrEqualTo: startDate)
          .where('book_date', isLessThan: endDate)
          .where("ticket_id", isEqualTo: busController.ticket?.ticketId)
          .get();

      int countCapacity = busController.departure!.buses.capacity <= 0
          ? 10000
          : capacityQuerySnapshot.size;

      if (countCapacity + (loginController.checkedPassenger.length) >
          busController.departure!.buses.capacity) {
        Get.showSnackbar(const GetSnackBar(
          title: "ບ່ອນນັ່ງບໍ່ພຽງພໍ",
        ));
        return false;
      }

      await _firestore.runTransaction((transaction) async {
        List<String> bookingListId = [];
        //add Data To Cloud FireStore
        DocumentReference doc = await _firestore.collection("Booking").add({
          "user_id": FirebaseAuth.instance.currentUser?.uid,
          'passenger_id': loginController.passenger?.passengerId,
          "departure_id": busController.departure?.departureId,
          "seat": "${countCapacity += 1}",
          "status": "pending",
          "ticket_id": busController.ticket?.ticketId,
          "book_date": Timestamp.fromDate(busController.selectedDate),
          "expired_time": Timestamp.fromDate(
              busController.selectedDate.add(const Duration(days: 1)))
        });

        bookingListId.add(doc.id);

        for (var element in loginController.checkedPassenger.keys) {
          DocumentReference doc = await _firestore.collection("Booking").add({
            "user_id": FirebaseAuth.instance.currentUser?.uid,
            'passenger_id': element,
            "departure_id": busController.departure?.departureId,
            "seat": "${countCapacity += 1}",
            "status": "pending",
            "ticket_id": busController.ticket?.ticketId,
            "book_date": Timestamp.fromDate(busController.selectedDate),
            "expired_time": Timestamp.fromDate(
                busController.selectedDate.add(const Duration(days: 1)))
          });

          bookingListId.add(doc.id);
        }

        await _firestore.collection("Payment").add({
          "user_id": FirebaseAuth.instance.currentUser?.uid,
          'booking_id': bookingListId,
          "pay_date": Timestamp.fromDate(DateTime.now()),
          "total":
              "${(busController.ticket!.price * (loginController.checkedPassenger.length)) + (busController.ticket!.bookingPrice * (loginController.checkedPassenger.length))}",
          "payment_method": "bcel_one",
          "description": "ຈອງປີ້"
        });
      });

      return true;
    } catch (e) {
      debugPrint("Booking Ticket Failed!!! :$e");
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        Navigator.of(context).pop("ok");
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
          title: const Text(
            "ການຊໍາລະ",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: GetBuilder<BookTicketController>(builder: (_) {
          return ListView(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 60),
            children: [
              Text(
                _.isPaid
                    ? "QR Code ນີ້ຊຳລະເງິນແລ້ວ"
                    : "ສະແກນ QR Code ນີ້ເພື່ອຊຳລະເງິນ",
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 250,
                    width: 250,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.red, width: 2),
                      // color: Colors.grey
                    ),
                    child: _.isPaid
                        ? Container(
                            width: 100,
                            height: 100,
                            padding: const EdgeInsets.all(8),
                            child: SvgPicture.asset(
                              "assets/icons/checkmark_circle.svg",
                              color: Colors.green,
                            ))
                        : QrImageView(
                            data: "www.google.com",
                            size: 250,
                            backgroundColor: Colors.white,
                          ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "ສາມາດເປີດແອັບ BCEL ONE ໄດ້ໂດຍກົມປຸ່ມລຸ່ມນີ້",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    if (!_.isPaid) {
                      /// check bcel one app is installed in device
                      final _isInstalled = await LaunchApp.isAppInstalled(
                        androidPackageName: 'com.bcel.bcelone',
                        iosUrlScheme:
                            'itms-apps://itunes.apple.com/app/id654946527',
                      );

                      if (_isInstalled) {
                        /// open bcel one app
                        await launchUrl(
                          Uri.parse("www.google.com"),
                        );
                      } else {
                        /// open bcel one link on store
                        if (Platform.isIOS) {
                          await launchUrl(Uri.parse(APP_STORE));
                        } else {
                          await launchUrl(Uri.parse(PLAY_STORE));
                        }
                      }
                    } else {
                      Navigator.pop(context);
                      Navigator.of(context).pop("ok");
                      _.setIsPaid(false);
                    }
                  },
                  child: Text(
                    _.isPaid ? "ການຊໍາລະເງິນສໍາເລັດ" : "ເປີດ BCEL ONE",
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_.isPaid == false) {
                      bool isPaid = await bookingTicket();
                      _.setIsPaid(isPaid);
                    }
                    String? token = await FirebaseMessaging.instance.getToken();
                    print(token);
                  },
                  child: const Text(
                    "ທົດລອງການຊໍາລະເງິນສໍາເລັດ",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "ໝາຍເຫດ: ຖ້າຫາກທ່ານເປີດແອັບ BCEL ONE ໂດຍກົດປຸ່ມຂ້າງເທິງນີ້ກະລຸນາກັບມາໜ້ານີ້ທັນທີຫຼັງຈາກຊຳລະສຳເລັດ",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.deepOrangeAccent,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          );
        }),
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
      ),
    );
  }
}
