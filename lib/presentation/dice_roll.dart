import 'dart:math';

import 'package:dice_icons/dice_icons.dart';
import 'package:flutter/material.dart';
import 'package:kniffel/presentation/animated_dice.dart';

import '../domain/dice.dart';

class DiceRoll extends StatefulWidget {
  const DiceRoll({super.key});

  @override
  State<DiceRoll> createState() => _DiceRollState();
}

class _DiceRollState extends State<DiceRoll>
    with SingleTickerProviderStateMixin {
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
  late List<Dice> dices = List.generate(_numberDices, (index) => Dice());
  late var sequenceDices = List<IconData>.from(_diceIcons)
    ..add(DiceIcons.dice0);

  int diceValue = 0;
  int diceValue2 = 0;
  IconData diceIcon = DiceIcons.dice0;
  IconData diceIcon2 = DiceIcons.dice0;

  late Animation<IconData> _animation;
  late Animation<IconData> _animation2;
  late AnimationController _controller;
  late AnimationController _controller2;

  void _rollDice() async {
    int value;
    value = Random().nextInt(6) + 1;
    _setDice(value);
    

    await _controller.forward(from: 0.0);
    _controller.value = value / 7.0;
    

    value = Random().nextInt(6) + 1;
    _setDice2(value);
    await _controller2.forward(from: 0.0);
    _controller2.value = value / 7.0;
  }

  void _setDice(int value) {
    setState(() {
      diceValue = value;
      diceIcon = _diceIcons.elementAt(value);
    });
  }

  void _setDice2(int value) {
    setState(() {
      diceValue2 = value;
      diceIcon2 = _diceIcons.elementAt(value);
    });
  }

  // void _rollAnimations() async {
  //   TweenSequence<IconData> sequence = TweenSequence<IconData>(sequenceDices
  //       .map((icon) => TweenSequenceItem<IconData>(
  //           tween: ConstantTween<IconData>(icon), weight: 1))
  //       .toList());

  //   for (var dice in dices) {
  //     dice.controller = AnimationController(
  //       duration: const Duration(milliseconds: 500),
  //       vsync: this,
  //     );
  //     dice.animation = TweenSequence<IconData>(_diceIcons
  //         .map((icon) => TweenSequenceItem<IconData>(
  //             tween: ConstantTween<IconData>(icon), weight: 1))
  //         .toList())
  //         .animate(controller!);
  //     _rollDice();
  //   }
  //   _animation = sequence.animate(_controller);
  //   _controller.forward();
  // }

  void _rollAnimation() async {
  _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _controller2 = new AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    TweenSequence<IconData> sequence = TweenSequence<IconData>(sequenceDices
        .map((icon) => TweenSequenceItem<IconData>(
            tween: ConstantTween<IconData>(icon), weight: 1))
        .toList());

    _animation = sequence.animate(_controller);
    _animation2 = sequence.animate(_controller2);
    _controller.forward();
    _controller2.forward();
  }

  @override
  void initState() {
    super.initState();
    _rollAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'You have rolled:',
        ),
        Text(
          '$diceValue and $diceValue2',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        AnimatedDice(animation: _animation),
        AnimatedDice(animation: _animation2),
        const SizedBox(height: 30),
        FloatingActionButton(
          onPressed: _rollDice,
          tooltip: 'Roll',
          child: Icon(
            diceIcon,
          ),
        ),
      ],
    );
  }
}
