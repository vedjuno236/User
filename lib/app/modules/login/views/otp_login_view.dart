import 'package:flutter/material.dart';
import 'package:flutter_final/app/modules/home/views/home_view.dart';

import 'package:pinput/pinput.dart';

class OtpLoginView extends StatefulWidget {
  const OtpLoginView({Key? key}) : super(key: key);

  @override
  _OtpLoginViewState createState() => _OtpLoginViewState();
}

class _OtpLoginViewState extends State<OtpLoginView> {
  String? otpCode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/login');
                    },
                    child: const Icon(Icons.arrow_back_ios),
                  ),
                ),
                Container(
                  width: 200,
                  height: 200,
                  padding: const EdgeInsets.all(20.0),
                  // decoration: BoxDecoration(
                  //   shape: BoxShape.circle,
                  //   color: Colors.purple.shade50,
                  // ),
                  child: Image.asset(
                    "assets/logo/laos-ticket.png",
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "ລົງທະບຽນດ້ວຍເບີ",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "ເມືອເຂົ້າສູ່ລະບົບ/ລົງທະບຽນ ສະແດງວ່າທ່ານເຫັນດີ ຕໍ່ຂໍ້ຕົກລົງຄວາມເປັນສ່ວນຕົວ",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Pinput(
                  // onChanged: (val){
                  //   print(val);
                  // },
                  length: 6,
                  showCursor: true,
                  defaultPinTheme: PinTheme(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.purple.shade200,
                      ),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onSubmitted: (value) {
                    setState(() {
                      otpCode = value;
                    });
                  },
                ),
                SizedBox(height: 25),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: CustomButton(
                    text: "ກວດສອບ",
                    onPressed: () {
                      // if (otpCode != null) {
                      //   verifyOtp(context, otpCode!);
                      // } else {
                      //   showSnackBar(context, "Enter 6-Digit code");
                      // }
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeView()),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "ຢືນຢັນວ່າບໍ່ໄດ້ຮັບລະຫັດໃດໆ?",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  "ສົ່ງລະຫັດໃໝ່",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
      child: Text(text, style: const TextStyle(fontSize: 16)),
    );
  }
}
