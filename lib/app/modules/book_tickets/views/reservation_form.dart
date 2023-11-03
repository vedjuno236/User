import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/app/modules/book_tickets/views/add_passengers.dart';
import 'package:flutter_final/app/modules/book_tickets/views/book_tickets.dart';
import 'package:flutter_final/app/modules/book_tickets/views/payment.dart';

class ReservationForm extends StatefulWidget {
  const ReservationForm({Key? key}) : super(key: key);

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
        title: const Text('ຂຽນໃສ່ໃບຈອງປີ້'),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BookTickets()),
            );
          },
          icon: const Icon(Icons.arrow_back_ios_new),
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
                            const Text(
                              "ໄຊຍະບູລີ",
                              style: TextStyle(
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
                            const Text(
                              "ຫຼວງພະບາງ",
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
                        SizedBox(
                          height: 60,
                          width: double.infinity,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 238, 235, 235),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'ລົດຕູ້ທໍາມະດາ',
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'ບ່ອນນັ່ງທໍາມະດາ',
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
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "01:00 AM",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "05:30 PM",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "1 ຊົ່ວໂມງ 10ນາທີ",
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
                        bottomRight: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Text(
                              '  Tony ',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(width: 5),
                            Text(
                              '  ຜູ້ໃຫ່ຍ ',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        const Row(
                          children: [
                            Text(
                              'ບັດປະຈໍາຕົວ',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(width: 5),
                            Text(
                              '2456459',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.delete),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: const Text(
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
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                margin: EdgeInsets.only(top: 1, bottom: 5),
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
                        "ຂໍ້ມູນຮັບປີ້",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "ສະຖານີຄິວລົດສາຍໃຕ້ ແຂວງຫຼວງພະບາງ ບ້ານນາຫຼວງ ",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Payment()),
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
