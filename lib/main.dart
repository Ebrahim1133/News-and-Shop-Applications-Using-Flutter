// @dart=2.9
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter/services.dart';

import 'package:flutter_abdullamansour/layouts/todo_app/todo_layout.dart';


import 'package:flutter_abdullamansour/shared/bloc_observer.dart';
import 'package:flutter_abdullamansour/shared/components/constants.dart';
import 'package:flutter_abdullamansour/shared/cubit/cubit.dart';
import 'package:flutter_abdullamansour/shared/cubit/states.dart';
import 'package:flutter_abdullamansour/shared/network/local/cache_helper.dart';
import 'package:flutter_abdullamansour/shared/network/remote/dio_helper.dart';
import 'package:flutter_abdullamansour/shared/styles/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'layouts/news_app/cubit/cubit.dart';
import 'layouts/shop_app/cubit/cubit.dart';
// ignore: unused_import
import 'layouts/shop_app/shop_layout.dart';
// ignore: unused_import
import 'modules/shop_app/login/shop_login_screen.dart';
// ignore: unused_import
import 'modules/shop_app/on_boarding/on_boarding_screen.dart';

void main() async {
  // بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يتفح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool isDark = CacheHelper.getData(key: 'isDark');

  Widget widget;

  //bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  //token = CacheHelper.getData(key: 'token');

  uId = CacheHelper.getData(key: 'uId');

  // if(onBoarding != null)
  // {
  //   if(token != null) widget = ShopLayout();
  //   else widget = ShopLoginScreen();
  // } else
  //   {
  //     widget = OnBoardingScreen();
  //   }


  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

// Stateless
// Stateful

// class MyApp

class MyApp extends StatelessWidget {
  // constructor
  // build
  final bool isDark;
  final Widget startWidget;

  MyApp({
    this.isDark,
    this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()
            ..getBusiness()
            ..getSports()
            ..getScience(),
        ),
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),
        BlocProvider(
          create: (BuildContext context) => ShopCubit()
            ..getHomeData()
            ..getCategories()
            ..getFavorites()
            ..getUserData(),
        ),

      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.light : ThemeMode.dark,
            home: startWidget,
          );
        },
      ),
    );
  }
}

// ./gradlew signingReport
