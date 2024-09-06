import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_final/app/modules/home/views/home_view.dart';
import 'package:flutter_final/app/modules/mytickets/views/list_my_tickets.dart';
import 'package:flutter_final/app/modules/profile/views/profile_screen.dart';
import 'package:flutter_final/app/modules/search_tickets/views/search_tickets.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';
import 'package:page_transition/page_transition.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../app/modules/bus/controllers/bus_controller.dart';

class Train extends StatefulWidget {
  const Train({Key? key}) : super(key: key);

  @override
  _BusViewState createState() => _BusViewState();
}

const Color pColor = Color(0xFFEC2028);

class _BusViewState extends State<Train> {
  // final Stream<QuerySnapshot> _stationStream =
  //     FirebaseFirestore.instance.collection('Stations').snapshots();

  final FocusNode _focus = FocusNode();
  final FocusNode _focusN = FocusNode();

  List<String> stationList = [
    'ກິວກະຈໍາ',
    'ເມືອງນານ',
    'ເມືອງເງີນ',
    'ໂພນສະຫວັນ',
    'ວັງວຽງ',
    'ເມືອງແກ່ນທ້າວ',
    'ໄຊຍະບູລີ',
    'ເມືອງຫົງສາ',
    'ເມືອງຊຽງເງີນ',
    'ເມືອງພູຄູນ',
    'ເມືອງຄອບ',
    'ວຽງຈັນ',
    'ເມືອງພຽງ',
    'ເມືອງຊຽງຮ່ອນ'
  ];

  late BusController busController;

  var searchName = "";
  var search = "";

  @override
  void initState() {
    super.initState();
    busController = Get.put(BusController());
    _focus.addListener(_onFocusChange);
    _focusN.addListener(_onFocusChange2);
  }

  @override
  void dispose() {
    super.dispose();

    _focus.removeListener(_onFocusChange);
    _focus.dispose();

    _focusN.removeListener(_onFocusChange2);
    _focusN.dispose();
  }

  void _onFocusChange() {
    Get.offAllNamed('/search_to');
  }

  void _onFocusChange2() {
    Get.offAllNamed('/search_form');
  }

  var formatter = DateFormat.yMMMMEEEEd();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white60,
      body: Container(
        // color: Colors.white70,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3.5,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage("assets/images/img-1.png"),
                    fit: BoxFit.cover,
                  ),
                  gradient: LinearGradient(
                    colors: [
                      pColor.withOpacity(0.8),
                      pColor,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.leftToRight,
                                      child: HomeView(),
                                    ),
                                  );
                                },
                                child: const Icon(CupertinoIcons.chevron_left,
                                    color: Colors.white),
                              ),
                              const Icon(
                                CupertinoIcons.bus,
                                color: Colors.white,
                              )
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            margin: EdgeInsets.only(top: 130, bottom: 0),
                            width: MediaQuery.of(context).size.width,
                            height: 290,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  offset: Offset(0, 1),
                                  blurRadius: 5,
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: Expanded(
                              child: Column(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          width: 300, // Adjust width as needed
                                          child: DefaultTextStyle(
                                            style: GoogleFonts.notoSansLao(
                                              fontSize: 17,
                                              color: Colors.black,
                                            ),
                                            child: AnimatedTextKit(
                                              animatedTexts: [
                                                TypewriterAnimatedText(
                                                  "ທາງລົດໄຟ - ລາວຈິນ\nຄົມມະນາຄົມ - ຄວາມຈະເລິນຮຸ່ງເຮືອງ",
                                                  speed: const Duration(
                                                      milliseconds: 300),
                                                ),
                                              ],
                                              isRepeatingAnimation: true,
                                            ),
                                          ))
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 0, top: 25, right: 0, bottom: 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                showModalBottomSheet(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return SingleChildScrollView(
                                                      child: SizedBox(
                                                        height: 600,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Column(
                                                            children: [
                                                              SingleChildScrollView(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          "ເລືອກສະຖານີ",
                                                                          style:
                                                                              GoogleFonts.notoSansLao(
                                                                            fontSize:
                                                                                17,
                                                                            color:
                                                                                Colors.black,
                                                                            // Other text style properties can be added here
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              40,
                                                                          width:
                                                                              365,
                                                                          child:
                                                                              TextField(
                                                                            style:
                                                                                GoogleFonts.notoSansLao(
                                                                              color: Colors.black,
                                                                              fontSize: 17,
                                                                              letterSpacing: 0.5,
                                                                            ),
                                                                            decoration:
                                                                                InputDecoration(
                                                                              filled: true,
                                                                              fillColor: Colors.white70,
                                                                              border: OutlineInputBorder(
                                                                                borderRadius: BorderRadius.circular(8),
                                                                                borderSide: BorderSide.none,
                                                                              ),
                                                                              hintText: "ຄົ້ນຫາສະຖານີ",
                                                                              hintStyle: GoogleFonts.notoSansLao(color: Color.fromARGB(255, 168, 157, 157), fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.5, decorationThickness: 6),
                                                                              prefixIcon: const Icon(Icons.search),
                                                                              prefixIconColor: Colors.black,
                                                                            ),
                                                                            // onChanged:
                                                                            //     searchStations,
                                                                            onChanged:
                                                                                (value) {
                                                                              setState(() {
                                                                                searchName = value;
                                                                              });
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 15,
                                                              ),

                                                              StreamBuilder<
                                                                      QuerySnapshot>(
                                                                  // stream:
                                                                  //     _stationStream,
                                                                  stream: FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'Stations')
                                                                      .orderBy(
                                                                          'name')
                                                                      .startAt([
                                                                    searchName
                                                                  ]).endAt([
                                                                    searchName +
                                                                        "\uf8ff"
                                                                  ]).snapshots(),
                                                                  builder: (context,
                                                                      AsyncSnapshot<
                                                                              QuerySnapshot>
                                                                          snapshot) {
                                                                    if (snapshot
                                                                        .hasError) {
                                                                      return Text(
                                                                          'Something went wrong');
                                                                    }

                                                                    if (snapshot
                                                                            .connectionState ==
                                                                        ConnectionState
                                                                            .waiting) {
                                                                      return Text(
                                                                          "Loading");
                                                                    }
                                                                    final data =
                                                                        snapshot
                                                                            .data!
                                                                            .docs;

                                                                    return GridView.builder(
                                                                        shrinkWrap: true,
                                                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 2),
                                                                        itemCount: data.length,
                                                                        itemBuilder: (context, index) {
                                                                          return GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              busController.setDepartureStation(data[index].id, data[index]['name'].toString());
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              width: 100,
                                                                              height: 50,
                                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey)),
                                                                              child: Center(
                                                                                child: Text(
                                                                                  "${data[index]['name']}",
                                                                                  style: GoogleFonts.notoSansLao(
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontSize: 19,
                                                                                    color: Colors.black,
                                                                                    // Other text style properties can be added here
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          );
                                                                        });
                                                                  }),

                                                              // Additional widgets for your bottom sheet go here
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              child: GetBuilder<BusController>(
                                                  builder: (context) {
                                                return RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: "ຈາກ \n",
                                                        style: GoogleFonts
                                                            .notoSansLao(
                                                          fontSize: 15,
                                                          color: Colors.black45,
                                                          // Other text style properties can be added here
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: busController
                                                            .departureStation,
                                                        style: GoogleFonts
                                                            .notoSansLao(
                                                          fontSize: 19,
                                                          color: Colors.black,
                                                          // Other text style properties can be added here
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }),
                                            )
                                          ],
                                        ),
                                        const Row(
                                          children: [
                                            Text("",
                                                style: TextStyle(fontSize: 25)),
                                            SizedBox(height: 15),
                                            Icon(Icons.swap_vert,
                                                color: Color(0xFFF00d5d8),
                                                size: 40),
                                            SizedBox(height: 15),
                                            Text("",
                                                style: TextStyle(fontSize: 25)),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return SingleChildScrollView(
                                                  child: SizedBox(
                                                    height: 600,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Column(
                                                        children: [
                                                          SingleChildScrollView(
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      "ເລືອກສະຖານີ",
                                                                      style: GoogleFonts
                                                                          .notoSansLao(
                                                                        fontSize:
                                                                            17,
                                                                        color: Colors
                                                                            .black,
                                                                        // Other text style properties can be added here
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          40,
                                                                      width:
                                                                          365,
                                                                      child:
                                                                          TextField(
                                                                        style: GoogleFonts
                                                                            .notoSansLao(
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                          letterSpacing:
                                                                              0.5,
                                                                        ),
                                                                        decoration:
                                                                            InputDecoration(
                                                                          filled:
                                                                              true,
                                                                          fillColor:
                                                                              Colors.white,
                                                                          border:
                                                                              OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(8),
                                                                            borderSide:
                                                                                BorderSide.none,
                                                                          ),
                                                                          hintText:
                                                                              "ຄົ້ນຫາສະຖານີ",
                                                                          hintStyle: GoogleFonts.notoSansLao(
                                                                              color: Color.fromARGB(255, 168, 157, 157),
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.w400,
                                                                              letterSpacing: 0.5,
                                                                              decorationThickness: 6),
                                                                          prefixIcon:
                                                                              const Icon(Icons.search),
                                                                          prefixIconColor:
                                                                              Colors.black,
                                                                        ),
                                                                        onChanged:
                                                                            (value) {
                                                                          setState(
                                                                              () {
                                                                            search =
                                                                                value;
                                                                          });
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          StreamBuilder(
                                                              // stream:
                                                              //     _stationStream,
                                                              stream: FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'Stations')
                                                                  .orderBy(
                                                                      'name')
                                                                  .startAt([
                                                                search
                                                              ]).endAt([
                                                                search +
                                                                    "\uf8ff"
                                                              ]).snapshots(),
                                                              builder: (context,
                                                                  AsyncSnapshot<
                                                                          QuerySnapshot>
                                                                      snapshot) {
                                                                if (snapshot
                                                                    .hasError) {
                                                                  return Text(
                                                                      'Something went wrong');
                                                                }

                                                                if (snapshot
                                                                        .connectionState ==
                                                                    ConnectionState
                                                                        .waiting) {
                                                                  return Text(
                                                                      "Loading");
                                                                }
                                                                final data =
                                                                    snapshot
                                                                        .data!
                                                                        .docs;

                                                                return GridView
                                                                    .builder(
                                                                        shrinkWrap:
                                                                            true,
                                                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                                            crossAxisCount:
                                                                                3,
                                                                            mainAxisSpacing:
                                                                                10,
                                                                            crossAxisSpacing:
                                                                                10,
                                                                            childAspectRatio:
                                                                                2),
                                                                        itemCount:
                                                                            data
                                                                                .length,
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          return GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              busController.setArrivalStation(data[index].id, data[index]['name'].toString());
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              width: 100,
                                                                              height: 50,
                                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey)),
                                                                              child: Center(
                                                                                child: Text(
                                                                                  "${data[index]['name']}",
                                                                                  style: GoogleFonts.notoSansLao(
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontSize: 19,
                                                                                    color: Colors.black,
                                                                                    // Other text style properties can be added here
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          );
                                                                        });
                                                              }),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Column(
                                            children: <Widget>[
                                              GetBuilder<BusController>(
                                                  builder: (context) {
                                                return RichText(
                                                  text: TextSpan(
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: "ຮອດ \n",
                                                          style: GoogleFonts
                                                              .notoSansLao(
                                                            fontSize: 15,
                                                            color:
                                                                Colors.black45,
                                                            // Other text style properties can be added here
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: busController
                                                              .arrivalStation,
                                                          style: GoogleFonts
                                                              .notoSansLao(
                                                                  fontSize: 19,
                                                                  color: Colors
                                                                      .black

                                                                  // Other text style properties can be added here
                                                                  ),
                                                        ),
                                                      ]),
                                                );
                                              }),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          // Removed extra parentheses here
                                          return SizedBox(
                                            height: 600,
                                            child: Center(
                                              child: GetBuilder<BusController>(
                                                builder: (_) {
                                                  DateTime today =
                                                      DateTime.now();
                                                  DateTime lastDate = today.add(
                                                      const Duration(
                                                          days:
                                                              1)); // Five days from today

                                                  return TableCalendar(
                                                    locale: "lo_LA",
                                                    rowHeight: 43,
                                                    headerStyle:
                                                        const HeaderStyle(
                                                      formatButtonVisible:
                                                          false,
                                                      titleCentered: true,
                                                    ),
                                                    availableGestures:
                                                        AvailableGestures.all,
                                                    selectedDayPredicate:
                                                        (day) {
                                                      // Allow selection only for dates within the five-day range starting from today
                                                      return !day.isBefore(
                                                              today) &&
                                                          !day.isAfter(
                                                              lastDate);
                                                    },
                                                    focusedDay: today,
                                                    firstDay:
                                                        today, // Start from today
                                                    lastDay:
                                                        lastDate, // End five days from today
                                                    onDaySelected: (selectedDay,
                                                        focusedDay) {
                                                      // Update the selectedDate when a day is selected.
                                                      busController
                                                          .setSelectedDate(
                                                              selectedDay);
                                                      // Add your logic here when a day is selected.
                                                      Navigator.pop(
                                                          context); // Dismiss the modal when a day is selected.
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 30,
                                          top: 20,
                                          right: 0,
                                          bottom: 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "ເລືອກເວລາເດີນທາງ",
                                            style: GoogleFonts.notoSansLao(
                                              fontSize: 15,
                                              color: Colors.black45,
                                              // Other text style properties can be added here
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              GetBuilder<BusController>(
                                                  builder: (_) {
                                                return Text(
                                                  formatter.format(busController
                                                      .selectedDate),
                                                  style:
                                                      GoogleFonts.notoSansLao(
                                                    fontSize: 19,
                                                    color: Colors.black,
                                                  ),
                                                );
                                              }),
                                              const Icon(
                                                Icons.calendar_month,
                                                size: 20,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  GestureDetector(
                                    onTap: () async {
                                      await busController
                                          .getAvailableBusesOnDate();
                                      // Navigate to the "Home" screen when tapped
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: Search_tickets(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 330,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: <Color>[
                                            Colors.redAccent,
                                            Colors.orangeAccent,
                                          ],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      padding: EdgeInsets.all(16.0),
                                      child: const Text(
                                        "ກວດສອບປີ້",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 500,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                          ),
                          Container(
                              height: 30,
                              width: 375,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 253, 253, 226),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Marquee(
                                text:
                                    'ເມື່ອທ່ານພົບບັນຫາໃນການຊື້ປີ້ ຫຼື ການຊໍາລະເງີນ ກະລຸນາຕິດຕໍ່ສອບ.',
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.redAccent),
                                scrollAxis: Axis.horizontal,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                blankSpace: 20.0,
                                velocity: 100.0,
                                pauseAfterRound: Duration(seconds: 1),
                                startPadding: 10.0,
                                accelerationDuration: Duration(seconds: 1),
                                accelerationCurve: Curves.linear,
                                decelerationDuration:
                                    Duration(milliseconds: 900),
                                decelerationCurve: Curves.easeOut,
                              )),
                          SizedBox(height: 20),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ItemTerbaru(
                                  image: "assets/images/img-6.png",
                                ),
                                ItemTerbaru(
                                  image: "assets/images/img-5.png",
                                ),
                                ItemTerbaru(
                                  image: "assets/images/img-6.png",
                                ),
                                ItemTerbaru(
                                  image: "assets/images/img-7.png",
                                ),
                                ItemTerbaru(
                                  image: "assets/images/img-8.png",
                                ),
                                ItemTerbaru(
                                  image: "assets/images/img-9.png",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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

class ItemTerbaru extends StatelessWidget {
  ItemTerbaru({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      width: Get.width * 0.7,
      height: 190,
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class ItemKategori extends StatelessWidget {
  ItemKategori({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          child: Image.asset(
            icon,
            // color: Color(0xFFF7B731),
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

class ItemNav extends StatelessWidget {
  ItemNav({
    Key? key,
    required this.status,
    required this.icon,
    required this.title,
  }) : super(key: key);

  final bool status;
  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 30,
          child: Image.asset(
            (status == true)
                ? "assets/icons/$icon-active.png"
                : "assets/icons/$icon.png",
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Text(
              status ? "$title" : "$title",
              style: TextStyle(
                color: (status == true)
                    ? Color.fromARGB(255, 103, 32, 236)
                    : Color(0xFF747D8C),
              ),
            ),

            // Text(
            //   "ໜ້າຫຼັກ",
            //   style: TextStyle(
            //     color: (status == true)
            //         ? Color.fromARGB(255, 103, 32, 236)
            //         : Color(0xFF747D8C),
            //   ),
            // ),
          ],
        ),
      ],
    );
  }
}

class StatusCard extends StatelessWidget {
  StatusCard({
    Key? key,
    required this.title,
    required this.data,
    required this.satuan,
  }) : super(key: key);

  final String title;
  final String data;
  final String satuan;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        width: Get.width * 0.25,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            RichText(
              text: TextSpan(
                text: data,
                style: const TextStyle(
                  fontSize: 22,
                  color: Color(0xFFEC2028),
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: " $satuan",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF747D8C),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ClipInfoClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width - 50, size.height);
    path.lineTo(size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class ClipPathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 60,
    );
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
