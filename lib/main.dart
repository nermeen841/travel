// ignore_for_file: use_key_in_widget_constructors

import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/business_logic/categories_cubit/categories_cubit.dart';
import 'package:travel/business_logic/database_helper/database_cubit.dart';
import 'package:travel/business_logic/favourite_cubit.dart/favourite_cubit_cubit.dart';
import 'package:travel/constants/constants.dart';
import 'package:travel/presentation/screens/splash/splash_screen.dart';
import 'business_logic/auth_cubit/authenticationcubit_cubit.dart';
import 'business_logic/database_helper/app_Cubit.dart';
import 'business_logic/home_cubit/home_cubit.dart';
import 'business_logic/search history/search_history_cubit.dart';
import 'business_logic/search_cubit/search_cubit.dart';
import 'generated/codegen_loader.g.dart';
import 'network/bloc_observer.dart';
import 'network/myHttpOverrider.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color(0xff3a0ca3),
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.light,
  ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationcubitCubit>(
            create: (context) => AuthenticationcubitCubit()
              ..getGovernorates(countryID: '1')
              ..getCity(governorateID: '')),
        BlocProvider<AppCubit>(create: (context) => AppCubit()),
        BlocProvider<DataBaseCubit>(
            create: (context) => DataBaseCubit()..createDb()),
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
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Color(0xff3a0ca3),
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.light,
              ),
            ),
            fontFamily: 'Poppins'),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale!.languageCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        home: const SafeArea(
          child: SplashScreen(),
        ),
      ),
    );
  }
}
