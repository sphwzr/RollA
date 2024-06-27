

import 'package:flutter/material.dart';
import 'package:kniffel/domain/highscore.dart';
import 'package:kniffel/domain/highscore_storage.dart';

class HighscoreScreen extends StatelessWidget {
  final HighscoreStorage storage = HighscoreStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Highscores' ,style: TextStyle(color:  Theme.of(context).colorScheme.onPrimary)),
        backgroundColor:  Theme.of(context).colorScheme.primary,
      ),
      body: FutureBuilder<List<Highscore>>(
        future: storage.getHighscores(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading highscores'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No highscores available'));
          }

          final highscores = snapshot.data!;

          return ListView.builder(
            itemCount: highscores.length,
            itemBuilder: (context, index) {
              final highscore = highscores[index];
              return ListTile(
                title: Text('${highscore.name} - ${highscore.score}'),
                subtitle: Text('${highscore.date.toLocal()}'.split(' ')[0]),
              );
            },
          );
        },
      ),
    );
  }
}
