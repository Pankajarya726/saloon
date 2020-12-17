import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:salon_app/CommonMenuClass.dart';
import 'Appointment/AppointmentClass.dart';
import 'Availabilty/AvailabiltyClass.dart';
import 'Availabilty/ConfirmationClass.dart';
import 'CartPackage/GetCartItemClass.dart';
import 'NearByBarber/FullScreenMap.dart';
import 'NearByBarber/NearByClass.dart';
import 'SearchModel/SearchCategory.dart';
import 'SearchModel/SearchUsers.dart';
import 'SignInSignUpAccount/RegularAccount.dart';
import 'SignInSignUpAccount/SignInClass.dart';
import 'Splash/SplashActivity.dart';
import 'VendorList/ProductClass.dart';
import 'VendorList/VendorClass.dart';
import 'language/AppLanguage.dart';
import 'language/AppLocalizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
  MyApp(
    appLanguage: appLanguage,
  ));
}


class MyApp extends StatelessWidget {
  final AppLanguage appLanguage;
  MyApp({this.appLanguage});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)
  {
    return
      ChangeNotifierProvider<AppLanguage>(
        create: (_) => appLanguage,
        child: Consumer<AppLanguage>(builder: (context, model, child) {
          return MaterialApp(
            theme: ThemeData(
              canvasColor: Colors.transparent,
              fontFamily: "TimeRomanBold",
              accentColor: const Color(0xFF549afe),
              backgroundColor:  const Color(0xFF549afe),
              primaryColorDark: const Color(0xFF000000),
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
             //home: CommonDashBord("my_cart",false),
              //home: DateRangePicker(),
             //  home: SearchUsers(),
            //  home: RegularAccount("user"),
           //     home: MyHomePageCal(),
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
