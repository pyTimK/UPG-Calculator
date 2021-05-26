import 'package:flutter/cupertino.dart';

class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width, size.width / 3.4641);
    path.lineTo(size.width, size.width * 0.711324865);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(0, size.width * 0.711324865);
    path.lineTo(0, size.width / 3.4641);
    path.lineTo(size.width / 2, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
