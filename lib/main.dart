import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:train_stop2/screens/home.dart';

import 'models/selected_stations.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SelectedStationsProvider>(
      create: (context) => SelectedStationsProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}
