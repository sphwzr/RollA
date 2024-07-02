import 'package:flutter/material.dart';
import 'package:kniffel/domain/game_model.dart';
import 'package:kniffel/presentation/dice_rolls.dart';
import 'package:kniffel/presentation/kniffel_sheet_screen.dart';
import 'package:kniffel/presentation/win_screen.dart';
import 'package:provider/provider.dart';

import '../domain/dice_model.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  Consumer<GameModel> _buildSelectedDiceText() {
    return Consumer<GameModel>(
      builder: (context, model, child) {
        return RichText(
          text: TextSpan(children: [
            const TextSpan(
              text: "Selected Dices: ",
            ),
            ...model.currentPlayer.selectedDiceValues.map((value) {
              return WidgetSpan(
                  child: InkWell(
                      onTap: () => model.removeCurrentPlayerDiceValue(value),
                      child: Icon(Dice().diceIcons[value])));
            })
          ]),
        );
      },
    );
  }

  // void addLastDiceRoll() {
  //   var model = context.read<GameModel>();
  //   var player = model.currentPlayer;
  //   DiceRoll rolled = DiceRoll();

  //   for (var dice in player.diceRolls.last.dices) {
  //     if (dice.isSelected) {
  //       dice.setVisibility(false);
  //     }
  //     rolled.dices
  //         .where((element) => element.diceValue == 0)
  //         .first
  //         .setDice(dice);
  //   }

  //   model.currentPlayer.addDiceRoll(rolled);
  // }

  @override
  Widget build(BuildContext context) {
    var model = context.watch<GameModel>();
    var player = model.currentPlayer;

    return Scaffold(
      appBar: AppBar(
        title: Text(player.name,
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildSelectedDiceText(),
            DiceRolls(currentPlayer: player),
            const SizedBox(height: 20),
            if (model.currentRoll == 3 || player.selectedDiceValues.length == 5)
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(
                    MaterialPageRoute(
                      builder: (context) =>
                          KniffelSheetScreen(currentPlayer: player),
                    ),
                  )
                      .then((value) {
                    // TODO: replace with 12 rounds
                    // if (model.isGameOver())
                    if (model.currentRound == 0 &&
                        model.currentPlayerIndex == model.players.length - 1) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const WinScreen(),
                        ),
                      );
                    } else {
                      model.nextPlayer();
                    }
                  });
                },
                child: const Text('Enter in Sheet'),
              ),
          ],
        ),
      ),
    );
  }
}
