import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_final/app/modules/mytickets/controllers/my_tickets_controller.dart';
import 'package:flutter_final/app/modules/mytickets/views/mytickests.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../const/formatter.dart';
import '../../../model/booking_model.dart';

class ListMyTickets extends StatefulWidget {
  const ListMyTickets({Key? key}) : super(key: key);

  @override
  _ListMyTicketsState createState() => _ListMyTicketsState();
}

class _ListMyTicketsState extends State<ListMyTickets> {
  MyTicketsController myTicketsController = Get.put(MyTicketsController());

  @override
  void initState() {
    myTicketsController.getMyListTicket();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: const Text(
          'ປີ້ຂອງຂ້ອຍ',
          style: TextStyle(
            color: Colors.white, // Change 'Colors.red' to your desired color
            fontSize: 20,
            fontWeight: FontWeight.bold,
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
      backgroundColor: Colors.grey.shade200,
      body: GetBuilder<MyTicketsController>(
        builder: (_) {
          return _.isLoading.isTrue
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: _.bookingList.length,
                  itemBuilder: (context, index) {
                    return TicketView(
                      bookingModel: _.bookingList[index],
                    );
                  },
                );
        },
      ),
    );
  }
}

class TicketView extends StatelessWidget {
  final BookingModel bookingModel;
  final MyTicketsController myTicketsController =
      Get.put(MyTicketsController());

  TicketView({Key? key, required this.bookingModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Mytickests(
                    bookingModel: bookingModel,
                  )),
        );
      },
      child: Padding(
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
                        bookingModel
                            .departures.routes.departureStation.stationName,
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
                      Text(
                        bookingModel
                            .departures.routes.arrivalStation.stationName,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink),
                      )
                    ],
                  ),
                  new Divider(color: Colors.black12),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const SizedBox(
                          width: 100,
                          child: Text(
                            "",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          )),
                      Text(
                        DateFormat("MM/dd EEEE").format(bookingModel.bookDate),
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const SizedBox(
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
                        DateFormat("hh:mm a", "en-US").format(
                            bookingModel.departures.routes.departureTime),
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        DateFormat("hh:mm a", "en-US")
                            .format(bookingModel.departures.routes.arrivalTime),
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
                        formatDuration(
                            bookingModel.departures.routes.departureTime,
                            bookingModel.departures.routes.arrivalTime),
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      Container(
                        child: Text(
                          bookingModel.ticket.ticketName,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text("${oCcy.format(bookingModel.ticket.price)} LAK",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.redAccent)),
                    ],
                  ),
                  Expanded(
                    child: Text(
                      statusLa(bookingModel.status, bookingModel.expiredTime),
                      style: TextStyle(
                          fontSize: 18,
                          color: statusColor(
                              bookingModel.status, bookingModel.expiredTime)),
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

  String statusLa(String status, DateTime expired) {
    if (status == "pending") {
      return "ລໍຖ້າກວດສອບ";
    } else if (status == "checked") {
      return "ກວດສອບສຳເລັດ";
    } else if (status == "cancel") {
      return "ຍົກເລີກ";
    } else if (expired.isBefore(DateTime.now())) {
      return "ໝົດເວລາ";
    } else {
      return "";
    }
  }

  Color statusColor(String status, DateTime expired) {
    if (status == "pending") {
      return Colors.deepOrange;
    } else if (status == "checked") {
      return Colors.green;
    } else if (status == "cancel") {
      return Colors.grey;
    } else if (expired.isBefore(DateTime.now())) {
      return Colors.red;
    } else {
      return Colors.white;
    }
  }
}
