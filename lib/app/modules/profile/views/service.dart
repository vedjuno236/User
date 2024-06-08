import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/app/modules/profile/views/profile_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class Servicedata extends StatefulWidget {
  const Servicedata({ Key? key }) : super(key: key);

  @override
  _ServiceState createState() => _ServiceState();
}

class _ServiceState extends State<Servicedata> {
     int currenStep = 0;
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.leftToRight,
                  child: ProfileScreen(),
                ),
              );
            },
            icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFFE52D27),
          title: Text(
            'ຂໍ້ມູນການບໍລິການ',
            style: GoogleFonts.notoSansLao(
              fontWeight: FontWeight.bold,
              fontSize: 18,color: Colors.white
              // Other text style properties can be added here
            ),
          )),
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
            "ລະບຽບການຂົນສົ່ງ",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          content:const  Column(
            mainAxisAlignment: MainAxisAlignment.start, // Added this line
            children: [
             
               Text(
                "ເມື່ອທ່ານພົບບັນຫາໃນການຊື້ປີ້ ຫຼື ການຊໍາລະເງີນ ກະລຸນາຕິດຕໍ່ ສອບຖາມ ຫຼື ຂໍຄວາມຊ່ວຍເຫຼືອນໍາໜ່ວຍບໍລິການຕ່າງໆ ພວກເຮົາຍີນດີ ໃຫ້ການຂ່ວຍເຫຼືອ ຢ່າງເຕັມທີ ຂໍໃຫ້ທ່ານ ຈົ່ງມີຄວາມສຸກໃນການເດີນທາງ ແລະ ຊື້ປີ້",
              ),
              const SizedBox(height: 10),
              Text(
                "ເບີໂທ ໜ່ວຍບໍລິການ ບໍລິສັດສະຖານີຄົວລົດໂຊກປະເສີດ: 2052164388",
              ),
              const SizedBox(height: 10),

              Text(
                "ເບີໂທ ໜ່ວຍບໍລິການ ສະຖານີຄົວລົດສາຍໃຕ້ : 2052164377",
              ),
            ],
          ),
        ),
        Step(
          state: currenStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currenStep >= 1,
          title: const Text(
            "ການຍົກເລີກປີ້",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
           content:const  Column(
            mainAxisAlignment: MainAxisAlignment.start, // Added this line
            children: [
             
               Text(
                "ການຍົກເລີກປີ້ແມ່ນທາງເຮົາບໍ່ສາມາດຖອນເງີນໃຫ້ກັບຄືນໄດ້ ກະລຸນາກວດຂໍ້ມູນລະອຽດກ່ອນຈອງປີ້ລົດ",
              ),
              const SizedBox(height: 10),
              
            ],
          ),
        ),
     
      ];

}
