import 'package:flutter/material.dart';
import 'package:kniffel/presentation/game_screen.dart';
import 'package:provider/provider.dart';

import '../domain/models.dart';

class EnterPlayers extends StatefulWidget {
  const EnterPlayers({super.key});

  @override
  State<EnterPlayers> createState() => _EnterPlayersState();
}

class _EnterPlayersState extends State<EnterPlayers> {
  List<Widget> showPlayers() {
    return context
        .read<GameModel>()
        .players
        .map((player) => Text(player.name))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    var players = List.generate(4, (index) => Player('Player ${index + 1}'));
    var model = context.read<GameModel>();
    for (var player in players) {
      model.addPlayer(player);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Players'),
      ),
      body: Center(
        child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Players:'),
            ...showPlayers(),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
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
