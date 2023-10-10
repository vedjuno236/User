import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({ Key? key }) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: IntroductionScreen(
        globalBackgroundColor: Colors.white,
        scrollPhysics: BouncingScrollPhysics(),
        pages: [
          PageViewModel(
            titleWidget: Text(
              "ຊີວິດທີລຽບງ່າຍ",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            body: "ສະໜອງການບໍລິການທີສະດວກໃຫ້ແກ່ທ່ານໃນການເດີນທາງ",
            
            image: Image.asset("assets/image1.png", width: 400, height: 400,),
            
            //  SvgPicture.asset("assets/Img_car1.svg"),
          ),
          PageViewModel(
            titleWidget: Text(
              "ຄວາມປອດໄພຂອງການຊໍາລະ",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            body: "ປ້ອງກັນຄວາມປອດໄພບັນຊີຂອງທ່ານຕະຫຼອດເວລາ",
            image: Image.asset("assets/image2.png", width: 300, height: 300),
            //  SvgPicture.asset("assets/Img_car1.svg"),
          ),
          PageViewModel(
            titleWidget: Text(
              "ຊີວິດໃໝ່",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            body: "Lao Tickt ນໍາທ່ານມາສໍາພັດຮູບແບບການດໍາລົງຊີວິດໃໝ່",
            image: Image.asset("assets/image3.png", width: 400, height: 300),
            //  SvgPicture.asset("assets/Img_car1.svg"),
          ),
        ],
        onDone: () {
          Navigator.pushNamed(context, '/login');
        },
        onSkip: () {},
        showSkipButton: true,
        skip: Text(
          "",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6C63FF),
          ),
        ),
        next: Icon(Icons.arrow_forward_ios, color: Color(0xFF6C63FF)),
        done: Text(
          "ເປີດ Lao Tickt",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6C63FF),
          ),
        ),
        dotsDecorator: DotsDecorator(
          size: Size.square(10.0),
          activeSize: Size(20.0, 10.0),
          color: Colors.black,
          activeColor: Color(0xFF6C63FF),
          spacing: EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    );
  }
}
