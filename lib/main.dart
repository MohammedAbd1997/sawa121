import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sawa/src/binding.dart';
import 'package:sawa/src/modules/doctor/view.dart';
import 'package:sawa/src/modules/login/view.dart';
import 'package:sawa/src/modules/main/view.dart';
import 'package:sawa/src/modules/on_boarding/view.dart';
import 'package:sawa/src/modules/rules/view.dart';
import 'package:sawa/src/modules/send_report/view.dart';
import 'package:sawa/src/modules/splash/view.dart';

import 'src/constant.dart';
import 'src/data/reomte/api_requests.dart';
import 'src/data/shared_preferences/pref_manger.dart';
import 'src/utils/languages/translations.dart';

bool isArabicLanguage = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  //HttpOverrides.global = MyHttpOverrides();
  // check if is running on Web
  if (kIsWeb) {
    // initialize the facebook javascript SDK
    FacebookAuth.i.webInitialize(
      appId: "231282632356704", //<-- YOUR APP_ID
      cookie: true,
      xfbml: true,
      version: "v9.0",
    );
    isArabicLanguage = await PrefManger().getIsArabic();
  }

  // setUrlStrategy(PathUrlStrategy());
  Binding().dependencies();
  runApp(EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/langs', // <-- change the path of the translation files
      fallbackLocale: Locale('en'),
      child: RestartWidget(child: const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 815),
        builder: () => GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Sawa 121',
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              theme: ThemeData(
                  fontFamily: "AvenirArabic",
                  scaffoldBackgroundColor: Colors.white,
                  primarySwatch: colorCustom,
                  appBarTheme: const AppBarTheme(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      elevation: 3)),
              initialBinding: Binding(),
              getPages: [
                GetPage(
                    name: '/', page: () => SplashPage(), binding: Binding()),
                GetPage(
                    name: '/send-report/:data',
                    page: () => SendReportPage(),
                    binding: Binding()),
                GetPage(
                    name: '/home', page: () => MainPage(), binding: Binding()),
                GetPage(
                    name: '/login',
                    page: () => LoginPage(),
                    binding: Binding()),
                GetPage(
                    name: '/rules',
                    page: () => RulesPage(),
                    binding: Binding()),
                GetPage(
                    name: '/doctor',
                    page: () => DoctorPage(),
                    binding: Binding()),
                GetPage(
                    name: '/on-boarding',
                    page: () => OnBoardingPage(),
                    binding: Binding()),
              ],
              initialRoute: "/",
            ));
  }
}

class RestartWidget extends StatefulWidget {
  RestartWidget({required this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()!.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
