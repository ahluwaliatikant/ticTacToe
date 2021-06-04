import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:tictactoe/aiBot.dart';
//import 'package:tictactoe/aiBot.dart';
import 'package:tictactoe/ui/pages/gameOverPage.dart';
import 'package:tictactoe/utils/convertIndexDimension.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictactoe/board.dart';
import 'package:tictactoe/bot.dart';

class Grid extends StatefulWidget {
  final bool isMusic;

  Grid({this.isMusic});

  @override
  _GridState createState() => _GridState();
}

class _GridState extends State<Grid> {
  bool isUserChance = true;

  List<String> boxes = ["", "", "", "", "", "", "", "", ""];
  List<bool> isAllowed = [true, true, true, true, true, true, true, true, true];
  Board board = new Board();

  void tapped(int idx) {
    if (!isUserChance) {
      Fluttertoast.showToast(
          msg: "Not your chance!", toastLength: Toast.LENGTH_SHORT);
      return;
    } else if (!isAllowed[idx]) {
      Fluttertoast.showToast(
          msg: "Box already filled", toastLength: Toast.LENGTH_SHORT);
      return;
    }

    List<int> indices = ConvertIndexDimension().determineTwoDIndex(idx);

    setState(() {
      boxes[idx] = "X";
      isAllowed[idx] = false;
      isUserChance = false;
    });

//    for(int i=0 ; i<board.all_positions.length ; i++){
//      print(board.all_positions[i].getCurrentPlayer());
//    }

    Map<String, dynamic> returnedJsonObject =
        AI_Bot.make_move(board, indices[0], indices[1]);

    print(returnedJsonObject);

    if (returnedJsonObject["gameState"] == "continue") {
      int row = returnedJsonObject["botPositionX"];
      int col = returnedJsonObject["botPositionY"];
      List<int> twoDimensional = [row, col];
      int boxIdx = ConvertIndexDimension().determineOneDIndex(twoDimensional);
      setState(() {
        boxes[boxIdx] = "O";
        isAllowed[boxIdx] = false;
        isUserChance = true;
      });

      return;
    }

    if (returnedJsonObject["gameState"] == "botWins") {
      int row = returnedJsonObject["botPositionX"];
      int col = returnedJsonObject["botPositionY"];
      List<int> twoDimensional = [row, col];
      int boxIdx = ConvertIndexDimension().determineOneDIndex(twoDimensional);
      setState(() {
        boxes[boxIdx] = "O";
        isAllowed[boxIdx] = false;
      });

      Future.delayed(Duration(milliseconds: 500), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => GameOver(
              title: "Bot Wins",
              image: FaIcon(
                  FontAwesomeIcons.robot,
                  size: 120,
                  color: Colors.white
              ),
              isMusic: widget.isMusic,
              isTwoPlayer: false,
            )),
            (route) => false);
      });

      return;
    }

    if (returnedJsonObject["gameState"] == "tied") {
      Future.delayed(Duration(milliseconds: 500), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => GameOver(
              title: "Its A Tie",
              image: Image.asset("images/gameTied.png",),
              isMusic: widget.isMusic,
              isTwoPlayer: false,
            )),
            (route) => false);
      });

      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: GridView.builder(
            shrinkWrap: true,
            itemCount: 9,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  tapped(index);
                },
                child: Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white)),
                  child: Center(
                    child: Text(
                      boxes[index],
                      style: GoogleFonts.gochiHand(
                        textStyle: TextStyle(
                          color:
                              boxes[index] == 'X' ? Colors.white : Colors.red,
                          fontSize: 50,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
