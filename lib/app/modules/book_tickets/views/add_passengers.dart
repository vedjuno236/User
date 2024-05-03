import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/app/modules/book_tickets/views/add_a_contact.dart';
import 'package:flutter_final/app/modules/login/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class AddPassengers extends StatefulWidget {
  const AddPassengers({Key? key}) : super(key: key);

  @override
  _AddPassengersState createState() => _AddPassengersState();
}

class _AddPassengersState extends State<AddPassengers> {
  late LoginController loginController;
  // To track checked state

  @override
  void initState() {
    loginController = Get.find<LoginController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        elevation: 0,
        title: Text(
          'ຜູ້ໂດຍສານ',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => ReservationForm()),
                // );
                Navigator.pop(context);
              },
              child: Text(
                'ສໍາເລັດ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ))
        ],
      ),
      body: Container(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                // Add your onTap logic here
                // For example, navigate to a new screen or perform an action
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => AddAContact()),
                // );
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: AddAContact(),
                  ),
                );
              },
              child: Column(
                children: [
                  SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.redAccent),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.add_circled,
                                color: Colors.redAccent,
                                size: 24,
                              ),
                              Text(
                                'ເພີ່ມຜູ້ຕິດຕໍ່',
                                style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            GetBuilder<LoginController>(builder: (_) {
              List<dynamic> listPassengerForAdd = [];
              listPassengerForAdd.add(_.passenger!.passengerId);
              listPassengerForAdd.addAll(_.passenger!.passengerRelation);
              return _.passenger != null
                  ? Column(
                      children: [
                        Column(
                          children: listPassengerForAdd.map((e) {
                            bool isChecked = _.checkedPassenger[e] ?? false;

                            return Column(
                              children: [
                                e == "me-flutter"
                                    ? CheckboxListTile(
                                        value: isChecked,
                                        onChanged: (bool? newValue) {
                                          setState(() {
                                            _.setCheckedPassengerRelation(
                                                e, newValue ?? false);
                                          });
                                        },
                                        activeColor: Colors.green,
                                        title: Row(
                                          children: [
                                            Text('${_.passenger?.username}'),
                                            Text(
                                              '${_.passenger?.isAdult()}',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.red),
                                            ),
                                          ],
                                        ),
                                        subtitle: Row(
                                          children: [
                                            Text('ບັດປະຈໍາຕົວ'),
                                            Text('${_.passenger?.idCard}'),
                                          ],
                                        ),
                                        secondary: const Icon(
                                          Icons.edit,
                                          color: Colors.blue,
                                          size: 20.0,
                                        ),
                                      )
                                    : CheckboxListTile(
                                        value: isChecked,
                                        onChanged: (bool? newValue) {
                                          setState(() {
                                            _.setCheckedPassengerRelation(
                                                e, newValue ?? false);
                                          });
                                        },
                                        activeColor: Colors.green,
                                        title: Row(
                                          children: [
                                            Text(
                                                '${_.passengerList.firstWhere((element) => element.passengerId == e).username}'),
                                            Text(
                                              '${_.passengerList.firstWhere((element) => element.passengerId == e).isAdult()}',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.red),
                                            ),
                                          ],
                                        ),
                                        subtitle: Row(
                                          children: [
                                            Text('ບັດປະຈໍາຕົວ'),
                                            Text(
                                                '${_.passengerList.firstWhere((element) => element.passengerId == e).idCard}'),
                                          ],
                                        ),
                                        secondary: const Icon(
                                          Icons.edit,
                                          color: Colors.blue,
                                          size: 20.0,
                                        ),
                                      ),
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: new Divider(
                                    color: Colors.black45,
                                  ),
                                ),
                                SizedBox(height: 5),
                              ],
                            );
                          }).toList(),
                        ),
                      ],
                    )
                  : SizedBox();
            })
          ],
        ),
      ),
    );
  }
}
