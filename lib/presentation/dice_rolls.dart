import 'package:dice_icons/dice_icons.dart';
import 'package:flutter/material.dart';

import '../domain/models.dart';
import 'animated_dice.dart';

class DiceRolls extends StatefulWidget {
  const DiceRolls({super.key});

  @override
  State<DiceRolls> createState() => _DiceRollsState();
}

class _DiceRollsState extends State<DiceRolls> with TickerProviderStateMixin {
  late int _numberDices;
  late List<Dice> dices;
  List<IconData> sequenceDices = Dice().diceIcons.toList()
    ..add(DiceIcons.dice0);
  late TweenSequence<IconData> sequence;

  void _rollDices() {
    for (var dice in dices) {
      dice.rollDice();
    }
  }

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
    _numberDices = 5;
    dices = List.generate(_numberDices, (index) => Dice());
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
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
