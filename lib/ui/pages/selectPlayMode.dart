import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/ui/widgets/modeButton.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SelectMode extends StatelessWidget {
  final bool isMusic;

  SelectMode({this.isMusic});
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFF222222),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: width,
              child: Text("Select Mode",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 40,
                        color: Colors.white
                    )
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Column(
              children: [
                ModeButton(
                  isTwoPlayer: false,
                  isMusic: isMusic,
                  title: "One Player",
                  icon: FaIcon(
                      FontAwesomeIcons.robot,
                      color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ModeButton(
                  isMusic: isMusic,
                  isTwoPlayer: true,
                  title: "Two Player",
                  icon: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}


