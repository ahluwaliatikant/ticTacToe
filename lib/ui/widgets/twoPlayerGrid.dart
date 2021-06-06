import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/ui/pages/gameOverPage.dart';
import 'package:tictactoe/utils/convertIndexDimension.dart';
import 'package:tictactoe/game/bot.dart';
import 'package:tictactoe/game/board.dart';

class TwoPlayerGrid extends StatefulWidget {
  final isMusic;

  TwoPlayerGrid({this.isMusic});
  @override
  _TwoPlayerGridState createState() => _TwoPlayerGridState();
}

class _TwoPlayerGridState extends State<TwoPlayerGrid> {
  List<String> boxes = ["", "", "", "", "", "", "", "", ""];
  List<bool> isAllowed = [true, true, true, true, true, true, true, true, true];
  Board board = new Board();
  int filledBoxes = 0;
  String currentPlayer = "X";
  void tapped(int index, String player) {
    if (!isAllowed[index]) {
      Fluttertoast.showToast(msg: "Box Already Filled");
      return;
    }

    setState(() {
      isAllowed[index] = false;
      boxes[index] = player;
      filledBoxes++;
    });

    List<int> indices = ConvertIndexDimension().determineTwoDIndex(index);

    Map<String, dynamic> returnedJsonObject =
        board.returnNewGameState(player, indices[0], indices[1]);

    if (returnedJsonObject["gameState"] == "tied") {
      print(returnedJsonObject);
      Future.delayed(Duration(milliseconds: 200) , (){
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => GameOver(
                  isMusic: widget.isMusic,
                  isTwoPlayer: true,
                  title: "Its A Tie",
                  image: SvgPicture.asset(
                    "images/twoPlayerTied.svg",
                  ),
                )),
                (route) => false);
      });
      return;
    } else if (returnedJsonObject["gameState"] == "playerWins") {

      print(returnedJsonObject);

      Future.delayed(Duration(milliseconds: 200) , (){
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => GameOver(
              isTwoPlayer: true,
              isMusic: widget.isMusic,
              title: "Player $player Wins !",
              image: SvgPicture.asset(
                "images/twoPlayerWin.svg",
              ),
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
                onTap: () async {
                  await tapped(index, currentPlayer);
                  if (currentPlayer == "X") {
                    setState(() {
                      currentPlayer = "O";
                    });
                  } else {
                    setState(() {
                      currentPlayer = "X";
                    });
                  }
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
