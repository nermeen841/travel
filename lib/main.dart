// ignore_for_file: use_key_in_widget_constructors, avoid_print, deprecated_member_use, unused_local_variable

import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel/business_logic/categories_cubit/categories_cubit.dart';
import 'package:travel/business_logic/favourite_cubit.dart/favourite_cubit_cubit.dart';
import 'package:travel/constants/constants.dart';
import 'package:travel/presentation/screens/splash/splash_screen.dart';
import 'business_logic/auth_cubit/authenticationcubit_cubit.dart';
import 'business_logic/database_helper/app_Cubit.dart';
import 'business_logic/home_cubit/home_cubit.dart';
import 'business_logic/search history/search_history_cubit.dart';
import 'business_logic/search_cubit/search_cubit.dart';
import 'constants/localization_constant.dart';
import 'generated/codegen_loader.dart';
import 'network/bloc_observer.dart';
import 'network/myHttpOverrider.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ');
}

Future<void> main() async {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  final token = await FirebaseMessaging.instance.getToken();
  SharedPreferences _sp = await SharedPreferences.getInstance();
  _sp.setString('device_token', "$token");
  print(token);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await startShared();
  await mapIcon();
  HttpOverrides.global = MyHttpOverrides();

  BlocOverrides.runZoned(
    () {
      runApp(EasyLocalization(
        supportedLocales: const [
          Locale('en', ''),
          Locale('ar', ''),
        ],
        path:
            'assets/translations', // <-- change the path of the translation files
        assetLoader: const CodegenLoader(),
        child: MyApp(),
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  setLocale(Locale locale) async {
    setState(() {
      context.locale = locale;
    });
    print('Applan:' + locale.toString());
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        context.locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  late FirebaseMessaging firebaseMessaging;

  @override
  void initState() {
    super.initState();

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        print("55555555555555555555555555555555555555555555555555555555555");
      }
    });
////////////////////////////////////////////////////////////////////////////////////////////////////////
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      print(notification!.body);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationcubitCubit>(
            create: (context) => AuthenticationcubitCubit()
              ..getGovernorates(countryID: '1')
              ..getCity(governorateID: '')),
        BlocProvider<AppCubit>(create: (context) => AppCubit()),
        BlocProvider<FavouriteCubit>(
            create: (context) => FavouriteCubit()..getFavouriteCat()),
        BlocProvider<SearchHistoryCubit>(
            create: (context) => SearchHistoryCubit()..createDb()),
        BlocProvider<CategoriesCubit>(
            create: (context) => CategoriesCubit()..getCategory()),
        BlocProvider<HomeCubit>(
            create: (context) => HomeCubit()
              ..getRecommended()
              ..getHomeCategory()),
        BlocProvider<SearchCubit>(
            create: (context) => SearchCubit()..getcitySearch())
      ],
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Poppins'),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        localeResolutionCallback: (locale, supportedLocales) {
          if (prefs.getString('lang').toString() == 'null') {
            for (var locale in supportedLocales) {
              if (locale.languageCode == Platform.localeName.split('_')[0]) {
                print("locale:$locale");
                return locale;
              }
            }

            return supportedLocales.first;
          } else {
            for (var locale in supportedLocales) {
              if (locale.languageCode == prefs.getString('lang').toString()) {
                return locale;
              }
            }

            return supportedLocales.first;
          }
        },
        home: const SafeArea(
          child: SplashScreen(),
        ),
      ),
    );
  }
}
