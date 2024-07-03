import 'package:flutter/material.dart';
import 'package:kniffel/domain/highscore.dart';

class HighscoreItem extends StatelessWidget {
  final Highscore highscore;
  final int index;

  const HighscoreItem(
      {super.key, required this.highscore, required this.index});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        '$index',
        style: TextStyle(
          fontSize: 24,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      ),
      title: Text(
        highscore.name,
        style: TextStyle(
          fontSize: 24,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      ),
      subtitle: Text(
        'Score: ${highscore.score}\nDate: ${highscore.date.toLocal()}',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      ),
      isThreeLine: true,
    );
  }
}
