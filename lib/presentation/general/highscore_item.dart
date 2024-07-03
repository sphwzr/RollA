import 'package:flutter/material.dart';
import 'package:kniffel/domain/general/highscore.dart';

class HighscoreItem extends StatelessWidget {
  final Highscore highscore;
  final int index;

  const HighscoreItem(
      {super.key, required this.highscore, required this.index});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        '${index + 1}',
        style: const TextStyle(
          fontSize: 24,
        ),
      ),
      title: Text(
        highscore.name,
        style: const TextStyle(
          fontSize: 24,
        ),
      ),
      subtitle: Text(
        'Score: ${highscore.score}\nDate: ${highscore.date.toLocal()}',
        style: const TextStyle(),
      ),
      isThreeLine: true,
    );
  }
}
