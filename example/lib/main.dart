import 'package:flutter/material.dart';
import 'package:grouped_selection/grouped_selection.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Grouped Selection Example")),
        body: Center(
          child: GroupedSelection(
            items: [
              SelectionItem(text: 'Item 1'),
              SelectionItem(text: 'Item 2'),
              SelectionItem(text: 'Item 3'),
            ],
            columnCount: 2,
            onSelectionChanged: (selectedItems) {
              // Handle selection change
            },
          ),
        ),
      ),
    );
  }
}
