import 'package:flutter/material.dart';
import 'package:train_stop/widgets/inputStop.dart';
// import 'package:train_stop/model/selectedStations.dart';
import 'package:train_stop/model/selectedStationsList.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: const Icon(Icons.menu),
        backgroundColor: Colors.black,
        title: const Text("Transit Finder"),
      ),
      body: const HomeBody(),
    );
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  // var numberOfStops = 1;
  // List<SelectedStations> selectedStations = [];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          const Text(
            "Enter Stations",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold
              
            ),
          ),
          for (var i = 0; i < selectedStations!.getSize() ; i++) InputStop(id: i),
          Container(
            margin: const EdgeInsets.only(
              left: 80,
              right: 80,
            ),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedStations!.insertEmptyNode();
                });
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
