void main() {
  // print("${findConnectingTrains(['A', 'C', 'F', 'H'])}");
}


class Train {
  final String name;
  final List<String> stops;

  Train(this.name, this.stops);
}

List<Train> trainDataSet = [
  Train('1', ['A', 'B', 'C']),
  Train('2', ['C', 'D', 'E', 'F']),
  Train('3', ['F', 'G', 'H', 'I']),
];

List<String> findConnectingTrains(List<String> stops) {
  List<String> connectingTrains = [];

  for (int i = 0; i < stops.length - 1; i++) {
    String startStop = stops[i];
    String endStop = stops[i + 1];

    for (Train train in trainDataSet) {
      if (train.stops.contains(startStop) && train.stops.contains(endStop)) {
        connectingTrains.add(train.name);
        break;
      }
    }
  }

  return connectingTrains;
}
