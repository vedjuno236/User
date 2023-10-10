import 'package:country_picker/country_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/app/modules/login/views/otp_login_view.dart';
// import 'package:flutter_final/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
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
  @override
  Widget build(BuildContext context) {
    phoneController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: phoneController.text.length,
      ),
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: ListView(
          children: [
            SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              height: 150,
              child: Image.asset(
                "assets/logo/logo-laos.png",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 30),
            Text(
              "ກະລຸນາໃສ່ດ້ວຍເບີໂທ ຂອງທ່ານ",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            Text(
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
              // onChanged: (value) {
              //   setState(() {
              //     phoneController.text = value;
              //   });
              // },
              decoration: InputDecoration(
                hintText: "020 12345678",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
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
                            // setState(() {
                            //   selectedCountry = value;
                            // });
                          });
                    },
                    child: Text(
                      "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
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
            SizedBox(height: 10),
            Row(
              children: [
                Obx(
                  () => Checkbox(
                    activeColor: Colors.red,
                    value: controller.checkC.value,
                    onChanged: (value) => controller.checkC.toggle(),
                  ),
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: "ຂ້ອຍຕົກລົງ,  ",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print("ເຫັນດີກັບ");
                            },
                          text: "ກັບເບີໂທ",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        TextSpan(
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
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        TextSpan(
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
            SizedBox(height: 30),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: CustomButton(
                text: "ເຂົ້າສູລະບົບ",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OtpLoginView()),
                  );
                },
              ),
            ),
            // ElevatedButton(
            //   // onPressed: () => Get.offAllNamed(Routes.HOME),
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => OtpLoginView()),
            //     );
            //   },
            //   child: Text(
            //     "ເຂົ້າສູ່ລະບົບ",
            //     style: TextStyle(fontSize: 16,
            //       color: Colors.white,
            //     ),
            //   ),
            //   // style: ElevatedButton.styleFrom(
            //   //   primary: Colors.grey[300],
            //   //   fixedSize: Size(150, 50),
            //   // ),
            //   style: ButtonStyle(
            //     foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            //     backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
            //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //        RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(25.0),
            //        ),
            //     ),

            //   ),
            // ),
            SizedBox(height: 20),
            Center(
              child: Text("ຫຼືເຂົ້າສູ່ລະບົບໂດຍໃຊ້"),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/icons/fb.png"),
                      SizedBox(width: 7),
                      Text(
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
                      Size(150, 50),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    side: MaterialStateProperty.all(
                      BorderSide(
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
                      SizedBox(width: 7),
                      Text(
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
                      Size(150, 50),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    side: MaterialStateProperty.all(
                      BorderSide(
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
