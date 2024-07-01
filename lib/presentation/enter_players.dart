import 'package:flutter/material.dart';
import 'package:kniffel/domain/game_model.dart';
import 'package:kniffel/domain/player_model.dart';
import 'package:kniffel/presentation/game_screen.dart';
import 'package:provider/provider.dart';

class EnterPlayers extends StatefulWidget {
  final int numberOfPlayers;
  EnterPlayers({super.key, required this.numberOfPlayers});

  @override
  State<EnterPlayers> createState() => _EnterPlayersState();
}

class _EnterPlayersState extends State<EnterPlayers> {
  late List<TextEditingController> _controllers;
  bool _allNamesEntered = false;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.numberOfPlayers, (index) => TextEditingController());
  }

  void _checkAllNamesEntered() {
    setState(() {
      _allNamesEntered = _controllers.every((controller) => controller.text.isNotEmpty);
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  List<Widget> showPlayers() {
    return _controllers
        .asMap()
        .entries
        .map((entry) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                controller: entry.value,
                decoration: InputDecoration(
                  labelText: 'Player ${entry.key + 1} Name',
                ),
                onChanged: (text) => _checkAllNamesEntered(),
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Players', style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Enter Player Names:'),
                ...showPlayers(),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _allNamesEntered
                      ? () {
                          var model = context.read<GameModel>();
                          for (var controller in _controllers) {
                            model.addPlayer(Player(controller.text));
                          }
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const GameScreen(),
                            ),
                          );
                        }
                      : null,
                  child: const Text('Start Game'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
