import 'package:train_stop/model/selectedStations.dart';
import 'package:train_stop/model/stations.dart';
// import 'package:train_stop/widgets/inputStop.dart';

class Node {
  Station? data;
  Node? next;
  Node? prev;
  int? index;

  Node(this.data);
}

class IndexedLinkedList {
  Node? head;
  Node? tail;
  int size = 0;

  IndexedLinkedList() {
    head = null;
    tail = null;
    size = 0;
    insertEmptyNode();
  }

  void insert(Station data) {
    Node newNode = Node(data);
    newNode.index = size;
    if (head == null) {
      head = newNode;
      tail = newNode;
    } else {
      newNode.prev = tail;
      tail!.next = newNode;
      tail = newNode;
    }
    size++;
  }

  void insertEmptyNode() {
    Node newNode = Node(null); // Create an empty node
    newNode.index = size;
    if (head == null) {
      head = newNode;
      tail = newNode;
    } else {
      newNode.prev = tail;
      tail!.next = newNode;
      tail = newNode;
    }
    size++;
  }

  void deleteAtIndex(int index) {
    if (head == null || index < 0 || index >= size) {
      return;
    }

    if (index == 0) {
      head = head!.next;
      if (head != null) {
        head!.prev = null;
      } else {
        tail = null;
      }
    } else if (index == size - 1) {
      tail = tail!.prev;
      tail!.next = null;
    } else {
      Node? current = head;
      while (current != null && current.index != index) {
        current = current.next;
      }

      if (current != null) {
        current.prev!.next = current.next;
        current.next!.prev = current.prev;
      }
    }
    size--;
  }

  void deleteAll(Station value) {
    Node? current = head;

    while (current != null) {
      if (current.data == value) {
        if (current.prev != null) {
          current.prev!.next = current.next;
        } else {
          head = current.next;
        }

        if (current.next != null) {
          current.next!.prev = current.prev;
        } else {
          tail = current.prev;
        }
        size--;
      }

      current = current.next;
    }
  }

  void deleteAllNodes() {
    head = null;
    tail = null;
    size = 0;
  }

  void editAtIndex(int index, Station newData) {
    if (head == null || index < 0 || index >= size) {
      return;
    }

    Node? current = head;
    while (current != null && current.index != index) {
      current = current.next;
    }

    if (current != null) {
      current.data = newData;
    }
  }

  Station? getAtIndex(int index) {
    if (head == null || index < 0 || index >= size) {
      return null;
    }

    Node? current = head;
    while (current != null && current.index != index) {
      current = current.next;
    }

    if (current != null) {
      return current.data;
    } else {
      return null;
    }
  }

  int getSize() {
    return size;
  }

  // void displayList() {
  //   Node? current = head;
  //   while (current != null) {
  //     InputStop();
  //     // print(current.data);
  //     current = current.next;
  //   }
  // }
}

IndexedLinkedList? selectedStations;

