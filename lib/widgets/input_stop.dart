import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:train_stop2/models/selected_stations.dart';
import 'package:train_stop2/models/stations.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:train_stop2/screens/home.dart';

class InputStop extends StatelessWidget {
  const InputStop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class StopSelect extends StatefulWidget {
  final int id;
  // final void Function(Station) onStationSelected;

  const StopSelect({
    Key? key,
    required this.id,
    // required this.onStationSelected,
  }) : super(key: key);

  @override
  State<StopSelect> createState() => _StopSelectState(id: id);
}

class _StopSelectState extends State<StopSelect> {
  final int id;
  Station? selectedStation;
  final TextEditingController yourController = TextEditingController();

  _StopSelectState({
    required this.id,
  });

  List<Station> stations = [];

  @override
  void initState() {
    super.initState();
    loadStationsData(); // Assumes loadStations() is an asynchronous function to fetch stations
  }

  Future<void> loadStationsData() async {
    List<Station> loadedStations =
        await loadStations(); // Assuming loadStations() fetches station data
    setState(() {
      stations = loadedStations;
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedStationsProvider = context.watch<SelectedStationsProvider>();
    final selectedStations = selectedStationsProvider.selectedStations;
    if (selectedStations[id] != null) {
      yourController.text = selectedStations[id]!.name;
    }
    return Container(
      margin: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: TypeAheadFormField<Station>(
              textFieldConfiguration: TextFieldConfiguration(
                decoration: InputDecoration(
                  labelText: 'Select station ${id + 1}',
                  border: const OutlineInputBorder(),
                ),
                controller: yourController,
              ),
              suggestionsCallback: (pattern) {
                return stations.where((station) {
                  return station.name
                      .toLowerCase()
                      .contains(pattern.toLowerCase());
                });
              },
              itemBuilder: (context, Station suggestion) {
                return ListTile(
                  title: Text(suggestion.name),
                );
              },
              onSuggestionSelected: (Station suggestion) {
                setState(() {
                  yourController.text = suggestion.name;

                  // selectedStation = suggestion;
                  // selectedStations[id] = suggestion;
                });
                selectedStationsProvider.editAtIndex(id, suggestion);
              },
              transitionBuilder: (context, suggestionsBox, controller) {
                return suggestionsBox;
              },
              onSaved: (value) {
                // Handle saving the value if needed
              },
            ),
          ),
          IconButton(
            onPressed: () {
                selectedStationsProvider.makeItNull(id);
                yourController.text = '';
              
            },
            iconSize: 18,
            icon: const Icon(Icons.cancel_outlined),
          ),
          IconButton(
            onPressed: () {
              selectedStationsProvider.delete(id);

              // Navigator.of(context).pushReplacement(MaterialPageRoute(
              //   builder: (context) => const Home(),
              // ));
            },
            iconSize: 18,
            icon: const Icon(Icons.delete_outline),
          )
        ],
      ),
    );
  }
}
