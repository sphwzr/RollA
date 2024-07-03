import 'package:flutter/material.dart';
import 'package:kniffel/domain/dice/dice_roll_model.dart';

class KniffelSheet extends ChangeNotifier {
  List<int> upperSection = List.generate(9, (index) => -1);
  final List<String> _upperSectionTitles = [
    '1s',
    '2s',
    '3s',
    '4s',
    '5s',
    '6s',
    'Sum',
    'Bonus',
    'Total',
  ];
  List<int> lowerSection = List.generate(8, (index) => -1);
  final List<String> _lowerSectionTitles = [
    '3 of A Kind',
    '4 of A Kind',
    'Full House',
    'Small Street',
    'Big Street',
    'Kniffel',
    'Chance',
    'Total',
  ];

  List<int> scores = List.generate(3, (index) => 0);
  final List<String> _scoreTitles = [
    'Upper Section Total',
    'Lower Section Total',
    'Final Score'
  ];

  String getSectionElementTitle(int section, int index) {
    return section == 0
        ? getUpperSectionTitle(index)
        : getLowerSectionTitle(index);
  }

  String getUpperSectionTitle(int index) {
    return _upperSectionTitles[index];
  }

  String getLowerSectionTitle(int index) {
    return _lowerSectionTitles[index];
  }

  String getScoreTitle(int index) {
    return _scoreTitles[index];
  }

  int getSectionElementValue(int section, int index) {
    return section == 0
        ? getUpperSectionElementValue(index)
        : getLowerSectionElementValue(index);
  }

  int getUpperSectionElementValue(int index) {
    return upperSection[index];
  }

  int getLowerSectionElementValue(int index) {
    return lowerSection[index];
  }

  bool crossElementOut(int sectionIndex, int rowIndex) {
    if (sectionIndex == 0) {
      upperSection[rowIndex] = 0;
    } else {
      lowerSection[rowIndex] = 0;
    }
    notifyListeners();
    return true;
  }

  bool setSheetValues(int sectionIndex, int rowIndex, DiceRoll diceRoll) {
    bool success = false;
    if (sectionIndex == 0) {
      if (upperSection[rowIndex] == -1) {
        _setUpperSection(rowIndex, diceRoll);
        success = true;
      }
    } else {
      if (lowerSection[rowIndex] == -1) {
        switch (rowIndex) {
          case 0:
            success = _setThreeOfAKind(diceRoll);
            break;
          case 1:
            success = _setFourOfAKind(diceRoll);
            break;
          case 2:
            success = _setFullHouse(diceRoll);
            break;
          case 3:
            success = _setSmallStreet(diceRoll);
            break;
          case 4:
            success = _setLargeStreet(diceRoll);
            break;
          case 5:
            success = _setKniffel(diceRoll);
            break;
          case 6:
            success = _setChance(diceRoll);
            break;
        }
      }
    }
    updateScores();
    notifyListeners();
    return success;
  }

  void _setUpperSection(int rowIndex, DiceRoll diceRoll) {
    upperSection[rowIndex] = diceRoll.getRollSumOf(rowIndex + 1);
  }

  bool _setThreeOfAKind(DiceRoll diceRoll) {
    if (diceRoll.isThreeOfAKind()) lowerSection[0] = diceRoll.getRollSum();
    return diceRoll.isThreeOfAKind();
  }

  bool _setFourOfAKind(DiceRoll diceRoll) {
    if (diceRoll.isFourOfAKind()) lowerSection[1] = diceRoll.getRollSum();
    return diceRoll.isFourOfAKind();
  }

  bool _setFullHouse(DiceRoll diceRoll) {
    if (diceRoll.isFullHouse()) lowerSection[2] = 25;
    return diceRoll.isFullHouse();
  }

  bool _setSmallStreet(DiceRoll diceRoll) {
    if (diceRoll.isSmallStreet()) lowerSection[3] = 30;
    return diceRoll.isSmallStreet();
  }

  bool _setLargeStreet(DiceRoll diceRoll) {
    if (diceRoll.isLargeStreet()) lowerSection[4] = 40;
    return diceRoll.isLargeStreet();
  }

  bool _setKniffel(DiceRoll diceRoll) {
    if (diceRoll.isKniffel()) lowerSection[5] = 50;
    return diceRoll.isKniffel();
  }

  bool _setChance(DiceRoll diceRoll) {
    lowerSection[6] = diceRoll.getRollSum();
    return true;
  }

  int getUpperSectionSum() {
    return upperSection.reduce((value, element) => element > 0
        ? value + element
        : value > 0
            ? value
            : 0);
  }

  int getUpperSectionBonus() {
    return getUpperSectionSum() >= 63 ? 35 : 0;
  }

  int getUpperSectionTotal() {
    return getUpperSectionSum() + getUpperSectionBonus();
  }

  int getLowerSectionTotal() {
    return lowerSection.reduce((value, element) => element > 0
        ? value + element
        : value > 0
            ? value
            : 0);
  }

  int getFinalScore() {
    return getUpperSectionTotal() + getLowerSectionTotal();
  }

  void updateScores() {
    scores[0] = getUpperSectionTotal();
    scores[1] = getLowerSectionTotal();
    scores[2] = getFinalScore();
    notifyListeners();
  }
}
