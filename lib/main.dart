import 'dart:io';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:ebsar/core/utils/observer.dart';
import 'package:ebsar/features/home/presentation/cubit/command_cubit.dart';
import 'package:ebsar/features/home/presentation/cubit/home_cubit.dart';
import 'package:ebsar/features/home/presentation/screens/command_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CommandCubit()
            ..getBooks()
            ..getCategories()
            ..welcome(),
        ),
      ],
      child: MaterialApp(
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset(
        'assets/lotties/splash.json',
      ),
      backgroundColor: Colors.white,
      nextScreen: CommandScreen(),
      splashIconSize: 300,
      duration: 4000,
      splashTransition: SplashTransition.fadeTransition,
      //pageTransitionType: PageTransitionType.leftToRightWithFade,
      animationDuration: const Duration(seconds: 1),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
