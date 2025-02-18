import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:game_of_fortune/controllers/game/game_controller.dart';
import 'package:game_of_fortune/core/constants/app_images/assets.dart';
import 'package:game_of_fortune/core/constants/app_colors.dart';
import 'package:game_of_fortune/core/constants/app_fonts.dart';
import 'package:game_of_fortune/view/screens/play/home.dart';
import 'package:game_of_fortune/view/screens/players/players.dart';
import 'package:game_of_fortune/view/screens/profile/profile.dart';
import 'package:game_of_fortune/view/widgets/common_image_view_widget.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../core/constants/instances_constants.dart';

class BottomNavBar extends StatefulWidget {
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with WidgetsBindingObserver {
  final gameController = Get.find<GameController>();
  late List<Map<String, dynamic>> items;
  int currentIndex = 0;
  // PackageInfo? packageInfo;

  @override
  void initState() {
    super.initState();
    updateItems();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await notifications.initialize();
      await notifications.initLocalNotifications();
      await notifications.subscribeTopic();
      // packageInfo = await PackageInfo.fromPlatform();
    });
  }

  void updateItems() {
    items = [
      {
        'image': currentIndex == 0 ? Assets.imagesFillpaly : Assets.imagesPlay,
        'label': '',
      },
      {
        'image':
            currentIndex == 1 ? Assets.imagesFillpeople : Assets.imagesPeople,
        'label': '',
      },
      {
        'image':
            currentIndex == 2 ? Assets.imagesFilluser : Assets.imagesUserwhite,
        'label': '',
      },
    ];
  }

  final List<Widget> screens = [
    Home(),
    Players(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    // log("message ${packageInfo?.version}");
    return Scaffold(
      body: screens[currentIndex],
      floatingActionButton: Container(
        margin: EdgeInsets.all(30),
        height: 62,
        decoration: BoxDecoration(
          color: kSecondaryColor,
          border:
              Border.all(width: 2, color: Color.fromARGB(255, 172, 225, 255)),
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
          borderRadius: BorderRadius.circular(100),
        ),
        child: Column(
          children: [
            BottomNavigationBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                  log(currentIndex.toString());
                  updateItems(); // Update items when index changes
                });
              },
              type: BottomNavigationBarType.fixed,
              currentIndex: currentIndex,
              selectedFontSize: 10,
              unselectedFontSize: 10,
              selectedLabelStyle: TextStyle(
                fontFamily: AppFonts.OUTFIT,
                color: kSecondaryColor,
              ),
              unselectedLabelStyle: TextStyle(
                fontFamily: AppFonts.OUTFIT,
                color: kGrey8Color,
              ),
              selectedItemColor: kSecondaryColor,
              unselectedItemColor: kGrey8Color,
              items: List.generate(
                items.length,
                (index) {
                  return BottomNavigationBarItem(
                    icon: CommonImageView(
                      imagePath: items[index]['image'],
                      width: 27,
                    ),
                    label: items[index]['label'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
