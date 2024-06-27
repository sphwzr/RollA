import 'package:flutter/material.dart';
import 'package:kniffel/presentation/enter_players.dart';
import 'package:provider/provider.dart';

import '../domain/models.dart';

class ChoosNumberOfPlayers extends StatefulWidget {
  const ChoosNumberOfPlayers({super.key});

  @override
  State<ChoosNumberOfPlayers> createState() => _ChoosNumberOfPlayersState();
}

class _ChoosNumberOfPlayersState extends State<ChoosNumberOfPlayers> {
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
        title: Text('Choose number of Players',  style: TextStyle(color:  Theme.of(context).colorScheme.onPrimary)),
         backgroundColor:  Theme.of(context).colorScheme.primary,
         foregroundColor:  Theme.of(context).colorScheme.onPrimary ,
      ),
      body: Center(
        child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildPlayerButton(context, 2),
            _buildPlayerButton(context, 3),
            _buildPlayerButton(context, 4),
            _buildPlayerButton(context, 5),
          ],
        ),
      ),
    );
  }
  Widget _buildPlayerButton(BuildContext context, int playerCount) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EnterPlayers(numberOfPlayers: playerCount)
            ),
          );
        },
        child: Text('$playerCount Players'),
      ),
    );
  }
}
