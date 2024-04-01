import 'package:flutter/material.dart';

class GameWinner extends StatelessWidget {
  const GameWinner({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 15),
              physics: const BouncingScrollPhysics(),
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
