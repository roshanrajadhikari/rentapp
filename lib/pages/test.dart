import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
void main()
{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Learning',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState()
  {
    return _MyHomePageState();
  }
}

class Tech
{
  String label;
  Color color;
  bool isSelected;
  Tech(this.label, this.color, this.isSelected);
}

class _MyHomePageState extends State<MyHomePage> {
  bool selected = false;
  List<Tech> _chipsList = [
    Tech("Android", Colors.green, false),
    Tech("Flutter", Colors.blueGrey, false),
    Tech("Ios", Colors.deepOrange, false),
    Tech("Python", Colors.cyan, false),
    Tech("Go lang", Colors.yellow, false)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Chip"),
      ),
      body: Wrap(
        spacing: 8,
        direction: Axis.horizontal,
        children: techChips(),
      )
    );
  }

  List<Widget> techChips () {
    List<Widget> chips = [];
    for (int i=0; i< _chipsList.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(left:10, right: 5),
        child: FilterChip(
          label: Text(_chipsList[i].label),
          labelStyle: TextStyle(color: Colors.white),
          backgroundColor: _chipsList[i].color,
          selected: _chipsList[i].isSelected,
          onSelected: (bool value)
          {
            setState(() {
              _chipsList[i].isSelected = value;
            });
          },
        ),
      );
      chips.add(item);
    }
    return chips;
  }
}