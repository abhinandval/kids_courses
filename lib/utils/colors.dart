import 'package:flutter/material.dart' show Color;

class ColorUtils {
  static Color getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return Color(int.parse("0x$hexColor"));
  }
}
