import 'package:flutter/material.dart';
import 'package:train_stop2/models/stations.dart';
import 'package:train_stop2/widgets/input_stop.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // leading: const Icon(Icons.menu),
          backgroundColor: Colors.black,
          title: const Text("Transit Finder"),
        ),
        body: const HomeBody(),
      ),
    );
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.only(bottom: 80),
            children: [
              const Text(
                "Enter Stations",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              for (int i = 0; i < selectedStations.length; i++)
                StopSelect(id: i),

              // Text('$selectedStations')
            ],
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.only(bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedStations = [null, null];
                    });
                  },
                  child: const Icon(Icons.clear),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedStations.add(null);
                    });
                  },
                  child: const Icon(Icons.add),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Icon(Icons.arrow_right),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
