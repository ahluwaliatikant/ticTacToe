import "configs.dart";

class Position {
  int _row, _col;
  String _current_player;

  Position(int row, int col) {
    _row = row;
    _col = col;
    _current_player = NO_PLAYER;
  }

  int getRow() { return _row; }

  int getCol() { return _col; }

  bool isFree() {
    return _current_player == NO_PLAYER;
  }

  String getCurrentPlayer(){
    return _current_player;
  }

  void setPlayer(String player) {
    _current_player = player;
  }

  bool isCurrPlayer(String player) {
    return _current_player == player;
  }
}