import 'dart:ui';

extension StringEx on String {
  Color? get color {
    var hexColor = replaceAll("#", "");

    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }

    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }

    return null;
  }
}
