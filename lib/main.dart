import 'dart:core';

import 'package:flutter/material.dart';
import 'package:kniffel/presentation/dice_rolls.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // DiceRoll(),
            DiceRolls(),
            // Column(
            //   children: [
            //     Table(
            //       border: TableBorder.all(),
            //       columnWidths: const <int, TableColumnWidth>{
            //         0: IntrinsicColumnWidth(),
            //         1: FlexColumnWidth(),
            //         2: FixedColumnWidth(64),
            //       },
            //       defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            //       children: <TableRow>[
            //         TableRow(
            //           children: <Widget>[
            //             const Text("1er"),
            //             const Text("nur Einser zählen"),
            //             // Checkbox(value: value, onChanged: onChanged)

            //           ],
            //         ),
            //         TableRow(
            //           children: <Widget>[
            //             const Text("2er"),
            //             const Text("nur Zweier zählen"),
            //           ],
            //         ),
            //       ],
            //     ),

            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
