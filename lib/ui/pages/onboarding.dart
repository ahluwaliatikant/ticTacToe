import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/ui/pages/homePage.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {

  List<Slide> slides = new List();
  @override
  void initState() {
    super.initState();

    slides.add(
      Slide(
        title: "WELCOME",
        description: "A Tic Tac Toe game built with Flutter",
        pathImage:"images/first.jpg",
        backgroundColor: Color(0xFF222222),
        styleTitle: GoogleFonts.poppins(
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold
          ),
        ),
        styleDescription:GoogleFonts.poppins(textStyle:TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),),
      ),
    );
    slides.add(
      Slide(
        title: "Unbeatable AI Bot",
        description: "Play against an unbeatable AI Bot in One Player mode",
        pathImage: "images/second.png",
        backgroundColor: Color(0xFF222222),
        styleTitle: GoogleFonts.poppins(
          textStyle: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold
          ),
        ),
        styleDescription:GoogleFonts.poppins(textStyle:TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),),
      ),
    );
    slides.add(
      Slide(
        title: "Two Player Mode",
        description: "Play with your friends in Two Player Mode",
        pathImage: "images/third.png",
        backgroundColor: Color(0xFF222222),
        styleTitle: GoogleFonts.poppins(
          textStyle: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold
          ),
        ),
        styleDescription:GoogleFonts.poppins(textStyle:TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),),
      ),
    );
    slides.add(
       Slide(
        title: "Spotify Playback",
        description: "Play your favourite playlists from Spotify in background right from the app.\n\nNote: This feature is available only for Spotify Premium Customers.",
        pathImage: "images/fourth.png",
        backgroundColor: Color(0xFF222222),
         styleTitle: GoogleFonts.poppins(
           textStyle: TextStyle(
               color: Colors.white,
               fontSize: 30,
               fontWeight: FontWeight.bold
           ),
         ),
         styleDescription:GoogleFonts.poppins(textStyle:TextStyle(
           fontSize: 20,
           color: Colors.white,
         ),),
      ),
    );
  }
  void onDonePress(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
  }
  void onSkipPress(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroSlider(
        slides: this.slides,
        onDonePress: this.onDonePress,
        onSkipPress: this.onSkipPress,
      ),
    );
  }
}
