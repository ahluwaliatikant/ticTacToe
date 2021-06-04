
class ConvertIndexDimension{

  determineTwoDIndex(int x) {
    if (x == 0)
      return [0, 0];
    else if (x == 1)
      return [0, 1];
    else if (x == 2)
      return [0, 2];
    else if (x == 3)
      return [1, 0];
    else if (x == 4)
      return [1, 1];
    else if (x == 5)
      return [1, 2];
    else if (x == 6)
      return [2, 0];
    else if (x == 7)
      return [2, 1];
    else if (x == 8) return [2, 2];
  }

  determineOneDIndex(List<int> indices) {
    if (indices[0] == 0 && indices[1] == 0)
      return 0;
    else if (indices[0] == 0 && indices[1] == 1)
      return 1;
    else if (indices[0] == 0 && indices[1] == 2)
      return 2;
    else if (indices[0] == 1 && indices[1] == 0)
      return 3;
    else if (indices[0] == 1 && indices[1] == 1)
      return 4;
    else if (indices[0] == 1 && indices[1] == 2)
      return 5;
    else if (indices[0] == 2 && indices[1] == 0)
      return 6;
    else if (indices[0] == 2 && indices[1] == 1)
      return 7;
    else if (indices[0] == 2 && indices[1] == 2) return 8;
  }

}