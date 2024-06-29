import 'dart:math';

import 'package:dice_icons/dice_icons.dart';
import 'package:flutter/material.dart';

class Dice {
  final List<IconData> _diceIcons = [
    DiceIcons.dice0,
    DiceIcons.dice1,
    DiceIcons.dice2,
    DiceIcons.dice3,
    DiceIcons.dice4,
    DiceIcons.dice5,
    DiceIcons.dice6,
  ];

  int diceValue = 0;
  IconData diceIcon = DiceIcons.dice0;
  late AnimationController controller;
  late Animation<IconData> animation;

  List<IconData> get diceIcons => _diceIcons;

  void setDiceValue(int value) {
    diceValue = value;
    diceIcon = _diceIcons[value];
  }

  void rollDice() async {
    int value = Random().nextInt(6) + 1;
    setDiceValue(value);
    await controller.forward(from: 0.0);
    controller.value = value / 7.0;
  }
}
