import 'package:flutter/material.dart';
import 'package:game_of_fortune/view/constants/app_colors.dart';
import 'package:game_of_fortune/view/constants/app_fonts.dart';

// ignore: must_be_immutable
class MyText extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final String text;
  final String? fontFamily;
  final TextAlign? textAlign;
  final TextDecoration decoration;
  final FontWeight? weight;
  final TextOverflow? textOverflow;
  final Color? color;
  final FontStyle? fontStyle;
  final VoidCallback? onTap;
  List<Shadow>? textShadow;
  final int? maxLines;
  final Paint? foreground;
  final double? size;
  final double? lineHeight;
  final double? paddingTop;
  final double? paddingLeft;
  final double? paddingRight;
  final double? paddingBottom;
  final double? letterSpacing;

  MyText(
      {Key? key,
      required this.text,
      this.size,
      this.lineHeight,
      this.maxLines = 100,
      this.decoration = TextDecoration.none,
      this.color,
      this.letterSpacing,
      this.weight = FontWeight.w400,
      this.textAlign,
      this.textOverflow,
      this.fontFamily,
      this.paddingTop = 0,
      this.paddingRight = 0,
      this.paddingLeft = 0,
      this.paddingBottom = 0,
      this.onTap,
      this.textShadow,
      this.fontStyle,
      this.foreground})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: paddingTop!,
        left: paddingLeft!,
        right: paddingRight!,
        bottom: paddingBottom!,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          "$text",
          style: TextStyle(
            shadows: textShadow,
            fontSize: size ?? 14,
            color: color ?? kTertiaryColor,
            fontWeight: weight,
            decoration: decoration,
            foreground: foreground,
            decorationColor: kBlackColor,
            decorationThickness: 2,
            fontFamily: fontFamily ?? AppFonts.OUTFIT,
            height: lineHeight,
            fontStyle: fontStyle,
            letterSpacing: letterSpacing,
          ),
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: textOverflow,
        ),
      ),
    );
  }
}
