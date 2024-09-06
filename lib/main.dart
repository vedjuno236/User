import 'package:flutter/material.dart';
import 'package:flutter_final/app/api/notification_api.dart';
import 'package:flutter_final/app/modules/check_auth/views/check_auth_view.dart';
import 'package:flutter_final/app/modules/login/controllers/login_controller.dart';
import 'package:flutter_final/app/widgets/splash.dart';
import 'package:flutter_final/firebase_options.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'app/routes/app_pages.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
//
  await initialization();

//
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseApi().initNotification();
  Intl.defaultLocale = 'lo_LA';
//

//
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final loginController = Get.put(LoginController());
  @override
  void initState() {
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
            ],
          );
        }
      },
    );
  }
}
