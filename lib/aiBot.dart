
const String HUMAN_PLAYER = 'Human';
const String AI_BOT = 'AI_Bot';
const String NO_PLAYER = 'No_Player';

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


class Position {
  int _row, _col;
  String _current_player;

  Position(int row, int col) {
    _row = row;
    _col = col;
    _current_player = NO_PLAYER;
  }

  void setPlayer(String player) {
    _current_player = player;
  }

  int getRow() { return _row; }

  int getCol() { return _col; }

  bool isFree() {
    return _current_player == NO_PLAYER;
  }

  bool isCurrPlayer(String player) {
    return _current_player == player;
  }

  String getCurrentPlayer(){
    return _current_player;
  }
}


class Board {
  int BOARD_ROWS = 3;
  int BOARD_COLS = 3;
  bool is_finished = false;

  List<Position> all_positions = [];

  Board() {
    // adding all available positions
    for (int idx = 0; idx < BOARD_ROWS; idx++) {
      for (int idy = 0; idy < BOARD_COLS; idy++) {
        Position pos = new Position(idx, idy);
        all_positions.add(pos);
      }
    }
  }

  String getPositionPlayer(int row, int col) {
    for (int idx = 0; idx < all_positions.length; idx++)
    {
      if (all_positions[idx].getRow() == row && all_positions[idx].getCol() == col) {
        return all_positions[idx].getCurrentPlayer();
      }
    }
  }
  void setPositionPlayer(int row, int col, String player) {
    for (int idx = 0; idx < all_positions.length; idx++)
    {
      if (all_positions[idx].getRow() == row && all_positions[idx].getCol() == col) {
        all_positions[idx].setPlayer(player);
        return;
      }
    }
  }

  bool isPositionFree(int row, int col) {
    for (int idx = 0; idx < all_positions.length; idx++) {
      if (all_positions[idx].getRow() == row && all_positions[idx].getCol() == col) {
        return all_positions[idx].isFree();
      }
    }
    return false;
  }

  List<Position> getFreePositions() {
    List<Position> freePositions = [];
    for (int idx = 0; idx < all_positions.length; idx++) {
      if (all_positions[idx].isFree()) freePositions.add(all_positions[idx]);
    }
    return freePositions;
  }

  bool isWinningCombination(String player, Position p1, Position p2, Position p3) {
    bool isP1Free = getPositionPlayer(p1.getRow(), p1.getCol()) == player;
    bool isP2Free = getPositionPlayer(p2.getRow(), p2.getCol()) == player;
    bool isP3Free = getPositionPlayer(p3.getRow(), p3.getCol()) == player;
    return isP1Free && isP2Free && isP3Free;
//    return p1.isCurrPlayer(player) && p2.isCurrPlayer(player) && p3.isCurrPlayer(player);
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
    List<Position> freePositions = getFreePositions();
    return freePositions.length == 0;
  }
}


class Bot {
  static Map<String, dynamic> bot_logic(Board board, String player) {
    // print('playing $player');
    var return_result = new Map<String,dynamic>();

    if (board.isWinningBoard(HUMAN_PLAYER)) {
      return_result = {
        "score": -10,
      };
      // print('returning $player return result: $return_result');
      //return_result['score'] = -10;
      return return_result;
    }

    if (board.isWinningBoard(AI_BOT)) {
      return_result = {
        "score": 10,
      };
      //return_result['score'] = 10;
      // print('returning $player return result: $return_result');
      return return_result;
    }
//    int l = board.getFreePositions().length;

    if (board.isDraw()) {
      return_result = {
        "score": 0,
      };
      // print('returning $player return result: $return_result');
      //return_result['score'] = 0;
      return return_result;
    }

    List<Position> free_positions = board.getFreePositions();
    Position finalPosition;
    int finalScore;
    int free_pos_len = free_positions.length;
    //print("free pos len: $free_pos_len");

    String free_pos_list = "";
    for (int idx = 0; idx < free_pos_len; idx++)
    {
      int tr = free_positions[idx].getRow();
      int tc = free_positions[idx].getCol();
      free_pos_list = free_pos_list + "$tr, $tc";
    }
    // print(free_pos_list);
    if (player == HUMAN_PLAYER) {

      int bestScore = 1000;
      return_result = {"score": 1000, "position": new Position(-1, -1)};

      Position bestPosition = new Position(-1, -1);

      for (int idx = 0; idx < free_pos_len; idx++) {
        board.setPositionPlayer(free_positions[idx].getRow(), free_positions[idx].getCol(), HUMAN_PLAYER);
        int dr = free_positions[idx].getRow();
        int dc = free_positions[idx].getCol();

        // print("$player using $dr , $dc");
        Map<String, dynamic> result = bot_logic(board, AI_BOT);
        // // print(result);
        int score = result['score'];
        if (score < bestScore) {
          return_result = {
            "score": score,
            "position":free_positions[idx],
          };
          bestScore = score;
          //return_result['score'] = score;
          //return_result['position'] = free_positions[idx];
        }
        board.setPositionPlayer(free_positions[idx].getRow(), free_positions[idx].getCol(), NO_PLAYER);
      }
      // print('returning human return result: $return_result');
      //print('returning for $free_pos_len');
      return return_result;
      finalPosition = new Position(bestPosition.getRow(), bestPosition.getCol());
      finalScore = bestScore;
    }
    else {
      return_result = {"score": -1000, "position": new Position(-1, -1)};
      int bestScore = -1000;
      Position bestPosition = new Position(-1, -1);

      for (int idx = 0; idx < free_pos_len; idx++) {
        board.setPositionPlayer(free_positions[idx].getRow(), free_positions[idx].getCol(), AI_BOT);
        int dr = free_positions[idx].getRow();
        int dc = free_positions[idx].getCol();
        // print("$player using $dr , $dc");

        Map<String, dynamic> result =  bot_logic(board, HUMAN_PLAYER);
        int score = result['score'];
        if (score > bestScore) {
          return_result = {
            "score": score,
            "position":free_positions[idx],
          };
          bestScore = score;
          //return_result['score'] = score;
          //return_result['position'] = free_positions[idx];
        }
        board.setPositionPlayer(free_positions[idx].getRow(), free_positions[idx].getCol(), NO_PLAYER);
      }
      // print('returning bot return result: $return_result');
      //print('returning for $free_pos_len');
      return return_result;
    }
    print('returning outside for $free_pos_len');
  }

  static Map<String, dynamic> make_move(Board board, int chanceRow, int chanceCol) {
    if (board.is_finished) {
      return {
        "gameState": "finished",
      };
    }

    if (!(board.isPositionFree(chanceRow, chanceCol))) return {
      "gameState": "invalid",
    };

    board.setPositionPlayer(chanceRow, chanceCol, HUMAN_PLAYER);
    // print("setting player position: $chanceRow , $chanceCol");
    if (board.isWinningBoard(HUMAN_PLAYER)) {
      board.is_finished = true;
      // TODO: Take action for human wins!
      // print("returning gamestate humanWins");
      return {
        "gameState": "humanWins"
      };
    }

    List<Position> free_positions = board.getFreePositions();

    if (free_positions.length == 0) {
      board.is_finished = false;
      // TODO: Take action for game tied!
      // print("returning gamestate tied");
      return {
        "gameState": "tied",
      };
    }

    Map <String, dynamic> bot_chance_result = bot_logic(board, AI_BOT);
    Position botChancePosition = bot_chance_result['position'];
    board.setPositionPlayer(botChancePosition.getRow(), botChancePosition.getCol(), AI_BOT);
    if (board.isWinningBoard(AI_BOT)) {
      // TODO: Take action for marking bot_chance_position and bot wins!
      int x = botChancePosition.getRow();
      int y = botChancePosition.getCol();
      // print("returning gamestate botWins $x $y ");

      return {
        "gameState": "botWins",
        "botPositionX": botChancePosition.getRow(),
        "botPositionY": botChancePosition.getCol(),
      };
    }

    // TODO: Take action for marking bot_chance_position!
    int x = botChancePosition.getRow();
    int y = botChancePosition.getCol();
    // print("returning gamestate continue $x $y ");
//    board.setPositionPlayer(botChancePosition.getRow(), botChancePosition.getCol(), AI_BOT);
    return {
      "gameState": "continue",
      "botPositionX": botChancePosition.getRow(),
      "botPositionY": botChancePosition.getCol(),
    };
  }
}


/*
response structure:
{
  "result": "tied"/"humanWins"/"botWins"/"continue"/"finished",
  "botPosX": "_", (present only if result is "botWins" or "continue")
  "botPosY": "_"  (present only if result is "botWins" or "continue")
}
*/