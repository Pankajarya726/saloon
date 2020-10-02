import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Splash/SplashActivity.dart';
import 'VendorList/VendorClass.dart';
import 'language/AppLanguage.dart';
import 'language/AppLocalizations.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();

  WidgetsFlutterBinding.ensureInitialized();


  runApp(MyApp(
    appLanguage: appLanguage,
  ));
}


class MyApp extends StatelessWidget {
  final AppLanguage appLanguage;

  MyApp({this.appLanguage});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return /*MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        fontFamily: "TimeRomanBold",
        accentColor: const Color(0xFF549afe),
        backgroundColor:  const Color(0xFF549afe),
        primaryColorDark: const Color(0xFFffffff),
        primarySwatch: blue,
        primaryTextTheme: TextTheme(
            title: TextStyle(
                color: Colors.black
            )
        ),
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashActivity(),
    )*/
      ChangeNotifierProvider<AppLanguage>(
        create: (_) => appLanguage,
        child: Consumer<AppLanguage>(builder: (context, model, child) {
          return MaterialApp(
            theme: ThemeData(
              canvasColor: Colors.transparent,
              fontFamily: "TimeRomanBold",
              accentColor: const Color(0xFF549afe),
              backgroundColor:  const Color(0xFF549afe),
              primaryColorDark: const Color(0xFFffffff),
              primarySwatch: blue,
              primaryTextTheme: TextTheme(
                  title: TextStyle(
                      color: Colors.black
                  )
              ),
            ),
            locale: model.appLocale,
            supportedLocales: [
              Locale('en', 'US'),
              Locale('ar', ''),
            ],
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            home: SplashActivity(),
            //home: MyHomePageCal(),
            //    home: ForgotPasswordActivity(),
          );
        }),
      );

  }
  static const MaterialColor blue = MaterialColor(
    _bluePrimaryValue,
    <int, Color>{
      50: Color(0xFFE3F2FD),
      100: Color(0xFFE3F2FD),
      200: Color(0xFFffffff),
      300: Color(0xFFffffff),
      400: Color(0xFFffffff),
      500: Color(_bluePrimaryValue),
      600: Color(0xFFffffff),
      700: Color(0xFFffffff),
      800: Color(0xFFffffff),
      900: Color(0xFFffffff),
    },
  );
  static const int _bluePrimaryValue = 0xFFffffff;
}
