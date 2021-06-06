import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/ui/widgets/musicButtons.dart';
import 'package:tictactoe/ui/widgets/twoPlayerGrid.dart';

class TwoPlayer extends StatefulWidget {
  final bool isMusic;

  TwoPlayer({this.isMusic});
  @override
  _TwoPlayerState createState() => _TwoPlayerState();
}

class _TwoPlayerState extends State<TwoPlayer> {
  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFF222222),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 20 , bottom: 20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text("Tic Tac Toe",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 40,
                          color: Colors.white
                      )
                  ),
                ),
              ),
              SizedBox(
                height: height*0.1,
              ),
              TwoPlayerGrid(isMusic: widget.isMusic,),
              widget.isMusic?MusicButtons():Container(height: 0, width: 0,),
            ],
          ),
        ),
      ),
    );
  }
}
