

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Search_tickets extends StatelessWidget {
  const Search_tickets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),

        // brightness: Brightness.light,
        backgroundColor: Color(0xFFE52D27),
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "ໄຊຍະບູລີ",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                Icon(CupertinoIcons.bus, color: Colors.white),
                Text(
                  "ຫຼວງພະບາງ",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
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
              Text(
                "ມື້ກ່ອນ",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              Text(
                "01/10/ວັນອາທິດ",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              Text(
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
      backgroundColor: Colors.grey.shade200,
      body: ListView(
        // itemCount: 10,
        // padding: EdgeInsets.only(top: 8, bottom: 8),
        // itemBuilder: (context, index) {
        //   return TicketView();
        // }
        children: [
          TicketView(),
          TicketView1(),
        ],
      ),
    );
  }
}

class TicketView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24))),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
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
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      "ຫຼວງພະບາງ",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink),
                    )
                  ],
                ),
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
                      "ລົດເມ45ບ່ອນນັ່ງ",
                      style: TextStyle(
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
                SizedBox(
                  height: 16,
                ),
                Row(
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
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "1 ຊົ່ວໂມງ 10ນາທີ",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Row(
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
                        borderRadius: BorderRadius.only(
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
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                        color: Colors.grey.shade200),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 12),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24))),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.amber.shade50,
                      borderRadius: BorderRadius.circular(20)),
                  child: Icon(CupertinoIcons.bus, color: Colors.amber),
                ),
                SizedBox(
                  width: 16,
                ),
                Text("200 000 ກີບ",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey)),
                SizedBox(width: 100),
                // SizedBox(
                //   height: 40,
                //   width: 80,
                   Padding(
                     padding: const EdgeInsets.all(10.0),
                     child: ElevatedButton(
                      onPressed: () {
                        // Add your button click logic here
                      },
                      child: Text(
                        "ຊື້",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.red),
                        )),
                      ),
                                     // ),
                                   ),
                   ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TicketView1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24))),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
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
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      "ຫຼວງພະບາງ",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink),
                    )
                  ],
                ),
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
                      "ລົດເມຕຽງນອນ",
                      style: TextStyle(
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
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "08:00 AM",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "02:30 PM",
                      style: TextStyle(
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
                      "1 ຊົ່ວໂມງ 10ນາທີ",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Row(
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
                        borderRadius: BorderRadius.only(
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
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                        color: Colors.grey.shade200),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 12),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24))),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.amber.shade50,
                      borderRadius: BorderRadius.circular(20)),
                  child: Icon(CupertinoIcons.bus, color: Colors.amber),
                ),
                SizedBox(
                  width: 16,
                ),
                Text("200 000 ກີບ",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey)),
                // Expanded(

                // child: Text("\u0024 240",
                //     textAlign: TextAlign.end,
                //     style: TextStyle(
                //         fontSize: 18,
                //         fontWeight: FontWeight.bold,
                //         color: Colors.black)
                //         )
                // ),
                SizedBox(width: 100),               
                   Padding(
                     padding: const EdgeInsets.all(10.0),
                     child: ElevatedButton(
                      onPressed: () {
                        // Add your button click logic here
                      },
                      child: Text(
                        "ຊື້",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.red),
                        )),
                      ),
                                     ),
                   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
