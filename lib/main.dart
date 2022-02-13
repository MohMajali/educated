import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:educatednearby/appstate.dart';
import 'package:educatednearby/router/back_dispatcher.dart';
import 'package:educatednearby/router/pageconfig.dart';
import 'package:educatednearby/router/routerdelegate.dart';
import 'package:educatednearby/router/routes_parser.dart';
import 'package:educatednearby/screens/category.dart';
import 'package:educatednearby/screens/chance.dart';
import 'package:educatednearby/screens/home_page.dart';
import 'package:educatednearby/screens/login.dart';
import 'package:educatednearby/screens/map_screen.dart';
import 'package:educatednearby/screens/navbar.dart';
import 'package:educatednearby/screens/signup.dart';
import 'package:educatednearby/screens/singleservice.dart';
import 'package:educatednearby/screens/splash_screen.dart';
import 'package:educatednearby/screens/subcategroy.dart';
import 'package:educatednearby/view_model/banner_view.dart';
import 'package:educatednearby/view_model/category_view.dart';
import 'package:educatednearby/view_model/chance_view.dart';
import 'package:educatednearby/view_model/cv_view.dart';
import 'package:educatednearby/view_model/dropcatlist.dart';
import 'package:educatednearby/view_model/news_view.dart';
import 'package:educatednearby/view_model/search_vendor.dart';
import 'package:educatednearby/view_model/service_view.dart';
import 'package:educatednearby/view_model/store_view.dart';
import 'package:educatednearby/view_model/subcat_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';
import 'package/applocal.dart';
import 'screens/service.dart';

SharedPreferences sharedPreferences;
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // print('A bg message just showed up :  ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
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
  var route;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
          ChangeNotifierProvider(create: (_) => CvViewModel()),
          ChangeNotifierProvider(create: (_) => CategoryListViewModel()),
          ChangeNotifierProvider(create: (_) => SearchViewModel()),
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
          title: '',
          theme: ThemeData(fontFamily: 'Regular'),
          debugShowCheckedModeBanner: false,
          initialRoute: null == sharedPreferences.getBool("loggedin") ||
                  false == sharedPreferences.getBool("loggedin")
              ? 'SplashScreen'
              : 'nav',
          routes: {
            'Home': (context) => HomePage(),
            'SplashScreen': (context) => SplashScreen(),
            'Login': (context) => LoginScreen(),
            'Signup': (context) => SignupScreen(),
            'Map': (context) => MapScreen(),
            'Chance': (context) => const ChanceScreen(),
            'Service': (context) => const ServiceScreen(),
            'Category': (context) => const CategoryScreen(),
            "nav": (context) => NavBar(),
            "/SingleServiceScreen": (context) => const SingleServiceScreen(),
            "/SubCategoryScreen": (context) => const SubCategoryScreen()
          },
        ));
  }
}
