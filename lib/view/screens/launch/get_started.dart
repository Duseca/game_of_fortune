import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:game_of_fortune/constants/app_images/assets.dart';
import 'package:game_of_fortune/core/constants/app_colors.dart';
import 'package:game_of_fortune/core/constants/app_sizes.dart';
import 'package:game_of_fortune/view/screens/auth/login.dart';
import 'package:game_of_fortune/view/screens/auth/register.dart';
import 'package:game_of_fortune/view/widgets/common_image_view_widget.dart';
import 'package:game_of_fortune/view/widgets/my_button_widget.dart';
import 'package:game_of_fortune/view/widgets/my_text_widget.dart';
import 'package:get/get.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: CustomPaint(
              painter: _CurvesBluePainter(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CommonImageView(
                      imagePath: 'assets/images/GOF_Logo_Black.png',
                      height: 235,
                      width: 233,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: Container(
            child: Padding(
              padding: AppSizes.DEFAULT,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyText(
                    text: 'Welcome to Game of Fortune',
                    size: 16,
                    weight: FontWeight.bold,
                  ),
                  Column(
                    children: [
                      MyButton(
                        onTap: () {
                          Get.to(() => Login());
                        },
                        buttonText: 'Login',
                        mBottom: 20,
                      ),
                      MyBorderButton(
                        buttonText: 'Create Account',
                        onTap: () {
                          Get.to(() => Register());
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}

class _CurvesBluePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = kSecondaryColor
      ..style = PaintingStyle.fill;

    Path path = Path()
      ..moveTo(0, size.height * 0.8)
      ..quadraticBezierTo(
          size.width / 2, size.height / 0.8, size.width, size.height * 0.8)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
