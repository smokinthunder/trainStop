import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:train_stop2/models/stations.dart';


class SelectedStationsProvider extends ChangeNotifier {
  List<Station?> selectedStations = [null,null];

  void reset() {
    selectedStations = [null, null];
    notifyListeners();
  }

  void insert() {
    selectedStations.add(null);
    notifyListeners();
  }

  void removeNull() {
    selectedStations.removeWhere((station) => station == null);
    notifyListeners();
  }

  void editAtIndex(int id, Station data) {
    selectedStations[id] = data;
    notifyListeners();
  }

  void delete(int id) {
    selectedStations.removeAt(id);
    notifyListeners();
  }

  void makeItNull(int id){
    selectedStations[id]=null;
  }
}
