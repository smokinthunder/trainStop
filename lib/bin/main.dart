import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Station {
  final String id;
  final String name;

  Station({required this.id, required this.name});
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyPage(),
    );
  }
}

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  List<Station> stations = [];
  List<Station> selectedStations = [];
  List<Station> stops = [];

  @override
  void initState() {
    super.initState();
    fetchStations();
  }

  Future<void> fetchStations() async {
    final url = Uri.parse('https://rstations.p.rapidapi.com/');
    final response = await http.get(url, headers: {
      'X-RapidAPI-Host': 'rstations.p.rapidapi.com',
      'X-RapidAPI-Key': '452e0ac1f5mshfc0ab50beeb55e0p15b98djsn687513ed817b', // Replace with your RapidAPI key
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> stationList = data['stations'];
      setState(() {
        stations = stationList
            .map((station) => Station(id: station['id'], name: station['name']))
            .toList();
      });
    } else {
      throw Exception('Failed to fetch stations');
    }
  }

  void addStop() {
    if (selectedStations.length == 2) {
      final newStop = selectedStations[1];
      setState(() {
        stops.add(newStop);
        selectedStations[1] = selectedStations[0];
      });
    }
  }

  void deleteStop(int index) {
    setState(() {
      stops.removeAt(index);
    });
  }

  void onReorder(int oldIndex, int newIndex) {
    setState(() {
      final station = stops.removeAt(oldIndex);
      stops.insert(newIndex, station);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Station Selector'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                DropdownButton<Station>(
                  hint: const Text('From Station'),
                  value: selectedStations.isNotEmpty ? selectedStations[0] : null,
                  onChanged: (station) {
                    setState(() {
                      selectedStations[0] = station!;
                    });
                  },
                  items: stations.map<DropdownMenuItem<Station>>((station) {
                    return DropdownMenuItem<Station>(
                      value: station,
                      child: Text(station.name),
                    );
                  }).toList(),
                ),
                DropdownButton<Station>(
                  hint: const Text('To Station'),
                  value: selectedStations.length > 1 ? selectedStations[1] : null,
                  onChanged: (station) {
                    setState(() {
                      selectedStations[1] = station!;
                    });
                  },
                  items: stations.map<DropdownMenuItem<Station>>((station) {
                    return DropdownMenuItem<Station>(
                      value: station,
                      child: Text(station.name),
                    );
                  }).toList(),
                ),
                ElevatedButton(
                  onPressed: addStop,
                  child: const Text('Add Stop'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ReorderableListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              onReorder: onReorder,
              children: stops.asMap().entries.map((entry) {
                final index = entry.key;
                final station = entry.value;
                return ListTile(
                  key: Key(station.id),
                  title: Text(station.name),
                  onTap: () => deleteStop(index),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
