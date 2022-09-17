import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../objects/customer.dart';


class AllPatients extends ChangeNotifier {

  List<Customer> allCustomers = [];

  List<Customer> allCustomers2 = [];

  void getFromDB() async {
    final db = FirebaseFirestore.instance;

    final docRef =
        db.collection("users").where("userType", isEqualTo: "customer");

    await docRef.get().then((value) {
      final list = value.docs.map((doc) => doc.data()).toList();
      list.forEach((element) {
        allCustomers.add(Customer.fromMap(element));
      });
      allCustomers.forEach((val){
        if (allCustomers2.contains(val)) {
          print("Duplicate in List= ${val}");
        } else {
          allCustomers2.add(val);
        }
      });

    });
   addListener(() {});
    print(allCustomers2);
  }

  // void getList() async {
  //   final db = FirebaseFirestore.instance;
  //   QuerySnapshot querySnapshot = await db
  //       .collection("users")
  //       .where("userType", isEqualTo: "customer")
  //       .get();
  //   // final list = querySnapshot.docs.map((doc) => doc.data()).toList();
  //   // print(list[0]?.name);
  //   final list = querySnapshot.docs;
  //   list.forEach((element) {
  //     final result = (Customer.fromMap(element));
  //   });
  //   // return list;
  //   // print(list[0][name]);
  // }
}
