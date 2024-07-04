import 'package:flutter/material.dart';
import 'package:kniffel/domain/dice/dice_model.dart';
import 'package:kniffel/domain/player/player_model.dart';

class GameModel extends ChangeNotifier {
  List<Player> players = [];
  int currentPlayerIndex = 0;
  int currentRound = 0;
  int currentRoll = 0;

  Player get currentPlayer =>
      players.isNotEmpty ? players[currentPlayerIndex] : Player('default');

  void addCurrentPlayerDiceValue(int value) {
    if (currentPlayer.selectedDiceValues.length < 5) {
      currentPlayer.setSelectedDice(value);
    }
    notifyListeners();
  }

  void removeCurrentPlayerDiceValue(int value) {
    currentPlayer.removeSelectedDice(value);
    notifyListeners();
  }

  void addPlayers(List<Player> players) {
    for (var player in players) {
      addPlayer(player);
    }
  }

  void addPlayer(Player player) {
    players.add(player);
    notifyListeners();
  }

  void nextPlayer() {
    if (currentPlayerIndex == players.length - 1) {
      nextRound();
    }
    currentPlayer.resetRound();
    currentPlayerIndex = (currentPlayerIndex + 1) % players.length;
    resetRoll();
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
    players.clear();
    notifyListeners();
  }

  Player getWinner() {
    return sortPlayersByScore().first;
  }

  List<Player> sortPlayersByScore() {
    var sortedPlayers = players;
    sortedPlayers.sort((a, b) => b.kniffelSheet
        .getFinalScore()
        .compareTo(a.kniffelSheet.getFinalScore()));
    return sortedPlayers;
  }

  bool isGameOver() {
    return currentRound == 12 && currentPlayerIndex == players.length - 1;
  }

  Widget getWinText() {
    Player firstPlayer = sortPlayersByScore().first;
    Player secondPlayer = sortPlayersByScore()[1];

    bool isTie = firstPlayer.kniffelSheet.getFinalScore() ==
        secondPlayer.kniffelSheet.getFinalScore();
    var text = isTie
        ? 'It\'s a tie! \n ${firstPlayer.name} and ${secondPlayer.name} won the game with ${firstPlayer.kniffelSheet.getFinalScore()}!'
        : 'Congratulations ${getWinner().name}!\n You won the game with ${getWinner().kniffelSheet.getFinalScore()} points!';
    return Column(
      children: [
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget getSelectedDiceText({bool clickable = true}) {
    return Column(
      children: [
        const Text(
          "Selected Dices:",
        ),
        const SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ...currentPlayer.selectedDiceValues.map(
            (value) {
              return InkWell(
                  onTap: () =>
                      clickable ? removeCurrentPlayerDiceValue(value) : null,
                  child: Icon(Dice().diceIcons[value], size: 40));
            },
          ),
        ]),
        const SizedBox(height: 20)
      ],
    );
  }

  Widget getCancelButton(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.cancel,
        size: 30,
      ),
      onPressed: () => endGame(context),
    );
  }

  void endGame(BuildContext context) {
    resetGame();
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }
}
