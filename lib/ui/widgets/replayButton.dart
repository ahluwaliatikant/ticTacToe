import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/ui/pages/gamePage.dart';
import 'package:tictactoe/ui/pages/twoPlayerMode.dart';

class ReplayButton extends StatelessWidget {
  final bool isTwoPlayer;
  final bool isMusic;

  ReplayButton({
    this.isMusic,
    this.isTwoPlayer,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ElevatedButton.icon(
          onPressed: () {
          if (isTwoPlayer) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => TwoPlayer(
                        isMusic: isMusic,
                      )),
              (route) => false);
          } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => GamePage(
                        isMusic: isMusic,
                      )),
              (route) => false);
        }
        },
          icon: Icon(
            Icons.replay,
            color: Colors.white,
          ),
          label: Text(
            "Replay",
            style: GoogleFonts.poppins(
            textStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
          ),
      style: ElevatedButton.styleFrom(
        primary: Color(0xFF1DD05D),
        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50))),
      ),
    ));
  }
}
