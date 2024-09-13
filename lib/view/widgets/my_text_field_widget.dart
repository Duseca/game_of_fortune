import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_of_fortune/core/constants/app_colors.dart';
import 'package:game_of_fortune/core/constants/app_fonts.dart';
import 'package:game_of_fortune/view/widgets/my_text_widget.dart';

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  MyTextField({
    Key? key,
    this.controller,
    this.hint,
    this.label,
    this.keyBoardType,
    this.onChanged,
    this.isObSecure = false,
    this.marginBottom = 16.0,
    this.maxLines = 1,
    this.filledColor,
    this.hintColor,
    this.haveLabel = true,
    this.labelSize,
    this.prefix,
    this.suffix,
    this.labelWeight,
    this.kBorderColor,
    this.validator,
    this.kFocusBorderColor,
    this.isReadOnly,
  }) : super(key: key);
  String? label, hint;

  TextEditingController? controller;
  ValueChanged<String>? onChanged;
  bool? isObSecure, haveLabel, isReadOnly;
  TextInputType? keyBoardType;
  double? marginBottom;
  int? maxLines;
  double? labelSize;
  String? Function(String?)? validator;
  Color? filledColor, hintColor, kBorderColor, kFocusBorderColor;
  Widget? prefix, suffix;
  FontWeight? labelWeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: marginBottom!),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (label != null)
            MyText(
              text: label ?? '',
              size: labelSize ?? 14,
              color: kBlackColor,
              paddingBottom: 6,
              weight: labelWeight ?? FontWeight.w600,
            ),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: TextFormField(
              textAlignVertical: prefix != null || suffix != null
                  ? TextAlignVertical.center
                  : null,
              cursorColor: kBlackColor,
              maxLines: maxLines,
              readOnly: isReadOnly ?? false,
              controller: controller,
              onChanged: onChanged,
              validator: validator ?? null,
              keyboardType: keyBoardType??TextInputType.text,
              textInputAction: TextInputAction.next,
              obscureText: isObSecure!,
              obscuringCharacter: '*',
              style: TextStyle(
                fontSize: 12,
                color: kBlackColor,
                fontFamily: AppFonts.OUTFIT,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: filledColor ?? kSecondaryColor2,
                prefixIcon: prefix,
                suffixIcon: suffix,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: maxLines! > 1 ? 15 : 0,
                ),
                hintText: hint,
                hintStyle: TextStyle(
                  fontSize: 12,
                  fontFamily: AppFonts.OUTFIT,
                  color: kGreyColor,
                ),
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: kBorderColor ?? kGrey2Color,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: kFocusBorderColor ?? kSecondaryColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                errorBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
