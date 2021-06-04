import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/ui/widgets/homeButton.dart';
import 'package:tictactoe/ui/widgets/replayButton.dart';

class GameOver extends StatelessWidget {
  final String title;
  final Widget image;
  final bool isTwoPlayer;
  final bool isMusic;

  GameOver({this.title , this.image , this.isMusic , this.isTwoPlayer});
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFF222222),
      body: SafeArea(
        child: Container(
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "GAME OVER",
                style: GoogleFonts.pressStart2p(
                    textStyle: TextStyle(
                        fontSize: 30,
                        color: Colors.white
                    )
                ),
              ),
              Container(child: Center(child: image), width: width*0.8, height: height*0.4,),
              Text(
                title,
                style: GoogleFonts.audiowide(
                    textStyle: TextStyle(
                        fontSize: 40,
                        color: Colors.white
                    )
                ),
              ),
              Column(
                children: [
                  ReplayButton(
                    isMusic: isMusic,
                    isTwoPlayer: isTwoPlayer,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  HomeButton(),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
