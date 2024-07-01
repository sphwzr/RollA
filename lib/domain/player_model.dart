import 'package:flutter/material.dart';
import 'package:kniffel/domain/dice_model.dart';
import 'package:kniffel/domain/dice_roll_model.dart';
import 'package:kniffel/domain/kniffel_sheet_model.dart';

class Player extends ChangeNotifier {
  String name;
  List<DiceRoll> diceRolls = List.empty(growable: true);
  List<int> selectedDiceValues = List.empty(growable: true);
  List<bool> isDiceIndexSelected = List.generate(5, (index) => false);
  KniffelSheet kniffelSheet = KniffelSheet();

  Player(this.name);

  int getNumberOfRolls() {
    return diceRolls.length;
  }

  void addDiceRoll(DiceRoll diceRoll) {
    diceRolls.add(diceRoll);
    notifyListeners();
  }

  void resetDiceRolls() {
    diceRolls.clear();
    notifyListeners();
  }

  void setSelectedDice(int value) {
    if (selectedDiceValues.length < 5) {
      selectedDiceValues.add(value);
    } else {
      throw Exception('Too many dice selected');
    }
    notifyListeners();
  }

  void removeSelectedDice(int value) {
    selectedDiceValues.remove(value);
    notifyListeners();
  }

  void resetSelectedDice() {
    selectedDiceValues.clear();
    notifyListeners();
  }

  void toggleSelectedDiceIndex(int index) {
    isDiceIndexSelected[index] = !isDiceIndexSelected[index];
    notifyListeners();
  }

  DiceRoll getSelectedDiceValuesAsDiceRoll() {
    DiceRoll diceRoll = DiceRoll();
    diceRoll.dices = selectedDiceValues
        .map((e) => Dice()..setDiceValue(e))
        .toList(growable: false);
    return diceRoll;
  }

  void resetRound() {
    resetDiceRolls();
    resetSelectedDice();
    notifyListeners();
  }
}
