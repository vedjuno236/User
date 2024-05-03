import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/app/modules/book_tickets/views/bcel_one_payment.dart';
import 'package:flutter_final/app/modules/bus/controllers/bus_controller.dart';
import 'package:flutter_final/app/modules/home/views/home_view.dart';
import 'package:flutter_final/app/modules/login/controllers/login_controller.dart';
import 'package:flutter_final/app/modules/mytickets/views/list_my_tickets.dart';
import 'package:flutter_final/app/modules/profile/profile_screen.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../const/formatter.dart';
import '../../../model/departures_model.dart';
import '../../../model/ticket_model.dart';

class Payment extends StatefulWidget {
  final Departures departure;
  final Ticket ticket;
  const Payment({Key? key, required this.departure, required this.ticket})
      : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  late LoginController loginController;

  @override
  void initState() {
    loginController = Get.find<LoginController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: const Text(
          'ການຊໍາລະ',
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
      body: Container(
        child: ListView(
          children: [
            Padding(
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
                            GetBuilder<BusController>(builder: (_) {
                              return Text(
                                _.departureStation,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo),
                              );
                            }),
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
                                _.arrivalStation,
                                style: const TextStyle(
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
                        // const SizedBox(
                        //   height: 16,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
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
                          children: <Widget>[
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
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 12),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(24),
                            bottomRight: Radius.circular(24))),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Text(
                                'ຜູ້ໂດຍສານ ',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        // new Divider(
                        //   color: Colors.black38,
                        // ),
                        // SizedBox(height: 5),
                        // GetBuilder<LoginController>(builder: (_) {
                        //   return Column(
                        //     children: [
                        //       Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Text(
                        //             '  ${_.passenger?.username} ',
                        //             style: TextStyle(fontSize: 18),
                        //           ),
                        //           Text(
                        //             '${oCcy.format(widget.ticket.price)} LAK',
                        //             style: TextStyle(
                        //                 fontSize: 20,
                        //                 fontWeight: FontWeight.bold),
                        //           )
                        //         ],
                        //       ),
                        //       Row(
                        //         children: [
                        //           Text('ບັດປະຈໍາຕົວ '),
                        //           Text(
                        //             '${_.passenger?.idCard}',
                        //           ),
                        //         ],
                        //       ),
                        //       Row(
                        //         children: [
                        //           Text('${widget.departure.buses.busName}|'),
                        //           // Text('ບ່ອນນັ່ງ 01'),
                        //         ],
                        //       ),
                        //     ],
                        //   );
                        // }),
                        GetBuilder<LoginController>(builder: (_) {
                          return Column(
                            children: [
                              for (var entry in _.checkedPassenger.entries)
                                if (entry.value == true)
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            ' ${_.passengerList.firstWhere((element) => element.passengerId == entry.key).username} ',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            '${oCcy.format(widget.ticket.price)} LAK',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text('ບັດປະຈໍາຕົວ '),
                                          Text(
                                            '${_.passengerList.firstWhere((element) => element.passengerId == entry.key).idCard}',
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                              '${widget.departure.buses.busName}|'),
                                          // Text('ບ່ອນນັ່ງ 01'),
                                        ],
                                      ),
                                    ],
                                  ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                margin: EdgeInsets.only(top: 1, bottom: 5),
                width: MediaQuery.of(context).size.width,
                height: 100,
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
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "1. ກະລຸນາຊໍາລະເງີນອອນໄລພາຍໃນເວລາທີກໍານົດໄວ້ ",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "2.ຖ້າຊໍາລະເງີນເກີນເວລາກໍານົດ ລະບົບຈະຍົກເລີກປີ້ ",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.redAccent),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'ພາຍຫຼັງຈອງປີ້ສໍາເລັດແລ້ວ ປ່ຽນປີ້ ຍົກເລີກປີ໊ ແມ່ນຈະບໍ່ສົ່ງຄ່າຄືນ',
                          style: TextStyle(fontSize: 15, color: Colors.orange),
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'ລາຄາປີ້',
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text(
                              '${oCcy.format(widget.ticket.price)} KIP x ${(loginController.checkedPassenger.length)}',
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'ລາຄາຈອງປີ້',
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text(
                              '${oCcy.format(widget.ticket.bookingPrice)} KIP x ${(loginController.checkedPassenger.length)}',
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Divider(
                          // Add this Divider widget
                          color: Colors.black38,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'ຈໍານວນເງີນລວມ',
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text(
                              '${oCcy.format((widget.ticket.price * (loginController.checkedPassenger.length)) + (widget.ticket.bookingPrice * (loginController.checkedPassenger.length)))} KIP',
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: 1000,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "ກະລຸນາຊໍາລະ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pop(); // Use Navigator.of(context)
                                  },
                                  child: const Icon(Icons.close, size: 20),
                                ),
                              ],
                            ),
                            new Divider(
                              color: Colors.black38,
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  'ຈໍານວນເງີນທີຕ້ອງຈ່າຍ:',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 20),
                                Text(
                                  '${oCcy.format((widget.ticket.price * (loginController.checkedPassenger.length)) + (widget.ticket.bookingPrice * (loginController.checkedPassenger.length)))} Kip',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => BcelPaymentPage()));
                                // ScaffoldMessenger.of(context)
                                //     .showMaterialBanner(
                                //   MaterialBanner(
                                //     padding: const EdgeInsets.all(20),
                                //     content: Text('ການຊໍາລະສໍາເລັດ'),
                                //     leading: Icon(
                                //         Icons.notifications_active_outlined),
                                //     elevation: 5,
                                //     backgroundColor: Colors.white12,
                                //     actions: <Widget>[
                                //       TextButton(
                                //           onPressed: () {
                                //             // ScaffoldMessenger.of(context)
                                //             //     .hideCurrentMaterialBanner();
                                //           },
                                //           child: Text('ອອກ'))
                                //     ],
                                //   ),
                                // );
                              },
                              child: Container(
                                width: double.infinity,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Image.asset('assets/logo/bcl_one.png',
                                          width: 50, height: 50),
                                      SizedBox(
                                          width:
                                              10), // Make sure the image path is correct
                                      const Text(
                                        'UnionPay',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
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
                  padding: EdgeInsets.all(16.0),
                  child: const Text(
                    "ຊໍາລະ",
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
    );
  }
}
