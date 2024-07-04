import 'package:flutter/material.dart';
import 'package:kniffel/domain/game/game_model.dart';
import 'package:kniffel/presentation/dice/dice_rolls.dart';
import 'package:kniffel/presentation/game/kniffel_sheet_screen.dart';
import 'package:kniffel/presentation/game/win_screen.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  Consumer<GameModel> _buildSelectedDiceText() {
    return Consumer<GameModel>(
      builder: (context, model, child) {
        return model.getSelectedDiceText(clickable: false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var model = context.watch<GameModel>();
    var player = model.currentPlayer;
    var themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  player.name,
                  style: TextStyle(
                    color: themeData.colorScheme.onPrimary,
                  ),
                ),
                const SizedBox(width: 10),
                Align(
                  alignment: const Alignment(1, 1),
                  child: Text(
                      'Player: ${model.currentPlayerIndex + 1}/${model.players.length}',
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: themeData.textTheme.bodySmall?.fontSize,
                      )),
                ),
              ],
            ),
            Text('Round: ${model.currentRound + 1}/13'),
          ],
        ),
        leading: model.getCancelButton(context),
        backgroundColor: themeData.colorScheme.primary,
        foregroundColor: themeData.colorScheme.onPrimary,
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
                    if (model.isGameOver()) {
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
