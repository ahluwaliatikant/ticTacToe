import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/ui/pages/gamePage.dart';
import 'package:tictactoe/ui/pages/twoPlayerMode.dart';

class ModeButton extends StatelessWidget {
  final bool isTwoPlayer;
  final String title;
  final Widget icon;
  final bool isMusic;

  const ModeButton({
    Key key,
    this.title,
    this.icon,
    this.isTwoPlayer,
    this.isMusic
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(isTwoPlayer){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> TwoPlayer(isMusic: isMusic,)));
        }else {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> GamePage(isMusic: isMusic,)));
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Icon(
              Icons.person,
              color: Colors.black,
            ),
            Text(
              "vs",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  )
              ),
            ),
            SizedBox(
              width: 2,
            ),
            icon,
          ],
        ),
      ),
    );
  }
}