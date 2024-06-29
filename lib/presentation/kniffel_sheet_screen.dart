import 'package:flutter/material.dart';
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
  // KniffelSheet get currentSheet => widget.currentPlayer.kniffelSheet;

  TextStyle headingStyle = const TextStyle(
      fontSize: 15.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic);
  final shapeBorder = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(1.0),
      side: const BorderSide(color: Colors.black, width: 1.0));

  Widget _createTile(
      KniffelSheet currentSheet, int sectionIndex, int rowIndex) {
    String elementName =
        currentSheet.getSectionElementTitle(sectionIndex, rowIndex);
    int elementValue =
        currentSheet.getSectionElementValue(sectionIndex, rowIndex);
    String elementValueString = elementValue > 0 ? elementValue.toString() : '';

    return ListTile(
      shape: shapeBorder,
      title: InkWell(
        onTap: () {
          currentSheet.setSheetValues(sectionIndex, rowIndex,
              widget.currentPlayer.getSelectedDiceValuesAsDiceRoll());
        },
        child: Row(
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
                    children: [
                      const SizedBox(width: 10),
                      Text(
                        '${widget.currentPlayer.kniffelSheet.getScoreTitle(entry.key)}: ',
                        style: const TextStyle(fontSize: 13.0),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        entry.value != 0 ? entry.value.toString() : '',
                        style: const TextStyle(fontSize: 13.0),
                      ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kniffel Sheet'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Provider.of<GameModel>(context)
                .getSelectedDiceText(clickable: false),
            const Text('Enter Scores Here:'),
            _createSheet(),
          ],
        ),
      ),
    );
  }
}
