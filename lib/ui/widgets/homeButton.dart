import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/ui/pages/homePage.dart';
import 'package:tictactoe/services/player.dart';

class HomeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ElevatedButton.icon(
          onPressed: () {
            Player().pause();
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
          },
          icon: Icon(
            Icons.home,
            color: Colors.white,
          ),
          label: Text(
            "Home",
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                )
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: Color(0xFF1DD05D),
            padding: EdgeInsets.only(left: 20 , right: 20, top: 10 , bottom: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
          ),
        )
    );
  }
}
