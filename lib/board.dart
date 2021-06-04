import "configs.dart";
import "position.dart";

var winningCombinations = [
  [Position(0, 0), Position(0, 1), Position(0, 2)],
  [Position(1, 0), Position(1, 1), Position(1, 2)],
  [Position(2, 0), Position(2, 1), Position(2, 2)],
  [Position(0, 0), Position(1, 0), Position(2, 0)],
  [Position(0, 1), Position(1, 1), Position(2, 1)],
  [Position(0, 2), Position(1, 2), Position(2, 2)],
  [Position(0, 0), Position(1, 1), Position(2, 2)],
  [Position(0, 2), Position(1, 1), Position(2, 0)]
];


class Board {
  List<Position> _all_positions = [];
  bool is_finished = false;
  
  Board() {
    // Constructor for Board
    // Creating all board positions
    for (int idx = 0; idx < BOARD_ROWS; idx++) {
      for (int idy = 0; idy < BOARD_COLS; idy++) {
        Position pos = new Position(idx, idy);
        _all_positions.add(pos);
      }
    }
  }

  String getPositionPlayer(int row, int col) {
    // Return Board Position at (row, col)
    for (int idx = 0; idx < _all_positions.length; idx++)
    {
      if (_all_positions[idx].getRow() == row && _all_positions[idx].getCol() == col) {
        return _all_positions[idx].getCurrentPlayer();
      }
    }
  }

  void setPositionPlayer(int row, int col, String player) {
    // Set player for at (row, col)
    for (int idx = 0; idx < _all_positions.length; idx++)
    {
      if (_all_positions[idx].getRow() == row && _all_positions[idx].getCol() == col) {
        _all_positions[idx].setPlayer(player);
        return;
      }
    }
  }

  bool isPositionFree(int row, int col) {
    // check if position at (row, col) is free
    for (int idx = 0; idx < _all_positions.length; idx++) {
      if (_all_positions[idx].getRow() == row && _all_positions[idx].getCol() == col) {
        return _all_positions[idx].isFree();
      }
    }
    return false;
  }

  List<Position> getFreePositions() {
    List<Position> freePositions = [];
    for (int idx = 0; idx < _all_positions.length; idx++) {
      if (_all_positions[idx].isFree()) freePositions.add(_all_positions[idx]);
    }
    return freePositions;
  }

  bool isWinningCombination(String player, Position p1, Position p2, Position p3) {
    // check if player is in a winning condition
    bool isP1Free = getPositionPlayer(p1.getRow(), p1.getCol()) == player;
    bool isP2Free = getPositionPlayer(p2.getRow(), p2.getCol()) == player;
    bool isP3Free = getPositionPlayer(p3.getRow(), p3.getCol()) == player;
    return isP1Free && isP2Free && isP3Free;
  }

  bool isWinningBoard(String player) {
    for (int idx = 0; idx < 8; idx++) {
      if (isWinningCombination(player, winningCombinations[idx][0], winningCombinations[idx][1], winningCombinations[idx][2])) {
        return true;
      }
    }
    return false;
  }

  bool isDraw() {
    // check if game is tied
    List<Position> freePositions = getFreePositions();
    return freePositions.length == 0;
  }

  Map<String, dynamic> returnNewGameState(String player, int curr_row, int curr_col) {
    setPositionPlayer(curr_row, curr_col, player);

    if (isWinningBoard(player)) return {
      "gameState": "playerWins"
    };

    if (isDraw()) return {
      "gameState": "tied"
    };

    return {
      "gameState": "continue"
    };
  }
}
