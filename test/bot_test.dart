import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/game/configs.dart';
import 'package:tictactoe/game/board.dart';
import 'package:tictactoe/game/bot.dart';


void main(){
  group("Bot" ,(){
    test("Game state tied test" , (){
      final board = Board();
      for(int i=0 ; i<3 ; i++){
        if(i==0 || i==2){
          board.setPositionPlayer(i, 0, HUMAN_PLAYER);
          board.setPositionPlayer(i, 1, HUMAN_PLAYER);
          board.setPositionPlayer(i, 2, AI_BOT);
        } else {
          board.setPositionPlayer(i , 0 , AI_BOT);
          board.setPositionPlayer(i , 1 , AI_BOT);
        }
      }

      Map<String,dynamic> returnedJsonObject = Bot.make_move(board, 1, 2);
      expect(returnedJsonObject["gameState"] , "tied");

    });

    test("Game state human wins test" , (){
      final board = Board();
      bool isHuman = true;
      for(int i=0 ; i<3 ; i++){
        for(int j=0 ; j<3 ; j++){
          if(i==2 && j==2){
            // so that last block is not filled
            break;
          }
          if(isHuman){
            board.setPositionPlayer(i, j, HUMAN_PLAYER);
            isHuman = false;
          }else{
            board.setPositionPlayer(i , j, AI_BOT);
            isHuman = true;
          }
        }
      }

      Map<String,dynamic> returnedJsonObject = Bot.make_move(board, 2, 2);
      expect(returnedJsonObject["gameState"] , "humanWins");

    });

  });
}
