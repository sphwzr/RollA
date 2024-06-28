import 'package:flutter/material.dart';
import 'package:kniffel/presentation/dice_rolls.dart';
import 'package:kniffel/presentation/kniffel_sheet_screen.dart';
import 'package:provider/provider.dart';

import '../domain/models.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
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
            const DiceRolls(),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        KniffelSheetScreen(currentPlayer: player),
                  ),
                );
              },
              child: const Text('Enter in Sheet'),
            ),
          ],
        ),
      ),
    );
  }
}
