import 'package:flutter/material.dart';
import 'package:kniffel/domain/dice_roll_model.dart';

class KniffelSheet extends ChangeNotifier {
  List<int> upperSection = List.generate(9, (index) => 0);
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
  List<int> lowerSection = List.generate(8, (index) => 0);
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

  void setSheetValues(int sectionIndex, int rowIndex, DiceRoll diceRoll) {
    if (sectionIndex == 0) {
      _setUpperSection(rowIndex, diceRoll);
    } else {
      switch (rowIndex) {
        case 0:
          _setThreeOfAKind(diceRoll);
          break;
        case 1:
          _setFourOfAKind(diceRoll);
          break;
        case 2:
          _setFullHouse(diceRoll);
          break;
        case 3:
          _setSmallStreet(diceRoll);
          break;
        case 4:
          _setLargeStreet(diceRoll);
          break;
        case 5:
          _setKniffel(diceRoll);
          break;
        case 6:
          _setChance(diceRoll);
          break;
      }
    }
    updateScores();
    notifyListeners();
  }

  void _setUpperSection(int rowIndex, DiceRoll diceRoll) {
    upperSection[rowIndex] = diceRoll.getRollSumOf(rowIndex + 1);
  }

  void _setThreeOfAKind(DiceRoll diceRoll) {
    if (diceRoll.isThreeOfAKind()) lowerSection[0] = diceRoll.getRollSum();
  }

  void _setFourOfAKind(DiceRoll diceRoll) {
    if (diceRoll.isFourOfAKind()) lowerSection[1] = diceRoll.getRollSum();
  }

  void _setFullHouse(DiceRoll diceRoll) {
    if (diceRoll.isFullHouse()) lowerSection[2] = 25;
  }

  void _setSmallStreet(DiceRoll diceRoll) {
    if (diceRoll.isSmallStreet()) lowerSection[3] = 30;
  }

  void _setLargeStreet(DiceRoll diceRoll) {
    if (diceRoll.isLargeStreet()) lowerSection[4] = 40;
  }

  void _setKniffel(DiceRoll diceRoll) {
    if (diceRoll.isKniffel()) lowerSection[5] = 50;
  }

  void _setChance(DiceRoll diceRoll) {
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

  int getLowerSectionTotal() {
    return lowerSection.reduce((value, element) => value + element);
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
