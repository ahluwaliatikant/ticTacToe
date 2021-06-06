import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/ui/pages/homePage.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoe/ui/pages/onboarding.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  var prefs = await SharedPreferences.getInstance();
  bool isOnboard = prefs.getBool("onboardingDone" ?? false);
  if(isOnboard == null){
    isOnboard = false;
  }
  runApp(MyApp(isOnboard: isOnboard,));
  //runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final bool isOnboard;

  MyApp({this.isOnboard});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe',
      home: isOnboard?HomePage():IntroScreen(),
    );
  }
}


