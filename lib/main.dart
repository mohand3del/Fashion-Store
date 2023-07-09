import 'package:ecommerce_app/layouts/layout_cubit/layout_cubit.dart';
import 'package:ecommerce_app/layouts/layout_screen.dart';
import 'package:ecommerce_app/modules/screens/Auth_screens/Auth_cubit/auth_cubit.dart';
import 'package:ecommerce_app/modules/screens/Login_Screen.dart';
import 'package:ecommerce_app/modules/screens/home_screen.dart';
import 'package:ecommerce_app/modules/screens/profile_screen/Profile_Screen.dart';
import 'package:ecommerce_app/shared/constant/constant.dart';
import 'package:ecommerce_app/shared/network/local_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'modules/screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheNetwork.cacheInitialization();
  token = CacheNetwork.getCacheData(key: "token");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthCubit()),
          BlocProvider(create: (context) => LayoutCubit()..getCarts()..getFavorites()..getBannersData()..getCategoryData()..getProducts())
        ],
        child: MaterialApp(
          theme: ThemeData(
            backgroundColor: Colors.white,
            primarySwatch: Colors.deepOrange,
          ),
          debugShowCheckedModeBanner: false,
           home:token != null? const LayoutScreen() : LoginScreen(),//token != null && token != ""
          //     ? const ProfileScreen()
          //     : LoginScreen(),
        ));
  }
}
