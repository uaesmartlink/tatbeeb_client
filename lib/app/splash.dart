import 'package:flutter/material.dart';
import 'package:hallo_doctor_client/app/routes/app_pages.dart';
import 'package:splashscreen/splashscreen.dart';

class MySplashScreen extends StatelessWidget {
  final bool isUserLogin;

  const MySplashScreen({required this.isUserLogin, super.key});

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      photoSize: MediaQuery.of(context).size.width / 2.5,
      navigateAfterSeconds: isUserLogin ? AppPages.HOME : AppPages.OnBoarding,
      image: Image.asset("assets/icons/splash.gif"),
      gradientBackground: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF1b4170),
          Color(0xFF76e6da),
        ],
      ),
      useLoader: false,
      title: Text(''),
      loadingTextPadding: EdgeInsets.zero,
      styleTextUnderTheLoader: TextStyle(),
      loadingText: Text(''),
      backgroundColor: Color(0xFF1b4170),
    );
  }
}
