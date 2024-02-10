import 'package:flutter/material.dart';
import 'package:flutter_final/app/modules/home/views/home_view.dart';
import 'package:flutter_final/app/modules/login/controllers/login_controller.dart';
import 'package:flutter_final/app/modules/login/views/login_view.dart';
import 'package:get/get.dart';

class CheckAuthView extends StatelessWidget {
  const CheckAuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());
    loginController.checkLoggedIn();
    loginController.getUserLogged();

    return Obx(() {
      if (loginController.isLogin.value == "loading_page") {
        return Scaffold();
      } else if (loginController.isLogin.value == "home_page") {
        return HomeView();
      } else {
        return LoginView();
      }
    });
  }
}





// class CheckAuthView extends StatelessWidget {
//   const CheckAuthView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final loginController = Get.put(LoginController());

//     return FutureBuilder<void>(
//       future: loginController.signInAuthCredential(context),
//       // future: loginController.getPassengerList(),
//       builder: (context, AsyncSnapshot<void> snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           if (loginController.isLogin.isTrue) {
//             return HomeView();
//           } else {
//             return LoginView();
//           }
//         } else {
//           // You can return a loading indicator here if needed
//           return CircularProgressIndicator();
//         }
//       },
//     );
//   }
// }
