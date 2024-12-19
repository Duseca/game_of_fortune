import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:game_of_fortune/controllers/game/game_controller.dart';
import 'package:game_of_fortune/services/local_storage/local_storage_service.dart';
import 'package:get/get.dart';

import 'my_button_widget.dart';

class Tips extends StatelessWidget {
  final gameController = Get.find<GameController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(
          top: 35,
          left: 20,
          right: 20,
          bottom: 15,
        ),
        shrinkWrap: true,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(onTap: () => Get.back(), child: Icon(Icons.arrow_back)),
            ],
          ),
          Html(
            data: """
              <h1>Game Instructions</h1>
              <div>
                <p><b>1. Introduction:</b></p>
                <p>Welcome to the game! Your goal is to make 30 correct moves in a row to win the prize.</p>
              </div>
              <div>
                <p><b>2. How to Play:</b></p>
                <ul>
                  <li>You’ll see two buttons, one on the left and one on the right.</li>
                  <li>Each time you press a button, the game will randomly decide if it’s the correct move.</li>
                  <li>A green color means you chose correctly, while a grey color means you missed it.</li>
                </ul>
              </div>
              <div>
                <p><b>3. Winning:</b></p>
                <ul>
                  <li>If you make 30 correct choices without a mistake, you win the prize!</li>
                  <li>But beware—one wrong choice will end the game!</li>
                </ul>
              </div>
              <div>
                <p><b>4. Tips:</b></p>
                <p>Keep going and pay attention to your choices. With each correct step, you’re closer to victory!</p>
              </div>
              <div>
                <p><b>5. Game end:</b></p>
                <p>When the prize is won by a player, the game will end, and the prizepool will restart when its decided when a new game will start!</p>
              </div>
            """,
          ),
          MyButton(
              mBottom: 20,
              onTap: () async {
                await LocalStorageService.instance
                    .write(key: 'showTips', value: true);
                Navigator.pop(context);
              },
              buttonText: 'Got it!'),
        ],
      ),
    );
  }
}
