import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_final/app/modules/profile/views/profile_screen.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  int currenStep = 0;

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final id = TextEditingController();

  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "ຢືນຢັນຂໍ້ມູນຈີງ",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Theme(
        data: Theme.of(context)
            .copyWith(colorScheme: ColorScheme.light(primary: Colors.red)),
        child: Stepper(
          type: StepperType.horizontal,
          steps: getSteps(),
          currentStep: currenStep,
          onStepContinue: () {
            final isLastStep = currenStep == getSteps().length - 1;
            if (isLastStep) {
              // print('Completed');
            } else {
              setState(() => currenStep += 1);
            }
          },
          onStepTapped: (step) => setState(() => currenStep = step),
          onStepCancel:
              currenStep == 0 ? null : () => setState(() => currenStep -= 1),
          controlsBuilder: (context, ControlsDetails controls) {
            return Container(
              margin: const EdgeInsets.only(top: 50),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: controls.onStepContinue,
                      child: const Text(
                        'ຖັດໄປ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },

          // elevation: 0,
        ),
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
          state: currenStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currenStep >= 0,
          title: const Text(
            "ຢືນຢັນ",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start, // Added this line
            children: [
              const Text(
                "ເລືອກວິທີການຢືນຢັນ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              const Text(
                "ເພື່ອຮັກສາຄວາມປອດໄພທືນຂອງທ່ານຢ່າງມີປະສິດທິຜົນ ແລະ ຍົກຂື້ນ ປະສິດທິພາບ ດ້ານການແກ້ໄຂໃບສັ່ງຊື້ ຂໍທ່ານຂຽນຂໍ້ມູນໃຫ້ສອດຄ່ອງກັບໃບຢັ້ງຢືນຂອງທ່ານ",
              ),
              const SizedBox(height: 10),
              Container(
                width: 300,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      child: Image.asset("assets/images/id-card.png"),
                    ),
                    const SizedBox(height: 10),
                    const Column(
                      children: [
                        Text(
                          "ບັດປະຈໍາຕົວລາວ",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "ໄປອັບໂຫລດ",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Step(
          state: currenStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currenStep >= 1,
          title: const Text(
            "ຕື່ມຂໍ້ມູນ",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start, // Added this line
            children: [
              const Text(
                "ບັດປະຈໍາຕົວລາວ",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              const Text(
                "ໃຫ້ຂຽນໃສ່ຂໍ້ມູນທີແທ້ຈີງ ແລະ ຖືກຕ້ອງ",
              ),
              const SizedBox(height: 10),
              TextField(
                controller: firstName,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: 'ກະລຸນາຂຽນຊື່ໃສ່'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: lastName,
              
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: 'ກະລຸນາຂຽນນາມສະກຸນໃສ່'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: id,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: 'ຂຽນເລກທີຂອງບັດປະຈໍາຕົວ'),
                cursorColor: Colors.white70,
              ),
            ],
          ),
        ),
        Step(
          state: currenStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currenStep >= 2,
          title: const Text(
            "ອັບໂຫລດ",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start, // Added this line
            children: [
              const Text(
                "ສິ່ງທີຕ້ອງເອົາໃຈໃສ່ ໃນການຖ່າຍເອກະສານ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              const Text(
                "ກະລຸນາຮັບປະກັນວ່າ ຂອບເອກະສານໃຫ້ຄົບຖ້ວນ ຕົວອັກສອນຈະແຈ້ງ ແລະ ຄວາມສະຫວ່າງ",
              ),
              const SizedBox(height: 10),
              if (imageFile != null)
                Container(
                  width: 300,
                  height: 300,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                        image: FileImage(imageFile!), fit: BoxFit.cover),
                    border: Border.all(width: 8, color: Colors.black),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                )
              else
                Container(
                  width: 300,
                  height: 300,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 8, color: Colors.black12),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Image.asset('assets/images/card.png'),
                ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  getImage(source: ImageSource.camera);
                },
                child: Container(
                  width: 280,
                  height: 50,
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
                    "ກົດຖ່າຍຮູບ",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ];

  void getImage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(
        source: source,
        maxWidth: 300,
        maxHeight: 300,
        imageQuality: 70 //0 - 100
        );
    if (file?.path != null) {
      setState(() {
        imageFile = File(file!.path);
      });
    }
  }
}
