import 'configs.dart';
import 'package:tictactoe/game/position.dart';
import 'package:tictactoe/game/board.dart';
import "dart:math";

class Bot {
  static Map<String, dynamic> bot_logic(Board board, String player){
    return new Map<String,dynamic>();
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

    if (board.isWinningBoard(HUMAN_PLAYER)) {
      board.is_finished = true;

      // Take action for human wins!
      return {
        "gameState": "humanWins"
      };
    }

    List<Position> free_positions = board.getFreePositions();

    if (free_positions.length == 0) {
      board.is_finished = true;

      // Take action for game tied!
      return {
        "gameState": "tied",
      };
    }

    Map <String, dynamic> bot_chance_result = bot_logic(board, AI_BOT);
    
    Position botChancePosition = bot_chance_result['position'];
    board.setPositionPlayer(botChancePosition.getRow(), botChancePosition.getCol(), AI_BOT);
    
    if (board.isWinningBoard(AI_BOT)) {
      board.is_finished = true;

      // Take action for marking bot_chance_position and bot wins!
      return {
        "gameState": "botWins",
        "botPositionX": botChancePosition.getRow(),
        "botPositionY": botChancePosition.getCol(),
      };
    }

    // Take action for marking bot_chance_position!
    return {
      "gameState": "continue",
      "botPositionX": botChancePosition.getRow(),
      "botPositionY": botChancePosition.getCol(),
    };
  }
}

class AI_Bot implements Bot {
  static Map<String, dynamic> bot_logic(Board board, String player) {
    var return_result = new Map<String,dynamic>();

    if (board.isWinningBoard(HUMAN_PLAYER)) {
      return {
        "score": -10,
      };
    }

    if (board.isWinningBoard(AI_BOT)) {
      return {
        "score": 10,
      };
    }

    if (board.isDraw()) {
      return {
        "score": 0,
      };
    }

    List<Position> free_positions = board.getFreePositions();
    Position finalPosition;
    int finalScore;
    int free_pos_len = free_positions.length;

    if (player == HUMAN_PLAYER) {
      int bestScore = 1000;
      return_result = {"score": 1000, "position": new Position(-1, -1)};

      Position bestPosition = new Position(-1, -1);

      for (int idx = 0; idx < free_pos_len; idx++) {
        board.setPositionPlayer(free_positions[idx].getRow(), free_positions[idx].getCol(), HUMAN_PLAYER);
        Map<String, dynamic> result = bot_logic(board, AI_BOT);
        int score = result['score'];

        if (score < bestScore) {
          return_result = {
            "score": score,
            "position":free_positions[idx],
          };
          bestScore = score;
        }

        board.setPositionPlayer(free_positions[idx].getRow(), free_positions[idx].getCol(), NO_PLAYER);
      }

      return return_result;
    }

    else {
      return_result = {"score": -1000, "position": new Position(-1, -1)};
      int bestScore = -1000;
      Position bestPosition = new Position(-1, -1);

      for (int idx = 0; idx < free_pos_len; idx++) {
        board.setPositionPlayer(free_positions[idx].getRow(), free_positions[idx].getCol(), AI_BOT);
        Map<String, dynamic> result =  bot_logic(board, HUMAN_PLAYER);
        int score = result['score'];

        if (score > bestScore) {
          return_result = {
            "score": score,
            "position":free_positions[idx],
          };
          bestScore = score;
        }

        board.setPositionPlayer(free_positions[idx].getRow(), free_positions[idx].getCol(), NO_PLAYER);
      }

      return return_result;
    }
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

    if (board.isWinningBoard(HUMAN_PLAYER)) {
      board.is_finished = true;

      // Take action for human wins!
      return {
        "gameState": "humanWins"
      };
    }

    List<Position> free_positions = board.getFreePositions();

    if (free_positions.length == 0) {
      board.is_finished = true;

      // Take action for game tied!
      return {
        "gameState": "tied",
      };
    }

    Map <String, dynamic> bot_chance_result = bot_logic(board, AI_BOT);
    
    Position botChancePosition = bot_chance_result['position'];
    board.setPositionPlayer(botChancePosition.getRow(), botChancePosition.getCol(), AI_BOT);
    
    if (board.isWinningBoard(AI_BOT)) {
      board.is_finished = true;

      // Take action for marking bot_chance_position and bot wins!
      return {
        "gameState": "botWins",
        "botPositionX": botChancePosition.getRow(),
        "botPositionY": botChancePosition.getCol(),
      };
    }

    // Take action for marking bot_chance_position!
    return {
      "gameState": "continue",
      "botPositionX": botChancePosition.getRow(),
      "botPositionY": botChancePosition.getCol(),
    };
  }
}


class Dumb_Bot implements Bot {
  static Map<String, dynamic> bot_logic(Board board, String player) {
    List<Position> free_positions = board.getFreePositions();
    final _random = new Random();
    Position position = free_positions[_random.nextInt(free_positions.length)];
    return {"position" : position};
  }
}