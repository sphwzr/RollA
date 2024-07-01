import 'package:kniffel/domain/dice_model.dart';

class DiceRoll {
  List<Dice> dices = [Dice(), Dice(), Dice(), Dice(), Dice()];

  DiceRoll rollFromList(List<int> values) {
    for (int i = 0; i < dices.length; i++) {
      dices[i].setDiceValue(values[i]);
    }
    return this;
  }

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
