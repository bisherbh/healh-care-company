import 'package:flutter/cupertino.dart';
import '../objects/medicine.dart';
class MedicinesInCart extends ChangeNotifier {
   List<Medicine> _medicinesincart = [];
  List<Medicine> get medicinesincart {
    // notifyListeners();
    return _medicinesincart;
  }
  
  void addMedicine(Medicine medicine) {
    

    _medicinesincart.add(medicine);
    notifyListeners();
  }
  void removeMedicine(Medicine medicine) {
    _medicinesincart.remove(medicine);
    notifyListeners();
  }
}
