import 'package:flutter/material.dart';
import 'package:game_of_fortune/view/constants/app_colors.dart';
import 'package:game_of_fortune/view/widgets/my_text_widget.dart';

// ignore: must_be_immutable
class MyButton extends StatelessWidget {
  MyButton({
    required this.onTap,
    required this.buttonText,
    this.height = 48,
    this.backgroundColor = kSecondaryColor,
    this.fontColor = kPrimaryColor,
    this.fontSize = 16,
    this.outlineColor,
    this.radius = 15,
    this.svgIcon,
    this.haveSvg = false,
    this.choiceIcon,
    this.isleft,
    this.hasicon,
    this.mBottom = 0,
    this.mTop = 0,
    this.hasshadow,
    this.fontWeight = FontWeight.w600,
  });

  final String buttonText;
  final VoidCallback onTap;
  final double? height;
  final double radius;
  final double fontSize;
  final Color? outlineColor;
  bool? hasicon, isleft;
  Widget? choiceIcon;
  final Color backgroundColor, fontColor;
  final String? svgIcon;
  final bool haveSvg;
  final double mTop, mBottom;
  final FontWeight fontWeight;
  bool? hasshadow;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: mTop, bottom: mBottom),
        height: height,
        decoration: hasshadow ?? false
            ? BoxDecoration(
                color: backgroundColor,
                border: Border.all(
                    width: 2,
                    color: outlineColor ?? Color.fromARGB(255, 172, 225, 255)),
                borderRadius: BorderRadius.circular(radius),
              )
            : BoxDecoration(
                color: backgroundColor,
                border: Border.all(
                    width: 2,
                    color: outlineColor ?? Color.fromARGB(255, 172, 225, 255)),
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
                borderRadius: BorderRadius.circular(radius),
              ),
        child: Material(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: isleft == true
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            children: [
              hasicon == true
                  ? Padding(
                      padding: isleft == true
                          ? const EdgeInsets.only(left: 20.0)
                          : const EdgeInsets.only(left: 0),
                      child: choiceIcon ?? const SizedBox.shrink(),
                    )
                  : const SizedBox.shrink(),
              MyText(
                paddingLeft: (hasicon == true) ? 10 : 0,
                text: buttonText,
                size: fontSize,
                color: fontColor,
                weight: fontWeight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({
    required this.buttonText,
    required this.onTap,
    this.height = 48,
    this.textSize,
    this.weight,
    this.radius,
    this.customChild,
    this.bgColor,
    this.textColor,
    this.mBottom,
    this.mTop,
  });

  final String buttonText;
  final VoidCallback onTap;
  double? height, textSize, radius;
  FontWeight? weight;
  Widget? customChild;
  Color? bgColor, textColor;
  double? mTop, mBottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: mTop ?? 0, bottom: mBottom ?? 0),
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 8),
        color: bgColor ?? kSecondaryColor,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          splashColor: kPrimaryColor.withOpacity(0.1),
          highlightColor: kPrimaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(radius ?? 8),
          child: customChild != null
              ? customChild
              : Center(
                  child: MyText(
                    text: buttonText,
                    size: textSize ?? 16,
                    weight: weight ?? FontWeight.w600,
                    color: textColor ?? kPrimaryColor,
                  ),
                ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class MyBorderButton extends StatelessWidget {
  MyBorderButton({
    required this.buttonText,
    required this.onTap,
    this.height = 48,
    this.textSize,
    this.weight,
    this.child,
    this.radius,
    this.borderColor,
    this.mBottom,
    this.mTop,
  });

  final String buttonText;
  final VoidCallback onTap;
  double? height, textSize;
  FontWeight? weight;
  Widget? child;
  double? radius;
  Color? borderColor;
  double? mTop, mBottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: mTop ?? 0, bottom: mBottom ?? 0),
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 15),
        color: Colors.transparent,
        border: Border.all(
          width: 1.5,
          color: borderColor ?? kSecondaryColor,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          splashColor: kPrimaryColor.withOpacity(0.1),
          highlightColor: kPrimaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(radius ?? 8),
          child: child != null
              ? child
              : Center(
                  child: MyText(
                    text: buttonText,
                    size: textSize ?? 16,
                    weight: weight ?? FontWeight.w600,
                    color: borderColor ?? kSecondaryColor,
                  ),
                ),
        ),
      ),
    );
  }
}
