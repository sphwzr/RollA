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

class DiceRoll {
  List<Dice> dices = [Dice(), Dice(), Dice(), Dice(), Dice()];

  int getRollSum() {
    return dices.fold(
        0, (previousValue, element) => previousValue + element.diceValue);
  }

  int getRollSumOf(int value) {
    return dices
        .where((element) => element.diceValue == value)
        .fold(0, (previousValue, element) => previousValue + element.diceValue);
  }

  bool isThreeOfAKind() {
    return dices.any((element) =>
        dices
            .where((element2) => element2.diceValue == element.diceValue)
            .length >=
        3);
  }

  bool isFourOfAKind() {
    return dices.any((element) =>
        dices
            .where((element2) => element2.diceValue == element.diceValue)
            .length >=
        4);
  }

  bool isFullHouse() {
    return dices.any((element) =>
            dices
                .where((element2) => element2.diceValue == element.diceValue)
                .length >=
            3) &&
        dices.any((element) =>
            dices
                .where((element2) => element2.diceValue == element.diceValue)
                .length >=
            2);
  }

  bool isStreet(int length) {
    int sequenceLength = 0;
    List<int> values = dices.map((e) => e.diceValue).toList();
    values.sort();

    values.reduce((previous, element) {
      if (previous + 1 == element) {
        sequenceLength++;
      } else {
        sequenceLength = 0;
      }
      return element;
    });

    return sequenceLength >= length;
  }

  bool isSmallStreet() {
    return isStreet(4);
  }

  bool isLargeStreet() {
    return isStreet(5);
  }

  bool isKniffel() {
    return dices.every((element) => element.diceValue == dices.first.diceValue);
  }
}

class Player {
  String name;
  List<DiceRoll> diceRolls = List.empty(growable: true);
  KniffelSheet kniffelSheet = KniffelSheet();

  Player(this.name);

  int getNumberOfRolls() {
    return diceRolls.length;
  }
}

class KniffelSheet {
  List<int> upperSection = List.generate(6, (index) => 0);
  List<int> lowerSection = List.generate(7, (index) => 0);

  void setUpperSection(int value, int amount) {
    upperSection[value - 1] = value * amount;
  }

  void setThreeOfAKind(DiceRoll diceRoll) {
    if (diceRoll.isThreeOfAKind()) lowerSection[0] = diceRoll.getRollSum();
  }

  void setFourOfAKind(DiceRoll diceRoll) {
    if (diceRoll.isFourOfAKind()) lowerSection[1] = diceRoll.getRollSum();
  }

  void setFullHouse(DiceRoll diceRoll) {
    if (diceRoll.isFullHouse()) lowerSection[2] = 25;
  }

  void setSmallStreet(DiceRoll diceRoll) {
    if (diceRoll.isSmallStreet()) lowerSection[3] = 30;
  }

  void setLargeStreet(DiceRoll diceRoll) {
    if (diceRoll.isLargeStreet()) lowerSection[4] = 40;
  }

  void setKniffel(DiceRoll diceRoll) {
    if (diceRoll.isKniffel()) lowerSection[5] = 50;
  }

  void setChance(DiceRoll diceRoll) {
    lowerSection[6] = diceRoll.getRollSum();
  }

  int getUpperSectionSum() {
    return upperSection.reduce((value, element) => value + element);
  }

  int getUpperSectionBonus() {
    return getUpperSectionSum() >= 63 ? 35 : 0;
  }

  int getUpperSectionTotal() {
    return getUpperSectionSum() + getUpperSectionBonus();
  }
}
