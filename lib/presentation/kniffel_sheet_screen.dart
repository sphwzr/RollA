import 'package:flutter/material.dart';
import 'package:kniffel/domain/models.dart';

class KniffelSheetScreen extends StatefulWidget {
  const KniffelSheetScreen({super.key, required this.currentPlayer});

  final Player currentPlayer;

  @override
  State<KniffelSheetScreen> createState() => _KniffelSheetScreenState();
}

class _KniffelSheetScreenState extends State<KniffelSheetScreen> {
  KniffelSheet get currentSheet => widget.currentPlayer.kniffelSheet;

  Widget _createTile(int sectionIndex, int rowIndex) {
    String elementName =
        currentSheet.getSectionElementTitle(sectionIndex, rowIndex);
    int elementValue =
        currentSheet.getSectionElementValue(sectionIndex, rowIndex);
    String elementValueString = elementValue > 0 ? elementValue.toString() : '';

    return ListTile(
      title: Row(
        children: [
          const SizedBox(width: 10),
          Text(
            elementName,
            style: const TextStyle(fontSize: 13.0),
          ),
          const SizedBox(width: 10),
          Text(
            elementValueString,
            style: const TextStyle(fontSize: 13.0),
          ),
        ],
      ),
    );
  }

  Widget _createSubScreen(int index, String heading) {
    TextStyle headingStyle = const TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic);
    List<int> sheetSection =
        index == 0 ? currentSheet.upperSection : currentSheet.lowerSection;

    return ExpansionTile(
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
            return _createTile(index, entry.key);
          }),
        ]),
      ],
    );
  }

  Widget _createSheet() {
    List<String> headings = ['Single Digits', 'Special Combinations'];

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: ListView.builder(
        itemCount: headings.length,
        itemBuilder: (context, index) {
          return _createSubScreen(index, headings[index]);
        },
      ),
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
            const Text('Enter Scores Here:'),
            Text('Rolled: ${widget.currentPlayer.selectedDiceValues}'),
            _createSheet(),
          ],
        ),
      ),
    );
  }
}
