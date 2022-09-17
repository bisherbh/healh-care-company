import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sample_app/pages/view_user.dart';

import '../objects/customer.dart';
import '../objects/e_form.dart';

class EFormsList extends ChangeNotifier {
  List listOfEforms = [];
  List listOfEforms2 = [];
  var currentIndex;

  void getFromDB(Customer customer) async {
    final db = FirebaseFirestore.instance;
    final docRef =
        db.collection("eForms").where("patientId", isEqualTo: customer.name);

    await docRef.get().then((value) {
      final list = value.docs.map((doc) => doc.data()).toList();
      list.forEach((element) {
        listOfEforms.add(EForm.fromMap(element));

        print(" length: ${listOfEforms.length}");
      });
      listOfEforms.forEach((val){
        if (listOfEforms2.contains(val)) {
          print("Duplicate in List= ${val}");
        } else {
          listOfEforms2.add(val);
        }
      });
    });
    print(listOfEforms2);
  }
}
