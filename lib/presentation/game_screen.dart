import 'package:flutter/material.dart';
import 'package:kniffel/presentation/dice_rolls.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(context.watch<GameModel>().currentPlayer.name),
      ),
      // appBar: AppBar(
      //   title: Consumer<Game>(
      //     builder: (context, game, child) {
      //       return Text(game.players[game.currentPlayerIndex].name);
      //     },
      //   ),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DiceRolls(),
          ],
        ),
      ),
    );
  }
}
