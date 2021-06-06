import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/game/position.dart';
import 'package:tictactoe/game/configs.dart';
import 'package:tictactoe/game/board.dart';

void main() {
  group("Board" , (){
    test("Initially entire board must be free" , (){
      final board = Board();
      for(int i=0 ; i<3 ; i++){
        for(int j=0 ; j<3 ; j++){
          expect(board.isPositionFree(i, j) , true);
        }
      }
    });

    test("Position should be marked as not free" , (){
      final board = Board();
      board.setPositionPlayer(0, 0, "X");
      expect(board.isPositionFree(0, 0) , false);
    });

    test("getPositionPlayer should return current player at that position" , (){
      final board = Board();
      board.setPositionPlayer(0, 0, "X");
      expect(board.getPositionPlayer(0, 0) , "X");
    });

    test("Winning combinations should be checked accurately" , (){
      final board = Board();
      // winning combinations are (0,0 | 0,1 | 0,2) , (1,0 | 1,1 | 1,2) , (2,0 | 2,1 | 2,2) , (0,0 | 1,0 | 2,0) , (0,1 | 1,1 | 2,1)
      //(0,2 | 1,2 | 2,2) , (0,0 | 1,1 | 2,2) , (0,2 | 1,1 | 2,2)
      for(int i=0 ; i<3 ; i++){

        // horizontal
        final positionOne = Position(i,0);
        final positionTwo = Position(i,1);
        final positionThree = Position(i,2);
        bool isWinning = board.isWinningCombination(NO_PLAYER, positionOne, positionTwo, positionThree);
        expect(isWinning, true);

        // vertical
        final positionFour = Position(0,i);
        final positionFive = Position(1,i);
        final positionSix = Position(2,i);
        isWinning = board.isWinningCombination(NO_PLAYER, positionFour, positionFive, positionSix);
        expect(isWinning, true);
      }

      //diagonal
      final positionOne = Position(0,0);
      final positionTwo = Position(1,1);
      final positionThree = Position(2,2);
      bool isWinning = board.isWinningCombination(NO_PLAYER, positionOne, positionTwo, positionThree);
      expect(isWinning, true);

      final positionFour = Position(0,2);
      final positionFive = Position(1,1);
      final positionSix = Position(2,0);
      isWinning = board.isWinningCombination(NO_PLAYER, positionFour, positionFive, positionSix);
      expect(isWinning, true);
    });
  });
}