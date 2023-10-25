

import 'package:flutter/material.dart';


class DropdownSearchBox extends StatefulWidget {
  @override
  _DropdownSearchBoxState createState() => _DropdownSearchBoxState();
}

class _DropdownSearchBoxState extends State<DropdownSearchBox> {
  List<String> items = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Fig',
    'Grape',
    'Lemon',
    'Mango',
    'Orange',
    'Pineapple',
    'Strawberry',
    'Watermelon',
  ];

  String selectedValue = '';
  List<String> filteredItems = [];

  void onSearchTextChanged(String text) {
    filteredItems.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    items.forEach((item) {
      if (item.toLowerCase().contains(text.toLowerCase())) {
        filteredItems.add(item);
      }
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            onChanged: onSearchTextChanged,
            decoration: const InputDecoration(labelText: 'Search'),
          ),
          const SizedBox(height: 10),
          DropdownButton<String>(
            value: selectedValue,
            onChanged: (String? newValue) {
              setState(() {
                selectedValue = newValue!;
              });
            },
            items: filteredItems.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
