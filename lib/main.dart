import 'package:educatednearby/screens/category.dart';
import 'package:educatednearby/screens/chance.dart';
import 'package:educatednearby/screens/home_page.dart';
import 'package:educatednearby/screens/login.dart';
import 'package:educatednearby/screens/map_screen.dart';
import 'package:educatednearby/screens/signup.dart';
import 'package:educatednearby/screens/splash_screen.dart';
import 'package:educatednearby/view_model/banner_view.dart';
import 'package:educatednearby/view_model/category_view.dart';
import 'package:educatednearby/view_model/chance_view.dart';
import 'package:educatednearby/view_model/cv_view.dart';
import 'package:educatednearby/view_model/news_view.dart';
import 'package:educatednearby/view_model/service_view.dart';
import 'package:educatednearby/view_model/store_view.dart';
import 'package:educatednearby/view_model/subcat_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package/applocal.dart';
import 'screens/service.dart';

SharedPreferences sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BannerViewModel()),
        ChangeNotifierProvider(create: (_) => NewsViewModel()),
        ChangeNotifierProvider(create: (_) => ServiceViewModel()),
        ChangeNotifierProvider(create: (_) => StoreViewModel()),
        ChangeNotifierProvider(create: (_) => ChanceViewModel()),
        ChangeNotifierProvider(create: (_) => CategoryViewModel()),
        ChangeNotifierProvider(create: (_) => SubCategoryViewModel()),
        ChangeNotifierProvider(create: (_) => CvViewModel())
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          AppLocale.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale("en", ""),
          Locale("ar", ""),
        ],
        localeResolutionCallback: (currentLang, supportLang) {
          if (currentLang != null) {
            for (Locale local in supportLang) {
              if (local.languageCode == currentLang.languageCode) {
                sharedPreferences.setString("lang", currentLang.languageCode);
                return currentLang;
              }
            }
          }
          return supportLang.first;
        },
        locale: _locale,
        title: 'Daleelak',
        theme: ThemeData(fontFamily: 'Regular'),
        debugShowCheckedModeBanner: false,
        initialRoute: null == sharedPreferences.getBool("loggedin") ||
                false == sharedPreferences.getBool("loggedin")
            ? 'SplashScreen'
            : 'Category',
        routes: {
          'Home': (context) => HomePage(),
          'SplashScreen': (context) => SplashScreen(),
          'Login': (context) => LoginScreen(),
          'Signup': (context) => SignupScreen(),
          'Map': (context) => MapScreen(),
          'Chance': (context) => ChanceScreen(),
          'Service': (context) => ServiceScreen(),
          'Category': (context) => CategoryScreen(),
        },
      ),
    );
  }
}
