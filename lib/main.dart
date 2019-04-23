import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

//Define "root widget"
void main() => runApp(new MyApp()); //one-line function

//StatefulWidget
class RandomEnglishWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RandomEnglishWordsState(); //return a state's object. Where is the state's class ?
  }
}

//State
class RandomEnglishWordsState extends State<RandomEnglishWords> {
  final _words =
      <WordPair>[]; //Words displayed in ListView, 1 row contains 1 word
  final _checkedWords = Set<WordPair>();
  @override
  Widget build(BuildContext context) {
    //Now we replace this with a Scaffold widget which contains a ListView
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("List of English words"),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.list),
            onPressed: _pushToSavedWordsScreen,
          )
        ],
      ),
      body: new ListView.builder(itemBuilder: (context, index) {
        //This is an anonymous function
        if (index >= _words.length) {
          _words.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_words[index], index); //Where is _buildRow ?
      }),
    );
  }

  _pushToSavedWordsScreen() {
    final pageRoute = new MaterialPageRoute(builder: (context) {
      final listTiles = _checkedWords.map((wordPair) {
        return new ListTile(
          title: new Text(
            wordPair.asUpperCase,
            style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        );
      });
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Checked words"),
        ),
        body: new ListView(
          children: listTiles.toList(),
        ),
      );
    });

    Navigator.of(context).push(pageRoute);
  }

  Widget _buildRow(WordPair wordPair, int index) {
    final color = index % 2 == 0 ? Colors.red : Colors.blue;
    final isChecked = _checkedWords.contains(wordPair);
    return new ListTile(
      leading: new Icon(
        isChecked ? Icons.check_box : Icons.check_box_outline_blank,
        color: color,
      ),
      title: new Text(
        wordPair.asUpperCase,
        style: new TextStyle(
          fontSize: 18.0,
          color: color,
        ),
      ),
      onTap: () {
        setState(() {
          if (isChecked) {
            _checkedWords.remove(wordPair);
          } else {
            _checkedWords.add(wordPair);
          }
        });
      },
    );
  }
}

class MyApp extends StatelessWidget {
  //Stateless = immutable = cannot change object's properties
  //Every UI components are widgets
  @override
  Widget build(BuildContext context) {
    //build function returns a "Widget"
    return new MaterialApp(
        title: "This is my first Flutter App",
        home: new RandomEnglishWords()); //Widget with "Material design"
  }
}
