import 'package:flutter/material.dart';
import 'package:kniffel/domain/dice_model.dart';
import 'package:kniffel/domain/player_model.dart';

class GameModel extends ChangeNotifier {
  List<Player> players = [];
  int currentPlayerIndex = 0;
  int currentRound = 0;
  int currentRoll = 0;

  Player get currentPlayer => players[currentPlayerIndex];

  void addCurrentPlayerDiceValue(int value) {
    currentPlayer.setSelectedDice(value);
    notifyListeners();
  }

  void removeCurrentPlayerDiceValue(int value) {
    currentPlayer.removeSelectedDice(value);
    notifyListeners();
  }

  void addPlayer(Player player) {
    players.add(player);
    notifyListeners();
  }

  void nextPlayer() {
    currentPlayerIndex = (currentPlayerIndex + 1) % players.length;
    notifyListeners();
  }

  void nextRound() {
    currentRound++;
    notifyListeners();
  }

  void nextRoll() {
    currentRoll++;
    notifyListeners();
  }

  void resetRoll() {
    currentRoll = 0;
    notifyListeners();
  }

  void resetGame() {
    currentPlayerIndex = 0;
    currentRound = 0;
    currentRoll = 0;
    players = [];
    notifyListeners();
  }

  Widget getSelectedDiceText({bool clickable = true}) {
    return RichText(
      text: TextSpan(children: [
        const TextSpan(
          text: "Selected Dices: ",
        ),
        ...currentPlayer.selectedDiceValues.map((value) {
          return WidgetSpan(
              child: InkWell(
                  onTap: () =>
                      clickable ? removeCurrentPlayerDiceValue(value) : null,
                  child: Icon(Dice().diceIcons[value])));
        })
      ]),
    );
  }
}
