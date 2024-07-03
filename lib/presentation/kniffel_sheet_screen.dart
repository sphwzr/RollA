import 'package:flutter/material.dart';
import 'package:kniffel/domain/dice_model.dart';
import 'package:kniffel/domain/game_model.dart';
import 'package:kniffel/domain/kniffel_sheet_model.dart';
import 'package:kniffel/domain/player_model.dart';
import 'package:provider/provider.dart';

class KniffelSheetScreen extends StatefulWidget {
  const KniffelSheetScreen({super.key, required this.currentPlayer});

  final Player currentPlayer;

  @override
  State<KniffelSheetScreen> createState() => _KniffelSheetScreenState();
}

class _KniffelSheetScreenState extends State<KniffelSheetScreen> {
  TextStyle headingStyle = const TextStyle(
      fontSize: 15.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic);
  final shapeBorder = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(1.0),
      side: const BorderSide(color: Colors.black, width: 1.0));
  bool _isDisabled = false;

  Widget _createTile(
      KniffelSheet currentSheet, int sectionIndex, int rowIndex) {
    String elementName =
        currentSheet.getSectionElementTitle(sectionIndex, rowIndex);
    int elementValue =
        currentSheet.getSectionElementValue(sectionIndex, rowIndex);
    String elementValueString =
        elementValue >= 0 ? elementValue.toString() : '';

    return InkWell(
      onTap: () {
        bool success = currentSheet.setSheetValues(sectionIndex, rowIndex,
            widget.currentPlayer.getSelectedDiceValuesAsDiceRoll());
        if (_isDisabled || !success) return;
        setState(() {
          _isDisabled = true;
        });
      },
      child: ListTile(
        enabled: !_isDisabled,
        shape: shapeBorder,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(width: 10),
            Text(
              '$elementName: ',
              style: const TextStyle(fontSize: 13.0),
            ),
            const SizedBox(width: 30),
            Text(
              elementValueString,
              style: const TextStyle(fontSize: 13.0),
            ),
            const SizedBox(width: 20),
            TextButton(
              onPressed: () {
                var success =
                    currentSheet.crossElementOut(sectionIndex, rowIndex);
                if (_isDisabled || !success) return;
                setState(() {
                  _isDisabled = true;
                });
              },
              child: const Icon(Icons.clear),
            )
          ],
        ),
      ),
    );
  }

  Widget _createSubScreen(
      KniffelSheet currentSheet, int index, String heading) {
    List<int> sheetSection =
        index == 0 ? currentSheet.upperSection : currentSheet.lowerSection;

    return ExpansionTile(
      shape: shapeBorder,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            heading,
            style: headingStyle,
          ),
        ],
      ),
      children: <Widget>[
        Column(children: [
          ...sheetSection.asMap().entries.map((entry) {
            return _createTile(currentSheet, index, entry.key);
          }),
        ]),
      ],
    );
  }

  Widget _createScoreScreen(String heading) {
    return ExpansionTile(
      shape: shapeBorder,
      title: Text(
        heading,
        style: headingStyle,
      ),
      children: <Widget>[
        Column(
          children: <Widget>[
            ...widget.currentPlayer.kniffelSheet.scores.asMap().entries.map(
              (entry) {
                return ListTile(
                  shape: shapeBorder,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(width: 10),
                      Text(
                        '${widget.currentPlayer.kniffelSheet.getScoreTitle(entry.key)}: ',
                        style: const TextStyle(fontSize: 13.0),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        entry.value.toString(),
                        style: const TextStyle(fontSize: 13.0),
                      ),
                      const SizedBox(width: 150),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _createSheet() {
    List<String> headings = ['Single Digits', 'Special Combinations', 'Scores'];

    return Consumer<GameModel>(
      builder: (context, model, child) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: ListView.builder(
            itemCount: headings.length,
            itemBuilder: (context, index) {
              if (index == 2) {
                return _createScoreScreen(headings[index]);
              }
              return _createSubScreen(
                  model.currentPlayer.kniffelSheet, index, headings[index]);
            },
          ),
        );
      },
    );
  }

  void _selectRemainingDices() {
    var model = Provider.of<GameModel>(context);
    var player = model.currentPlayer;
    if (player.getNumberOfRolls() != 0 &&
        player.selectedDiceValues.length < 5) {
      // iterate through last diceRoll and add to selectedDiceValues if not selected
      for (var i = 0; i < 5; i++) {
        Dice dice = player.diceRolls.last.dices[i];
        !dice.isSelected
            ? model.addCurrentPlayerDiceValue(dice.diceValue)
            : null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<GameModel>(context);
    _selectRemainingDices();
    return Scaffold(
      appBar: AppBar(
        title: Text('Kniffel Sheet of ${model.currentPlayer.name}'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_forward),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            model.getSelectedDiceText(clickable: false),
            const Text('Enter Scores Here:'),
            _createSheet(),
          ],
        ),
      ),
    );
  }
}
