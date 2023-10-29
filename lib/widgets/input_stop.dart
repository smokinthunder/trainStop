import 'package:flutter/material.dart';
import 'package:train_stop2/models/stations.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

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
                yourController.text = suggestion.name;
                setState(() {
                  selectedStation = suggestion;
                });
                selectedStations[id] = suggestion;
              },
              transitionBuilder: (context, suggestionsBox, controller) {
                return suggestionsBox;
              },
              onSaved: (value) {
                // Handle saving the value if needed
              },
            ),
          ),
          Expanded(
            // height: 35,
            // width: 35,
            // decoration: BoxDecoration(
            //   color: Colors.red,
            //   borderRadius: BorderRadius.circular(5),
            // ),
            child: IconButton(
              onPressed: () {
                selectedStations.removeAt(0);
              },
              iconSize: 18,
              icon: const Icon(Icons.delete),
            ),
          )
          
        ],
      ),
    );
  }
}

// class DeleteButton extends StatelessWidget {
//   const DeleteButton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 35,
//       width: 35,
//       decoration: BoxDecoration(
//         color: Colors.red,
//         borderRadius: BorderRadius.circular(5),
//       ),
//       child: IconButton(
//         color: Colors.white,
//         onPressed: () {
//           selectedStations.removeAt(id);
//         },
//         iconSize: 18,
//         icon: const Icon(Icons.delete),
//       ),
//     );
//   }
// }


