import 'package:flutter/material.dart';
// import 'package:flutter_final/app/modules/book_tickets/views/add_a_contact.dart';
// import 'package:flutter_final/app/modules/book_tickets/views/add_passengers.dart';
import 'package:flutter_final/app/modules/check_auth/views/check_auth_view.dart';
import 'package:flutter_final/app/modules/login/controllers/login_controller.dart';
import 'package:flutter_final/app/modules/login/views/login_view.dart';
import 'package:flutter_final/app/widgets/splash.dart';
// import 'package:flutter_final/app/modules/mytickets/controllers/my_tickets_controller.dart';
// import 'package:flutter_final/app/modules/login/views/login_view.dart';
import 'package:flutter_final/firebase_options.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'app/routes/app_pages.dart';

// import 'package:device_preview/device_preview.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseApi().initNotification();
  Intl.defaultLocale = 'lo_LA';

  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   MyApp({Key? key}) : super(key: key);

//   final LoginController loginController = LoginController();

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "Application",
//       initialRoute: Routes.LOGIN,
//       getPages: AppPages.routes,
//     );
//   }
// }

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final loginController = Get.put(LoginController());
  @override
  void initState() {
    // loginController.checkLoggedIn();
    // loginController.getUserLogged();
    // loginController.logout();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 8)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        } else {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            //  ChangeNotifierProvider(create: (_) => AuthProvider()),
            title: "Application",
            // initialRoute: i == 0 ? Routes.HOME : Routes.LOGIN,
            home: CheckAuthView(),

            getPages: AppPages.routes,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('lo', 'LA'),
              Locale('en'),

              // Add other supported locales here
            ],
          );
        }
      },
    );
  }
}






// void initializeFirebaseAppCheck() {
//   FirebaseAppCheck.instance
//       .installAppCheckProviderFactory(
//         providerFactory,
//       )
//       .catchError((error) {
//         print("Error installing App Check provider: $error");
//       });
// }

// AppCheckProviderFactory providerFactory = (AppCheckDebugProviderFactory());
