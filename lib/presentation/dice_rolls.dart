import 'package:dice_icons/dice_icons.dart';
import 'package:flutter/material.dart';

import '../domain/dice.dart';
import 'animated_dice.dart';

class DiceRolls extends StatefulWidget {
  const DiceRolls({super.key});

  @override
  State<DiceRolls> createState() => _DiceRollsState();
}

class _DiceRollsState extends State<DiceRolls> with TickerProviderStateMixin {
  final List<IconData> _diceIcons = [
    DiceIcons.dice0,
    DiceIcons.dice1,
    DiceIcons.dice2,
    DiceIcons.dice3,
    DiceIcons.dice4,
    DiceIcons.dice5,
    DiceIcons.dice6,
  ];

  final int _numberDices = 5;
  late List<Dice> dices;
  late List<IconData> sequenceDices;
  late TweenSequence<IconData> sequence;

  void _rollDices() {
    for (var dice in dices) {
      dice.rollDice();
    }
  }

  // void _rollDice(Dice dice) async {
  //   int value;
  //   value = Random().nextInt(6) + 1;
  //   dice.diceValue = value;
  //   dice.diceIcon = _diceIcons.elementAt(value);

  //   await dice.controller.forward(from: 0.0);
  //   dice.controller.value = value / 7.0;
  // }

  void _rollAnimations() async {
    for (var dice in dices) {
      dice.controller = AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
      );

      dice.animation = sequence.animate(dice.controller);

      dice.rollDice();
      dice.controller.forward();
    }
  }

  List<Widget> _buildDices() {
    var widgets =
        dices.map((dice) => AnimatedDice(animation: dice.animation)).toList();
    return widgets;
  }

  @override
  void initState() {
    super.initState();
    dices = List.generate(_numberDices, (index) => Dice());
    sequenceDices = List<IconData>.from(_diceIcons)..add(DiceIcons.dice0);
    sequence = TweenSequence<IconData>(sequenceDices
        .map((icon) => TweenSequenceItem<IconData>(
            tween: ConstantTween<IconData>(icon), weight: 1))
        .toList());
    _rollAnimations();
  }

  @override
  void dispose() {
    for (var d in dices) {
      d.controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // const Text(
        //   'You have rolled:',
        // ),
        // Text(
        //   dices.map((dice) => dice.diceValue).toList().join(', '),
        //   style: Theme.of(context).textTheme.headlineMedium,
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildDices(),
        ),
        const SizedBox(height: 30),
        FloatingActionButton(
          onPressed: _rollDices,
          tooltip: 'Roll',
          child: const Icon(
            Icons.casino,
          ),
        ),
      ],
    );
  }
}
