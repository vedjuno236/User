import 'package:flutter/material.dart';
import 'package:flutter_final/app/modules/login/views/login_view.dart';
// import 'package:flutter_final/app/modules/login/views/otp_login_view.dart';
// import 'package:flutter_final/app/modules/login/views/login_view.dart';
import 'package:flutter_final/firebase_options.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'app/routes/app_pages.dart';
import 'app/widgets/splash.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Intl.defaultLocale = 'lo_LA';
  WidgetsFlutterBinding.ensureInitialized();
  runApp(DevicePreview(
    builder: (context) => MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return GetMaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: "Application",
    //   initialRoute: Routes.LOGIN,
    //   getPages: AppPages.routes,
    // );
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 3)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        } else {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            // ChangeNotifierProvider(create: (_) => AuthProvider()),
            title: "Application",
            // initialRoute: Routes.LOGIN,
            home: LoginView(),
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
