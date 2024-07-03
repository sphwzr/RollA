import 'package:flutter/material.dart';
import 'package:kniffel/domain/game/game_model.dart';
import 'package:kniffel/domain/general/highscore_storage.dart';
import 'package:provider/provider.dart';

class WinScreen extends StatefulWidget {
  const WinScreen({super.key});

  @override
  State<WinScreen> createState() => _WinScreenState();
}

class _WinScreenState extends State<WinScreen> {
  List<Widget> _buildPlayerScores(GameModel model) {
    return model
        .sortPlayersByScore()
        .map((player) => ListTile(
              titleAlignment: ListTileTitleAlignment.center,
              title: Center(child: Text(player.name)),
              subtitle: Center(
                  child: Text('Score: ${player.kniffelSheet.scores[2]}')),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<GameModel>(context);
    final HighscoreStorage storage = ImplementedHighscoreStorage();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Game over!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            model.getWinText(),
            const SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Player scores:'),
                const Divider(),
                ..._buildPlayerScores(model),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                storage.saveAllHighscores(model.sortPlayersByScore());
                model.resetGame();
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: const Text('Back to player selection'),
            ),
          ],
        ),
      ),
    );
  }
}
