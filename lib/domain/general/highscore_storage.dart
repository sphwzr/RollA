import 'dart:convert';
import 'package:kniffel/domain/general/highscore.dart';
import 'package:kniffel/domain/player/player_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class HighscoreStorage {
  Future<void> saveHighscore(Highscore highscore);
  Future<void> saveAllHighscores(List<Player> players);
  Future<List<Highscore>> getHighscores();
}

class ImplementedHighscoreStorage extends HighscoreStorage {
  static const String _key = 'highscores';
  @override
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

  @override
  Future<void> saveAllHighscores(List<Player> players) async {
    for (var player in players) {
      final highscore = Highscore(
        name: player.name,
        score: player.kniffelSheet.scores[2],
        date: DateTime.now(),
      );
      await saveHighscore(highscore);
    }
  }

  @override
  Future<List<Highscore>> getHighscores() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> storedScores = prefs.getStringList(_key) ?? [];
    return storedScores
        .map((score) => Highscore.fromMap(json.decode(score)))
        .toList();
  }
}
