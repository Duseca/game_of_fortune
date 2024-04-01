import 'package:flutter/material.dart';
import 'package:game_of_fortune/view/constants/app_colors.dart';

// ignore: must_be_immutable
class CustomCheckBox extends StatelessWidget {
  CustomCheckBox(
      {Key? key,
      required this.isActive,
      required this.onTap,
      this.unSelectedColor,
      this.selectedColor,
      this.iscircle})
      : super(key: key);

  final bool isActive;
  final VoidCallback onTap;
  Color? unSelectedColor, selectedColor;
  bool? iscircle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(
          milliseconds: 230,
        ),
        curve: Curves.easeInOut,
        height: 19,
        width: 19,
        decoration: BoxDecoration(
          color:
              isActive ? selectedColor ?? kTertiaryColor : Colors.transparent,
          border: Border.all(
            width: 1.5,
            color: unSelectedColor ?? kSecondaryColor,
          ),
          borderRadius: BorderRadius.circular(iscircle == true ? 50 : 5),
        ),
        child: !isActive
            ? SizedBox()
            : Icon(
                Icons.check,
                size: 11,
                color: isActive == true ? kSecondaryColor2 : kTertiaryColor,
              ),
      ),
    );
  }
}
