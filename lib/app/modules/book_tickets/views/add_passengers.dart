import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/app/modules/book_tickets/views/add_a_contact.dart';
import 'package:flutter_final/app/modules/book_tickets/views/reservation_form.dart';

class AddPassengers extends StatefulWidget {
  const AddPassengers({Key? key}) : super(key: key);

  @override
  _AddPassengersState createState() => _AddPassengersState();
}

bool? _tony = false;
bool? _ved = false;

class _AddPassengersState extends State<AddPassengers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        elevation: 0,
        title: Text(
          'ເລືອກບ່ອນນັ່ງ',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ReservationForm()),
            );
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReservationForm()),
                );
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddAContact()),
                );
              },
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
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
            Column(
              children: [
                CheckboxListTile(
                  value: _tony,
                  onChanged: (bool? newValue) {
                    setState(() {
                      _tony = newValue;
                    });
                  },
                  activeColor: Colors.green,
                  title: Row(
                    children: [
                      Text('Tony'),
                      Text(
                        'ຜູ້ໃຫ່ຍ',
                        style: TextStyle(fontSize: 18, color: Colors.red),
                      ),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      Text('ບັດປະຈໍາຕົວ'),
                      Text('1234567890'),
                    ],
                  ),
                  secondary: Icon(
                    Icons.edit_note_sharp,
                    color: Colors.blue,
                    size: 50.0,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: new Divider(
                color: Colors.black45,
              ),
            ),
            SizedBox(height: 5),
            CheckboxListTile(
              value: _ved,
              onChanged: (bool? newValue) {
                setState(() {
                  _ved = newValue;
                });
              },
              activeColor: Colors.green,
              title: const Row(
                children: [
                  Text('Tony'),
                  Text(
                    'ຜູ້ໃຫ່ຍ',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                ],
              ),
              subtitle: const Row(
                children: [
                  Text('ບັດປະຈໍາຕົວ'),
                  Text('1234567890'),
                ],
              ),
              secondary: Icon(
                // CupertinoIcons.edit_non,
                Icons.edit_note_sharp,
                color: Colors.blue,
                size: 50.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: new Divider(
                color: Colors.black45,
              ),
            )
          ],
        ),
      ),
    );
  }
}
