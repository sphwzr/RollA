import 'package:dice_icons/dice_icons.dart';
import 'package:flutter/material.dart';
import 'package:kniffel/domain/dice/dice_roll_model.dart';
import 'package:kniffel/domain/game/game_model.dart';
import 'package:kniffel/domain/player/player_model.dart';
import 'package:provider/provider.dart';

import '../../domain/dice/dice_model.dart';
import 'animated_dice.dart';

class DiceRolls extends StatefulWidget {
  const DiceRolls({super.key, required this.currentPlayer});

  final Player currentPlayer;

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
    DiceRoll rolled = DiceRoll();
    var model = Provider.of<GameModel>(context, listen: false);

    for (var dice in dices) {
      if (dice.isSelected) {
        dice.setVisibility(false);
      } else {
        dice.rollDice();
      }
      rolled.dices
          .where((element) => element.diceValue == 0)
          .first
          .setDice(dice);
      // dice.resetSelected();
    }

    model.currentPlayer.addDiceRoll(rolled);
    model.nextRoll();
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
    var widgets = dices
        .asMap()
        .map((i, dice) => MapEntry(
            i,
            Stack(
              children: [
                Visibility(
                  maintainAnimation: true,
                  maintainState: true,
                  visible: dice.isVisible,
                  child: InkWell(
                      onTap: () {
                        var model =
                            Provider.of<GameModel>(context, listen: false);
                        if (model.currentRoll > 0 && model.currentRoll < 3) {
                          if (dice.isSelected) {
                            model.removeCurrentPlayerDiceValue(dice.diceValue);
                            model.currentPlayer.toggleSelectedDiceIndex(i);
                          } else {
                            model.addCurrentPlayerDiceValue(dice.diceValue);
                            model.currentPlayer.toggleSelectedDiceIndex(i);
                          }
                          dice.toggleSelected();
                        }
                      },
                      child: AnimatedDice(animation: dice.animation)),
                ),
              ],
            )))
        .values
        .toList();

    var rows = <Widget>[
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widgets.sublist(0, 3)),
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widgets.sublist(3, 5))
    ];
    return rows;
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
  void didUpdateWidget(covariant DiceRolls oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentPlayer != widget.currentPlayer) {
      dices = List.generate(_numberDices, (index) => Dice());
      _rollAnimations();
    }
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
    var model = Provider.of<GameModel>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _buildDices(),
        ),
        const SizedBox(height: 30),
        if (model.currentRoll < 3 &&
            model.currentPlayer.selectedDiceValues.length < 5)
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
