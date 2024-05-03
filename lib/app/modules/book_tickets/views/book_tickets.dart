import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/app/modules/book_tickets/views/reservation_form.dart';
// import 'package:flutter_final/app/modules/search_tickets/views/search_tickets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

import '../../../const/formatter.dart';
import '../../../model/departures_model.dart';
import '../../bus/controllers/bus_controller.dart';

class BookTickets extends StatefulWidget {
  final Departures? departure;
  const BookTickets({Key? key, this.departure}) : super(key: key);

  @override
  _BookTicketsState createState() => _BookTicketsState();
}

class _BookTicketsState extends State<BookTickets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // systemOverlayStyle:
        // SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),

        // brightness: Brightness.light,
        backgroundColor: Colors.red,
        centerTitle: true,
        title: const Text(
          'ລາຍລະອຽດລົດ',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),

        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade200,
      body: ListView(
        // itemCount: 10,
        // padding: EdgeInsets.only(top: 8, bottom: 8),
        // itemBuilder: (context, index) {
        //   return TicketView();
        // }
        children: [
          TicketView(
            departure: widget.departure!,
          ),
        ],
      ),
    );
  }
}

class TicketView extends StatelessWidget {
  final Departures departure;
  final BusController busController = Get.put(BusController());
  TicketView({Key? key, required this.departure}) : super(key: key);
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
                    SizedBox(
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
                    Text(
                      busController.arrivalStation,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink),
                    )
                  ],
                ),
                new Divider(color: Colors.black12),
                SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                        width: 100,
                        child: Text(
                          "",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        )),
                    Text(
                      DateFormat("MM/dd EEEE")
                          .format(busController.selectedDate),
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(
                        width: 100,
                        child: Text(
                          "",
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        )),
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
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      formatDuration(departure.routes.departureTime,
                          departure.routes.arrivalTime),
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const Row(
                      children: <Widget>[
                        Text(
                          " ",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Text(
                          "",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
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
            child: Column(
              children: departure.buses.tickets.map((e) {
                return Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      // padding: EdgeInsets.all(8),
                      // decoration: BoxDecoration(
                      //     color: Colors.amber.shade50,
                      //     borderRadius: BorderRadius.circular(20)),
                      // child: Icon(CupertinoIcons.bus, color: Colors.amber),
                      child: Text(
                        e.ticketName,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text("${oCcy.format(e.price)} LAK",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.redAccent)),
                    GetBuilder<BusController>(builder: (_) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ElevatedButton(
                            onPressed: () {
                              busController.setTicket(e);
                              busController.setDeparture(departure);
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: Builder(
                                    builder: (context) => ReservationForm(
                                      departure: departure,
                                      ticket: e,
                                    ),
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
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: Colors.red),
                              )),
                            ),
                            // ),
                          ),
                        ),
                      );
                    }),
                  ],
                );
                //new Divider(color: Colors.black12),
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
