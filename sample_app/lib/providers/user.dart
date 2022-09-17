import 'dart:collection';

import 'package:flutter/cupertino.dart';

import '../objects/patient.dart';

class ListOfUsers extends ChangeNotifier {
  final List<Patient> _listOfUsers = [];

  List<Patient> get listOfUsers {
    notifyListeners();
    return _listOfUsers;
  }

  void addUser(Patient user) {
    listOfUsers.add(user);
    notifyListeners();
  }

  void removeUser(Patient user) {
    listOfUsers.remove(user);
    notifyListeners();
  }
}
