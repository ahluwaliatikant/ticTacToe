import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/ui/widgets/grid.dart';
import 'package:tictactoe/ui/widgets/musicButtons.dart';

class GamePage extends StatefulWidget {
  final bool isMusic;

  GamePage({Key key , this.isMusic}) : super(key: key);
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;

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
              Text("Tic Tac Toe",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 40,
                        color: Colors.white
                    )
                ),
              ),
              SizedBox(
                height: height*0.1,
              ),
              Grid(
                isMusic: widget.isMusic,
              ),
              widget.isMusic?MusicButtons():Container(height: 0, width: 0,),
            ],
          ),
        ),
      ),
    );
  }
}