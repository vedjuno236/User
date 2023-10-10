import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_final/app/modules/bus/views/bus_view.dart';


class SearchTo extends StatefulWidget {
  const SearchTo({ Key? key }) : super(key: key);

  @override
  _SearchToState createState() => _SearchToState();
}

class _SearchToState extends State<SearchTo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
        // brightness: Brightness.light,
        backgroundColor: Colors.white,

        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BusView()),
                  );
                },
                child: Icon(CupertinoIcons.chevron_left, color: Colors.black),
              ),
              SizedBox(width: 150),
              Text(
                "ເລືອກສະຖານີປາຍທາງ",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ],
          ),
        ),

        // leading: Icon(Icons.arrow_back_ios),

        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 0.8),
                ),
                hintText: 'ກະລຸນາໃສ່ສະຖານີ',
                prefixIcon: Icon(
                  Icons.search,
                  size: 20,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "ເມືອງທີເລືອກໄດ້: ",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 100,
                        height: 50,
                        decoration:BoxDecoration(
                          // color: Colors.white70,
                          border: Border.all(color: Colors.grey)
                        ),
                        child: Center(
                          child: Text("ໜອງຂຽວ",style: TextStyle(fontSize: 18,color: Colors.black),),
                        ),
                      ),
                        Container(
                        width: 100,
                        height: 50,
                        decoration:BoxDecoration(
                          // color: Colors.white70,
                          border: Border.all(color: Colors.grey)
                        ),
                        child: Center(
                          child: Text("ເມືອງລໍາບາກ",style: TextStyle(fontSize: 18,color: Colors.black),),
                        ),
                      ),
                        Container(
                        width: 100,
                        height: 50,
                        decoration:BoxDecoration(
                          // color: Colors.white70,
                          border: Border.all(color: Colors.grey)
                        ),
                        child: Center(
                          child: Text("ບໍ່ແກ້ວ",style: TextStyle(fontSize: 18,color: Colors.black),),
                        ),
                      ),
                     
                     
                    ],
                  ), 
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                         width: 100,
                        height: 50,
                        decoration:BoxDecoration(
                          // color: Colors.white70,
                          border: Border.all(color: Colors.grey)
                        ),
                        child: Center(
                          child: Text("ອຸດົມໄຊ",style: TextStyle(fontSize: 18,color: Colors.black),),
                        ),
                      ),
                       Container(
                         width: 100,
                        height: 50,
                        decoration:BoxDecoration(
                          // color: Colors.white70,
                          border: Border.all(color: Colors.grey)
                        ),
                        child: Center(
                          child: Text("ຊໍາເໜືອ",style: TextStyle(fontSize: 18,color: Colors.black),),
                        ),
                      ),
                       Container(
                         width: 100,
                        height: 50,
                        decoration:BoxDecoration(
                          // color: Colors.white70,
                          border: Border.all(color: Colors.grey)
                        ),
                        child: Center(
                          child: Text("ຫຼວງນໍ້າທາ",style: TextStyle(fontSize: 18,color: Colors.black),),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                            width: 100,
                        height: 50,
                        decoration:BoxDecoration(
                          // color: Colors.white70,
                          border: Border.all(color: Colors.grey)
                        ),
                        child: Center(
                          child: Text("ຊຽງຂວາງ",style: TextStyle(fontSize: 18,color: Colors.black),),
                        ),
                      ),
                       Container(
                            width: 100,
                        height: 50,
                        decoration:BoxDecoration(
                          // color: Colors.white70,
                          border: Border.all(color: Colors.grey)
                        ),
                        child: Center(
                          child: Text("ຜົ້ງສາລີ",style: TextStyle(fontSize: 18,color: Colors.black),),
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
    );
  }
}
