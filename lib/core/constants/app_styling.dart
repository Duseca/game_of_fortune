import 'package:flutter/material.dart';
import 'package:game_of_fortune/core/constants/app_colors.dart';

BoxDecoration circle(Color color, Color? borderColor) {
  return BoxDecoration(
      shape: BoxShape.circle,
      color: color,
      border: Border.all(color: borderColor ?? Colors.transparent));
}

BoxDecoration rounded(Color color) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    color: color,
    boxShadow: [
      BoxShadow(
        color: kBlack2Color.withOpacity(0.2),
        blurRadius: 5,
        offset: Offset(2, 2), // Shadow position
      ),
    ],
  );
}

BoxDecoration roundedsr(Color color, double radius) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: color,
    boxShadow: [
      BoxShadow(
        color: kBlack2Color.withOpacity(0.2),
        blurRadius: 5,
        offset: Offset(2, 2), // Shadow position
      ),
    ],
  );
}

class KTertiaryColor {}

BoxDecoration rounded2(Color color, Color? borderColor) {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: color,
      border: Border.all(color: borderColor ?? Colors.transparent));
}

BoxDecoration rounded2r(Color color, Color? borderColor, double radius) {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      color: color,
      border: Border.all(color: borderColor ?? Colors.transparent));
}

BoxDecoration roundedr(Color color, double radius) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: color,
  );
}

BoxDecoration btndeco() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    color: kPrimaryColor,
    border: Border.all(color: Color.fromARGB(255, 172, 225, 255), width: 2),
    boxShadow: [
      BoxShadow(
        offset: Offset(0, 8),
        color: kTertiaryColor,
        blurRadius: 0,
        spreadRadius: 0,
      ),
      BoxShadow(
        offset: Offset(0, 3),
        color: kSecondaryColor2,
        blurRadius: 0,
        spreadRadius: 0,
      ),
    ],
  );
}
