import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/app/modules/book_tickets/views/book_tickets.dart';
import 'package:flutter_final/app/modules/bus/views/bus_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

import '../../../const/formatter.dart';
import '../../../model/departures_model.dart';
import '../../bus/controllers/bus_controller.dart';

class Search_tickets extends StatelessWidget {
  Search_tickets({Key? key}) : super(key: key);

  final BusController busController = Get.put(BusController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              //
              PageTransition(
                type: PageTransitionType.leftToRight,
                child: BusView(),
              ),
            );
          },
          //  icon: Icons.arrow_back_ios_new,
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
        backgroundColor: Color(0xFFE52D27),
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  busController.departureStation,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Icon(CupertinoIcons.bus, color: Colors.white),
                Text(
                  busController.arrivalStation,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(CupertinoIcons.chevron_left, color: Colors.white),
              // SizedBox(width: 2),
              const Text(
                "ມື້ກ່ອນ",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              Text(
                DateFormat("MM/dd EEEE").format(busController.selectedDate),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),

              const Text(
                "ມື້ຕໍ່ໄປ",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              Icon(CupertinoIcons.chevron_right, color: Colors.white),
            ],
          ),
        ),

        // leading: Icon(Icons.arrow_back_ios),

        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade100,
      body: busController.searchAvailableBusesList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: Image.asset('assets/Backgrounds/ticket.png'),
                  ),
                  Text(
                    'ບໍ່ມີປີ້',
                    style: GoogleFonts.notoSansLao(
                      fontSize: 20,
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            )
          : ListView(
              children: busController.searchAvailableBusesList.map((element) {
                return TicketView(
                  departure: element,
                  busController: busController,
                );
              }).toList(),
            ),
    );
  }
}

class TicketView extends StatelessWidget {
  final Departures departure;
  final BusController busController;

  TicketView({Key? key, required this.departure, required this.busController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24))),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      busController.departureStation,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: Colors.indigo.shade50,
                          borderRadius: BorderRadius.circular(20)),
                      child: SizedBox(
                        height: 8,
                        width: 8,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.indigo.shade400,
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: <Widget>[
                            SizedBox(
                              height: 24,
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  return Flex(
                                    children: List.generate(
                                        (constraints.constrainWidth() / 6)
                                            .floor(),
                                        (index) => SizedBox(
                                              height: 1,
                                              width: 3,
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                    color:
                                                        Colors.grey.shade300),
                                              ),
                                            )),
                                    direction: Axis.horizontal,
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                  );
                                },
                              ),
                            ),
                            Center(
                                child: Transform.rotate(
                              angle: 0,
                              child: Icon(
                                CupertinoIcons.bus,
                                color: Colors.indigo.shade300,
                                size: 24,
                              ),
                            ))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: Colors.pink.shade50,
                          borderRadius: BorderRadius.circular(20)),
                      child: SizedBox(
                        height: 8,
                        width: 8,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.pink.shade400,
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    GetBuilder<BusController>(builder: (_) {
                      return Text(
                        busController.arrivalStation,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink),
                      );
                    })
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          departure.buses.busName,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Column(
                          children: departure.buses.tickets.map((e) {
                            return Row(
                              children: <Widget>[
                                Text(
                                  e.ticketName,
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'ທະບຽນລົດ',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          departure.buses.carnamber,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      DateFormat("hh:mm a", "en-US")
                          .format(departure.routes.departureTime),
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      DateFormat("hh:mm a", "en-US")
                          .format(departure.routes.arrivalTime),
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      formatDuration(departure.routes.departureTime,
                          departure.routes.arrivalTime),
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                     
                   
                  ],
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: Row(
              children: <Widget>[
                SizedBox(
                  height: 20,
                  width: 10,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        color: Colors.grey.shade200),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Flex(
                          children: List.generate(
                              (constraints.constrainWidth() / 10).floor(),
                              (index) => SizedBox(
                                    height: 1,
                                    width: 5,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade400),
                                    ),
                                  )),
                          direction: Axis.horizontal,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                  width: 10,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                        color: Colors.grey.shade200),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24))),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.amber.shade50,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Icon(CupertinoIcons.bus, color: Colors.amber),
                ),
                const SizedBox(
                  width: 16,
                ),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'ເລີ່ມຕົ້ນ',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        Text(
                          "${oCcy.format(departure.buses.tickets.first.price)} ກີບ",
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.red),
                        ),
                      ],
                    ),
                 

                    FutureBuilder<bool>(
                      future: bookingTicket(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else {
                          if (snapshot.hasError || !snapshot.hasData) {
                            return Text("Error: ${snapshot.error}");
                          } else {
                            return Text(snapshot.data! ? 'ມີຫຼາຍ' : 'ມີໜ້ອຍ');
                          }
                        }
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: Builder(
                              builder: (context) =>
                                  BookTickets(departure: departure),
                            ),
                          ),
                        );
                      },

                      child: const Text(
                        "ຈອງ",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                      // ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> bookingTicket() async {
    try {
      DateTime startDate = DateTime(busController.selectedDate.year,
          busController.selectedDate.month, busController.selectedDate.day);
      DateTime endDate = startDate.add(const Duration(days: 1));
      QuerySnapshot capacityQuerySnapshot = await FirebaseFirestore.instance
          .collection('Booking')
          .where('departure_id', isEqualTo: departure.departureId)
          .where('book_date', isGreaterThanOrEqualTo: startDate)
          .where('book_date', isLessThan: endDate)
          .where("ticket_id", isEqualTo: busController.ticket?.ticketId)
          .get();
          
      print('some{$departure.buses.capacity}');
      print('somevip{$departure.buses.capacityvip}');

      int totalCapacity = departure.buses.capacity;
      int totalCapacityVIP = departure.buses.capacityVIP;

      int countCapacity = totalCapacity - capacityQuerySnapshot.size;
      int countCapacityVIP = totalCapacityVIP - capacityQuerySnapshot.size;

      bool isCapacityLow = countCapacity >= 5 || countCapacityVIP >= 5;

      String message = displayMessage(isCapacityLow);
      print('message{$message}');
      return isCapacityLow;
    } catch (e) {
      debugPrint("Booking Ticket Failed!!! :$e");
      return false;
    }
  }

  String displayMessage(bool isCapacityLow) {
    String message = isCapacityLow ? 'ມີຫຼາຍ' : 'ມີໜ້ອຍ';
    print('message{$message}');
    return message;
  }
}
