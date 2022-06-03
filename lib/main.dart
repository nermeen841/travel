// ignore_for_file: use_key_in_widget_constructors

import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

Future<void> main() async {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();

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
  Locale? _locale;
  setLocale(Locale locale) async {
    setState(() {
      _locale = locale;
      // DBHelper.saveAppLang(locale.toString());00
    });
    print('Applan:' + locale.toString());
    // print('Applanshard:' + User.appLang);
  }

  @override
  void didChangeDependencies() {
    getLocale(context).then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
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
        locale: _locale,
        // localeResolutionCallback: (locale, supportedLocales) {
        //   for (var supportedLocale in supportedLocales) {
        //     if (supportedLocale.languageCode == locale!.languageCode) {
        //       return supportedLocale;
        //     }
        //   }
        //   return supportedLocales.first;
        // },

        localeResolutionCallback: (deviceLocale, supportedLocales) {
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
