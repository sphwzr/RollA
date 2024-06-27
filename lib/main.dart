import 'dart:core';

import 'package:flutter/material.dart';
import 'package:kniffel/presentation/enter_players.dart';
import 'package:provider/provider.dart';

import 'domain/models.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameModel>(
      create: (context) => GameModel(),
      child: MaterialApp(
        title: 'Flutter',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
          useMaterial3: true,
        ),
        home: const EnterPlayers(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // List columns = [
  //   {"title": 'Wurf', "key":'roll'},
  //   {"title": 'Punkte', "key":'point'},
  //   {"title": 'Spiel 1', "key":'game1'},
  //   {"title": 'Spiel 2', "key":'game2'},
  //   {"title": 'Spiel 3', "key":'game3'},
  // ];
  // List rows= [
  //   {"roll": "1er", "point": "nur Einser zählen"},
  //   {"roll": "2er", "point": "nur Zweier zählen"},
  //   {"roll": "3er", "point": "nur Dreier zählen"},
  //   {"roll": "4er", "point": "nur Vierer zählen"},
  //   {"roll": "5er", "point": "nur Fünfer zählen"},
  //   {"roll": "6er", "point": "nur Sechser zählen"},
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: EnterPlayers(),
      ),
    );
  }
}
