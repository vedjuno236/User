// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:get/get.dart';

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         backgroundColor: Colors.white,
//         body: Center(
//           child: Container(
//             width: MediaQuery.of(context).size.width * 0.5,
//             height: MediaQuery.of(context).size.height * 0.5,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset("assets/logo/laos-ticket.png"),
//                 Text(
//                   "LAO TICKEL",
//                   style: GoogleFonts.notoSansLao(
//                     fontWeight: FontWeight.bold,
//                     color:
//                         Colors.redAccent, // Place the color property correctly
//                     fontSize: 18,
//                     // Other text style properties can be added here
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:lottie/lottie.dart';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            // Wrap children in a Column
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.network(
                'https://lottie.host/58737db1-1465-46ed-a0b6-9b002031cef6/aaIbex2uYG.json',
              ),
              // Add some space between the Lottie animation and the image
              SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset("assets/logo/laos-ticket.png")),
            ],
          ),
        ),
      ),
    );
  }
}
