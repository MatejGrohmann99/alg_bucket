import 'dart:ui';

abstract class CubeColor {
  static const red = Color.fromRGBO(255, 0, 0, 1.0);
  static const orange = Color.fromRGBO(255, 165, 0, 1.0);
  static const yellow = Color.fromRGBO(255, 255, 0, 1.0);
  static const white = Color.fromRGBO(255, 255, 255, 1.0);
  static const blue = Color.fromRGBO(0, 0, 255, 1.0);
  static const green = Color.fromRGBO(0, 255, 0, 1.0);
  static const black = Color.fromRGBO(0, 0, 0, 1.0);
  static const grey = Color.fromRGBO(128, 128, 128, 1.0);

  static Color fromIndex (int? index) {
    switch (index) {
      case -1:
        return grey;
      case 0:
        return white;
      case 1:
        return green;
      case 2:
        return red;
      case 3:
        return blue;
      case 4:
        return orange;
      case 5:
        return yellow;
      default:
        return black;
    }
  }
}