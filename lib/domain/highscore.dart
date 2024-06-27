class Highscore {
  final String name;
  final int score;
  final DateTime date;

  Highscore({required this.name, required this.score, required this.date});

  // Convert a Highscore object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'score': score,
      'date': date.toIso8601String(),
    };
  }

  // Extract a Highscore object from a Map object
  factory Highscore.fromMap(Map<String, dynamic> map) {
    return Highscore(
      name: map['name'],
      score: map['score'],
      date: DateTime.parse(map['date']),
    );
  }
}
