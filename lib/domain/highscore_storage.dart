import 'dart:convert';
import 'package:kniffel/domain/highscore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HighscoreStorage {
  static const String _key = 'highscores';

  Future<void> saveHighscore(Highscore highscore) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> storedScores = prefs.getStringList(_key) ?? [];

    final List<Highscore> highscores = storedScores
        .map((score) => Highscore.fromMap(json.decode(score)))
        .toList();

    highscores.add(highscore);
    highscores.sort((a, b) => b.score.compareTo(a.score));

    final List<String> updatedScores =
        highscores.map((score) => json.encode(score.toMap())).toList();

    await prefs.setStringList(_key, updatedScores);
  }

  Future<List<Highscore>> getHighscores() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> storedScores = prefs.getStringList(_key) ?? [];
    return storedScores
        .map((score) => Highscore.fromMap(json.decode(score)))
        .toList();
  }
}
