import 'package:country_picker/country_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/app/modules/home/views/home_view.dart';
// import 'package:flutter_final/app/modules/login/views/otp_login_view.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
// import 'package:get/get.dart';
// import 'package:flutter_final/app/routes/app_pages.dart';
// import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

final TextEditingController phoneController = TextEditingController();
Country selectedCountry = Country(
  phoneCode: "856",
  countryCode: "LAOS",
  e164Sc: 0,
  geographic: true,
  level: 1,
  name: "Laos",
  example: "Laos",
  displayName: "Laos",
  displayNameNoCountryCode: "LAOS",
  e164Key: "",
);

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    phoneController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: phoneController.text.length,
      ),
    );

// import '../controllers/login_controller.dart';

// class LoginView extends GetView<LoginController> {
//   final TextEditingController phoneController = TextEditingController();
//   Country selectedCountry = Country(
//     phoneCode: "856",
//     countryCode: "LAOS",
//     e164Sc: 0,
//     geographic: true,
//     level: 1,
//     name: "Laos",
//     example: "Laos",
//     displayName: "Laos",
//     displayNameNoCountryCode: "LAOS",
//     e164Key: "",
//   );

//   @override
//   Widget build(BuildContext context) {
//     phoneController.selection = TextSelection.fromPosition(
//       TextPosition(
//         offset: phoneController.text.length,
//       ),
//     );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              height: 150,
              child: Image.asset(
                "assets/logo/logo-laos.png",
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "ກະລຸນາໃສ່ດ້ວຍເບີໂທ ຂອງທ່ານ",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "ເບີໂທ",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            // TextField(
            //   controller: controller.phoneC,
            //   keyboardType: TextInputType.phone,
            //   autocorrect: false,
            //   decoration: InputDecoration(
            //     border: OutlineInputBorder(),
            //     hintText: "020 xx xxx xxx",
            //   ),
            // ),
            TextFormField(
              cursorColor: Colors.purple,
              controller: phoneController,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              onChanged: (value) {
                setState(() {
                  phoneController.text = value;
                });
              },
              decoration: InputDecoration(
                hintText: "020 12345678",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 19,
                  color: Colors.grey.shade600,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black12),
                ),
                prefixIcon: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      showCountryPicker(
                          context: context,
                          countryListTheme: const CountryListThemeData(
                            bottomSheetHeight: 550,
                          ),
                          onSelect: (value) {
                            setState(() {
                              selectedCountry = value;
                            });
                          });
                    },
                    child: Text(
                      "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode} |",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                suffixIcon: phoneController.text.length > 9
                    ? Container(
                        height: 30,
                        width: 30,
                        margin: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                        child: const Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 20,
                        ),
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 5),
            Column(
              children: [
                VerificationCode(
                  length: 6,
                  textStyle: const TextStyle(fontSize: 20, color: Colors.black),
                  underlineColor: Colors.black,
                  keyboardType: TextInputType.number,
                  underlineUnfocusedColor: Colors.black26,
                  onCompleted: (value) {},
                  onEditing: (value) {},
                ),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: () {
                    // Handle the tap here
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.redAccent),
                        ),
                        child: const Center(
                          child: Text(
                            "ຂໍລະຫັດ OTP",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                // Obx(
                //   () => Checkbox(
                //     activeColor: Colors.red,
                //     value: controller.checkC.value,
                //     onChanged: (value) => controller.checkC.toggle(),
                //   ),
                // ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: "ຂ້ອຍຕົກລົງ,  ",
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print("ເຫັນດີກັບ");
                            },
                          text: "ກັບເບີໂທ",
                          style: const TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        const TextSpan(
                          text: ",",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print("ຂອງຂ້ອຍ");
                            },
                          // text: "ketentuan",
                          // style: TextStyle(
                          //   color: Colors.red,
                          // ),
                        ),
                        const TextSpan(
                          text: ", ແລະ ",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print("ຄວາມຕົວຂອງ");
                            },
                          text: "ເປັນສ່ວນ",
                          style: const TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        const TextSpan(
                          text: " ຕົວຂອງຂ້ອຍ",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: CustomButton(
                text: "ເຂົ້າສູລະບົບ",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeView()),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),
            const Center(
              child: Text("ຫຼືເຂົ້າສູ່ລະບົບໂດຍໃຊ້"),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/icons/fb.png"),
                      const SizedBox(width: 7),
                      const Text(
                        "Facebook",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF3B5998),
                        ),
                      ),
                    ],
                  ),
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(
                  const    Size(150, 50),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    side: MaterialStateProperty.all(
                      const BorderSide(
                        color: Color(0xFF3B5998),
                      ),
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/icons/google.png"),
                      const SizedBox(width: 7),
                      const Text(
                        "Google",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF1DA1F2),
                        ),
                      ),
                    ],
                  ),
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(
                     const Size(150, 50),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    side: MaterialStateProperty.all(
                      const BorderSide(
                        color: Color(0xFF1DA1F2),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
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
