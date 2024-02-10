import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_final/app/modules/book_tickets/controller/book_ticket_controller.dart';
import 'package:flutter_final/app/modules/book_tickets/views/add_passengers.dart';
// import 'package:flutter_final/app/modules/book_tickets/views/book_tickets.dart';
import 'package:flutter_final/app/modules/book_tickets/views/payment.dart';
import 'package:flutter_final/app/modules/bus/controllers/bus_controller.dart';
import 'package:flutter_final/app/modules/login/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../const/formatter.dart';
import '../../../model/departures_model.dart';
import '../../../model/ticket_model.dart';
// import '../../bus/controllers/bus_controller.dart';

class ReservationForm extends StatefulWidget {
  final Departures departure;
  final Ticket ticket;
  const ReservationForm(
      {Key? key, required this.departure, required this.ticket})
      : super(key: key);

  @override
  _ReservationFormState createState() => _ReservationFormState();
}

class _ReservationFormState extends State<ReservationForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: const Text(
          'ຂຽນໃສ່ໃບຈອງປີ້',
          style: TextStyle(
            color: Colors.white,
          ),
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
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24))),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            GetBuilder<BusController>(builder: (_) {
                              return Text(
                                _.departureStation,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo),
                              );
                            }),
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
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Stack(
                                      children: [
                                        SizedBox(
                                          height: 24,
                                          child: LayoutBuilder(
                                            builder: (context, constraints) {
                                              return Flex(
                                                children: List.generate(
                                                    (constraints.constrainWidth() /
                                                            6)
                                                        .floor(),
                                                    (index) => SizedBox(
                                                          height: 1,
                                                          width: 3,
                                                          child: DecoratedBox(
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade300),
                                                          ),
                                                        )),
                                                direction: Axis.horizontal,
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
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
                                ],
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
                                _.arrivalStation,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pink),
                              );
                            })
                          ],
                        ),
                        new Divider(color: Colors.black12),
                        SizedBox(
                          height: 4,
                        ),
                        SizedBox(
                          height: 60,
                          width: double.infinity,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 238, 235, 235),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${widget.departure.buses.busName}',
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${widget.ticket.ticketName}',
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat("hh:mm a", "en-US").format(
                                  widget.departure.routes.departureTime),
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              DateFormat("hh:mm a", "en-US")
                                  .format(widget.departure.routes.arrivalTime),
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              formatDuration(
                                  widget.departure.routes.departureTime,
                                  widget.departure.routes.arrivalTime),
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Row(
                      children: [
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
                                      (constraints.constrainWidth() / 10)
                                          .floor(),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                                color: Colors.grey.shade200),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GetBuilder<LoginController>(builder: (_) {
                    return Container(
                      padding: EdgeInsets.only(left: 16, right: 16, bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24),
                        ),
                      ),
                      child: Column(
                        children: [
                          // Row(
                          //   children: [
                          //     Text(
                          //       '  ${_.passenger?.username} ',
                          //       style: TextStyle(fontSize: 18),
                          //     ),
                          //     SizedBox(width: 5),
                          //     Text(
                          //       '  ${_.passenger?.isAdult()} ',
                          //       style: TextStyle(
                          //         fontSize: 18,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(height: 5),
                          // Row(
                          //   children: [
                          //     Text(
                          //       'ບັດປະຈໍາຕົວ',
                          //       style: TextStyle(fontSize: 18),
                          //     ),
                          //     SizedBox(width: 5),
                          //     Text(
                          //       '${_.passenger?.idCard}',
                          //       style: TextStyle(fontSize: 18),
                          //     ),
                          //   ],
                          // ),

                          for (var entry in _.checkedPassenger.entries)
                            if (entry.value)
                              Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Divider(),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '  ${_.passengerList.firstWhere((element) => element.passengerId == entry.key).username} ',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        '  ${_.passengerList.firstWhere((element) => element.passengerId == entry.key).isAdult()} ',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        'ບັດປະຈໍາຕົວ',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        '${_.passengerList.firstWhere((element) => element.passengerId == entry.key).idCard}',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                          // const Row(
                          //   mainAxisAlignment: MainAxisAlignment.end,
                          //   children: [
                          //     Icon(Icons.delete),
                          //   ],
                          // ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  'ເລືອກປະເພດຜູ້ໂດຍສານ ',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddPassengers()),
                                  );
                                },
                                child: const Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.add_circled,
                                      color: Colors.redAccent,
                                      size: 24,
                                    ),
                                    Text("ເພີ່ມຜູ້ໂດຍສານ",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.redAccent)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Container(
                margin: EdgeInsets.only(top: 1, bottom: 5),
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: DottedDecoration(
                  shape: Shape.box,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "ຂໍ້ມູນຮັບປີ້",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      // Text(
                      // busController.departureStation,
                      // style:const  TextStyle(
                      //     fontSize: 18,
                      //     fontWeight: FontWeight.bold,
                      //     color: Colors.white),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Payment(
                            departure: widget.departure,
                            ticket: widget.ticket,
                          )),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: double.infinity,
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: <Color>[
                        Colors.redAccent,
                        Colors.orangeAccent,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: const Text(
                    "ຂັ້ນຕອນຕໍ່ໄປ",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
