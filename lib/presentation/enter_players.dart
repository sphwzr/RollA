import 'package:flutter/material.dart';
import 'package:kniffel/domain/game_model.dart';
import 'package:kniffel/domain/player_model.dart';
import 'package:kniffel/presentation/game_screen.dart';
import 'package:provider/provider.dart';

class EnterPlayers extends StatefulWidget {
  final int numberOfPlayers;
  const EnterPlayers({super.key, required this.numberOfPlayers});

  @override
  State<EnterPlayers> createState() => _EnterPlayersState();
}

class _EnterPlayersState extends State<EnterPlayers> {
  List<Player> newPlayers = [];
  List<TextEditingController> controllers = [];

  List<Widget> _createEnterPlayer() {
    var playerCount = widget.numberOfPlayers;
    var playerWidgets = <Widget>[];
    for (var i = 0; i < playerCount; i++) {
      controllers.add(TextEditingController());
      playerWidgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: TextField(
            controller: controllers[i],
            // onChanged: (value) {
            //   newPlayers.add(Player(controller.value.text));
            // },
            decoration: InputDecoration(
              labelText: 'Player ${i + 1}',
            ),
          ),
        ),
      );
    }
    return playerWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Players:'),
            ..._createEnterPlayer(),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                var model = context.read<GameModel>();
                for (var controller in controllers) {
                  newPlayers.add(Player(controller.value.text));
                }
                model.addPlayers(newPlayers);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const GameScreen(),
                  ),
                );
              },
              child: const Text('Start Game'),
            ),
          ],
        ),
      ),
    );
  }
}
