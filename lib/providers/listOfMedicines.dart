import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../objects/medicine.dart';

class ListOfMedicines extends ChangeNotifier {
  List<Medicine> _listOfMedicines = [];

  List<Medicine> get listOfMedicines {
    // notifyListeners();
    return _listOfMedicines;
  }

  void addMedicine(Medicine medicine) {
    _listOfMedicines.add(medicine);
    notifyListeners();
  }

  void getFromDB() async {
    final db = FirebaseFirestore.instance;

    final docRef = db.collection("medicines");

    await docRef.get().then((value) {
      final list = value.docs.map((doc) => doc.data()).toList();
      list.forEach((element) {
        _listOfMedicines.add(Medicine.fromMap(element));
      });
    });
  }

  void removeMedicine(Medicine medicine) {
    _listOfMedicines.remove(medicine);
    notifyListeners();
  }

  void editMedicine(String name) {
    //takes the medicine and edit info--> maybe will be deleted
  }
}
