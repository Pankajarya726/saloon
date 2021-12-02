import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'Splash/SplashActivity.dart';
import 'language/AppLanguage.dart';
import 'language/AppLocalizations.dart';

Future<void> main() async {
  // SharedPreferences.setMockInitialValues({});
  WidgetsFlutterBinding.ensureInitialized();
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
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
    return ChangeNotifierProvider<AppLanguage>(
      create: (_) => appLanguage,
      child: Consumer<AppLanguage>(builder: (context, model, child) {
        return MaterialApp(
          theme: ThemeData(
            canvasColor: Colors.transparent,
            fontFamily: "TimeRomanBold",
            accentColor: const Color(0xFF549afe),
            backgroundColor: const Color(0xFF549afe),
            primaryColorDark: const Color(0xFF000000),
            primarySwatch: blue,
            primaryTextTheme: TextTheme(title: TextStyle(color: Colors.black)),
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
            GlobalCupertinoLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          home: SplashActivity(),
        );
      }),
    );
  }

  static const MaterialColor blue = MaterialColor(
    _bluePrimaryValue,
    <int, Color>{
      50: Color(0xFFe1e1e1),
      100: Color(0xFFE3F2FD),
      200: Color(0xFFE3F2FD),
      300: Color(0xFFE3F2FD),
      400: Color(0xFFE3F2FD),
      500: Color(_bluePrimaryValue),
      600: Color(0xFFE3F2FD),
      700: Color(0xFFE3F2FD),
      800: Color(0xFFE3F2FD),
      900: Color(0xFFE3F2FD),
    },
  );
  static const int _bluePrimaryValue = 0xFF808080;
}
