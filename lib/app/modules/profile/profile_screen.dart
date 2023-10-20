import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/app/modules/home/views/home_view.dart';
import 'package:flutter_final/app/modules/mytickets/views/mytickests.dart';
import 'package:flutter_final/app/modules/profile/update_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text("ຂໍ້ມູນສ່ວນຕົວ"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              width: 120,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset("assets/images/profile.png"),
              ),
            ),
            SizedBox(height: 10),
          const  Text("Vedjuno", style: TextStyle(fontSize: 15)),
           const Text("Vedjuno@gamil.com", style: TextStyle(fontSize: 10)),
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              height: 30,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    side: BorderSide.none,
                    shape: const StadiumBorder()),
                child:const Text(
                  "ແກ້ໄຂຂໍ້ມູນ",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            const SizedBox(height: 40),
            // const Divider(),
            const SizedBox(height: 10),
            Column(
              children: [
                ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white.withOpacity(0.1),
                    ),
                    child: Icon(Icons.settings_rounded, size: 40),
                  ),
                  title:const Text(
                    "ຕັ້ງຄ່າ",
                    style: TextStyle(fontSize: 18),
                  ),
                  trailing: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: const Icon(CupertinoIcons.arrow_right, size: 20),
                  ),
                ),

              const  SizedBox(height: 15),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UpdateProfile()),
                    );
                  },
                  child: ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white.withOpacity(0.1),
                      ),
                      child: Icon(CupertinoIcons.person_alt_circle, size: 40),
                    ),
                    title:const Text(
                      "ຢືນຢັນຂໍ້ມູນຈີງ",
                      style: TextStyle(fontSize: 18),
                    ),
                    trailing: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.grey.withOpacity(0.1),
                      ),
                      child: Icon(CupertinoIcons.arrow_right, size: 20),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const Divider(),
                //  SizedBox(height: 15),
                ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white.withOpacity(0.1),
                    ),
                    child: Icon(CupertinoIcons.person_3_fill, size: 40),
                  ),
                  title:const Text(
                    "ກ່ຽວກັບພວກເຮົາ",
                    style: TextStyle(fontSize: 18),
                  ),
                  trailing: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: const Icon(CupertinoIcons.arrow_right, size: 20),
                  ),
                ),
              const  SizedBox(height: 15),
                ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white.withOpacity(0.1),
                    ),
                    child:const Icon(
                      CupertinoIcons.lock_rotation,
                      size: 40,
                      color: Colors.blue,
                    ),
                  ),
                  title:const Text(
                    "ອອກຈາກລະບົບ",
                    style: TextStyle(fontSize: 18),
                  ),
                  trailing: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child:const Icon(
                      CupertinoIcons.arrow_right,
                      size: 20,
                    ),
                  ),
                ),
              ],
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
              color: Colors.red,
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
              MaterialPageRoute(builder: (context) => Mytickests()),
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
