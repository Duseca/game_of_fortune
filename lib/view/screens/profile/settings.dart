import 'package:flutter/material.dart';
import 'package:game_of_fortune/view/constants/app_colors.dart';
import 'package:game_of_fortune/view/widgets/my_text_widget.dart';
import 'package:game_of_fortune/view/widgets/simple_app_bar_widget.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(title: 'Settings'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 15),
              physics: const BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 30,
                ),
                MyText(
                  text: 'Notifications',
                  size: 10,
                  paddingBottom: 10,
                  paddingLeft: 16,
                ),
                Container(
                  color: kGrey1Color,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            paddingLeft: 16,
                            text: 'Notifications',
                            size: 15,
                          ),
                          Switch(
                            value: false,
                            onChanged: (v) {},
                          )
                        ],
                      ),
                      Divider(
                        color: kBlueColor,
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            paddingLeft: 16,
                            text: 'Push Notifications',
                            size: 15,
                          ),
                          Switch(
                            value: false,
                            onChanged: (v) {},
                          )
                        ],
                      ),
                      Divider(
                        color: kBlueColor,
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            paddingLeft: 16,
                            text: 'Messages',
                            size: 15,
                          ),
                          Switch(
                            value: false,
                            onChanged: (v) {},
                          )
                        ],
                      ),
                      Divider(
                        color: kBlueColor,
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            paddingLeft: 16,
                            text: 'Email',
                            size: 15,
                          ),
                          Switch(
                            value: false,
                            onChanged: (v) {},
                          )
                        ],
                      ),
                      Divider(
                        color: kBlueColor,
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            paddingLeft: 16,
                            text: 'Requests',
                            size: 15,
                          ),
                          Switch(
                            value: false,
                            onChanged: (v) {},
                          )
                        ],
                      ),
                      Divider(
                        color: kBlueColor,
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            paddingLeft: 16,
                            text: 'Activities',
                            size: 15,
                          ),
                          Switch(
                            value: false,
                            onChanged: (v) {},
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: kBlueColor,
                        thickness: 1,
                        height: 0,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
