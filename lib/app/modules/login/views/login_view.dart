import 'dart:ui';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/app/modules/login/Button/Button.dart';
// import 'package:flutter_final/app/modules/home/views/home_view.dart';
import 'package:flutter_final/app/modules/register/views/register_view.dart';
// import 'package:flutter_final/app/modules/login/views/otp_login_view.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';

import '../controllers/login_controller.dart';
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
    final LoginController timerController = LoginController();

    phoneController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: phoneController.text.length,
      ),
    );

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: ListView(
          children: [
            SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              height: 150,
              // width: 20,
              child: SizedBox(
                width: 200,
                height: 200,
                child: Image.asset(
                  "assets/logo/laos-ticket.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "ກະລຸນາໃສ່ດ້ວຍເບີໂທ ຂອງທ່ານ",
              style: GoogleFonts.notoSansLao(
                fontWeight: FontWeight.bold,
                color: Colors.black, // Place the color property correctly
                fontSize: 20,
                // Other text style properties can be added here
              ),
            ),
            const SizedBox(height: 30),
            Text(
              "ເບີໂທ",
              style: GoogleFonts.notoSansLao(
                fontWeight: FontWeight.bold,
                color: Colors.black, // Place the color property correctly
                fontSize: 18,
                // Other text style properties can be added here
              ),
            ),
            SizedBox(height: 10),
            GetBuilder<LoginController>(builder: (_) {
              return TextFormField(
                cursorColor: Colors.purple,
                controller: _.phoneC,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  hintText: "20 XXXXXXXX",
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
                                _.phoneCode = selectedCountry.phoneCode;
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
              );
            }),
            const SizedBox(height: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GetBuilder<LoginController>(builder: (_) {
                  return VerificationCode(
                    length: 6,
                    textStyle:
                        const TextStyle(fontSize: 20, color: Colors.black),
                    underlineColor: Colors.black,
                    keyboardType: TextInputType.number,
                    underlineUnfocusedColor: Colors.black26,
                    onCompleted: (value) {
                      _.setSmsCode(value);
                    },
                    onEditing: (value) {
                      _.setOnEditOTP(value);
                      if (!_.onEditing) FocusScope.of(context).unfocus();
                    },
                  );
                }),
                const SizedBox(height: 5),
                GetBuilder<LoginController>(builder: (_) {
                  return GestureDetector(
                    onTap: () {
                      _.signInPhone(context);
                      timerController.onReady();
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
                          child: Obx(
                            () => Center(
                              child: Text('${timerController.time.value}'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                })
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
                      style: GoogleFonts.notoSansLao(
                        fontWeight: FontWeight.bold,
                        color:
                            Colors.black, // Place the color property correctly
                        fontSize: 20,
                        // Other text style properties can be added here
                      ),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print("ເຫັນດີກັບ");
                            },
                          text: "ກັບເບີໂທ",
                          style: GoogleFonts.notoSansLao(
                            fontWeight: FontWeight.bold,
                            color: Colors
                                .black, // Place the color property correctly
                            fontSize: 20,
                            // Other text style properties can be added here
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
                        TextSpan(
                          text: ", ແລະ ",
                          style: GoogleFonts.notoSansLao(
                            fontWeight: FontWeight.bold,
                            color: Colors
                                .black, // Place the color property correctly
                            fontSize: 20,
                            // Other text style properties can be added here
                          ),
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print("ຄວາມຕົວຂອງ");
                            },
                          text: "ເປັນສ່ວນ",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 50,
                  child: GetBuilder<LoginController>(builder: (_) {
                    return CustomButton(
                      text: "ເຂົ້າສູລະບົບ",
                      onPressed: () {
                        _.signInAuthCredential(context);
                      },
                    );
                  }),
                ),
                SizedBox(
                  width: 5,
                ),
                SizedBox(
                  height: 50,
                  child: GetBuilder<LoginController>(builder: (_) {
                    return Button(
                      text: "ລົງທະບຽນເຂົ້າໃຊ້ລະບົບ",
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => RegisterView()));
                      },
                    );
                  }),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 70,
              child: OutlinedButton(
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
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  fixedSize: MaterialStateProperty.all<Size>(
                    Size(100, 50), // Set the width and height of the button
                  ),
                ),
              ),
            ),
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
