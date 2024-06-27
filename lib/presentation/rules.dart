import 'package:flutter/material.dart';

class RulesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kniffel Rules' , style: TextStyle(color:  Theme.of(context).colorScheme.onPrimary)),
        backgroundColor:  Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Objective',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'The objective of Kniffel is to score the most points by rolling five dice to make certain combinations. The game consists of 13 rounds. In each round, you can roll the dice up to three times to achieve one of the 13 scoring combinations.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Gameplay',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '1. Roll up to three times each turn to achieve the best scoring combination.\n'
              '2. After each roll, you may set aside any dice and roll the remaining dice.\n'
              '3. After the third roll, or if you are satisfied with a roll before then, choose a scoring category and record your score.\n'
              '4. Each category can be used only once.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Scoring Categories',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Upper Section:\n'
              '• Ones: Sum of all dice showing 1.\n'
              '• Twos: Sum of all dice showing 2.\n'
              '• Threes: Sum of all dice showing 3.\n'
              '• Fours: Sum of all dice showing 4.\n'
              '• Fives: Sum of all dice showing 5.\n'
              '• Sixes: Sum of all dice showing 6.\n'
              '\nLower Section:\n'
              '• Three of a Kind: Sum of all dice if three dice are the same.\n'
              '• Four of a Kind: Sum of all dice if four dice are the same.\n'
              '• Full House: 25 points for a full house (three of one number and two of another).\n'
              '• Small Straight: 30 points for a sequence of four dice (e.g., 1-2-3-4).\n'
              '• Large Straight: 40 points for a sequence of five dice (e.g., 1-2-3-4-5).\n'
              '• Kniffel (Yahtzee): 50 points for five of a kind.\n'
              '• Chance: Sum of all dice, any combination.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Bonus',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'If the total score in the upper section is 63 or more, you get a bonus of 35 points.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
