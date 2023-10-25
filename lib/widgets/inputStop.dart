import 'package:flutter/material.dart';
import 'package:train_stop/model/stations.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:train_stop/model/selectedStationsList.dart';

class InputStop extends StatefulWidget {
  final int id; // Add an int id to the constructor

  const InputStop({Key? key, required this.id}) : super(key: key);

  @override
  State<InputStop> createState() => _InputStopState(id: id); // Pass the id to the state
}

class _InputStopState extends State<InputStop> {
  final int id; // Add an int id property to the state

  _InputStopState({required this.id}); // Initialize id in the state constructor

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.all(20),
      child: Row(
        children: [
          StopSelect(id: id), // Pass the id to the StopSelect widget
        ],
      ),
    );
  }
}

class StopSelect extends StatefulWidget {
  final int id; // Add an int id to the constructor

  const StopSelect({Key? key, required this.id}) : super(key: key);

  @override
  State<StopSelect> createState() => _StopSelectState(id: id); // Pass the id to the state
}

class _StopSelectState extends State<StopSelect> {
  final int id; // Add an int id property to the state

  _StopSelectState({required this.id}); // Initialize id in the state constructor

  List<Station> stations = [];
  var selectedStation = '';
  final TextEditingController yourController = TextEditingController(); // Create a TextEditingController

  @override
  void initState() {
    super.initState();
    _loadStations();
  }

  _loadStations() async {
    List<Station> loadedStations = await loadStations();
    setState(() {
      stations = loadedStations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TypeAheadFormField<Station>(
        textFieldConfiguration: TextFieldConfiguration(
          decoration: InputDecoration(
            labelText: 'Select a station $id',
            border: const OutlineInputBorder(),
          ),
          controller: yourController, // Assign your controller
        ),
        suggestionsCallback: (pattern) {
          return stations.where((station) {
            return station.name.toLowerCase().contains(pattern.toLowerCase());
          });
        },
        itemBuilder: (context, Station suggestion) {
          return ListTile(
            title: Text(suggestion.name),
          );
        },
        onSuggestionSelected: (Station suggestion) {
          yourController.text = suggestion.name;
          setState(() {
            selectedStation = suggestion.code; // Update your selected value
          });
        },
        transitionBuilder: (context, suggestionsBox, controller) {
          return suggestionsBox;
        },
        onSaved: (value) {
          // Handle saving the value if needed
        },
      ),
    );
  }
}
