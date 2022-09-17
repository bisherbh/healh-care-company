import 'dart:html';
import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../objects/customer.dart';
import '../objects/doctor.dart';
import '../objects/lab.dart';
import '../objects/pharmacy.dart';
import '../pages/admin/adminpage.dart';
import '../pages/doctor/doctor_homepage.dart';
import '../pages/lab/labpage.dart';
import '../pages/pharmacy/pharmacy_homepage.dart';
import '../pages/user/customer_pages.dart';

// import '../objects/patient.dart';

class CurrentUser extends ChangeNotifier {
  // User? currentUser;

  var object;

  void logOut() {
    final auth = FirebaseAuth.instance;
    auth.signOut();
    object = null;
  }

  void determineUser(BuildContext context) async {
    final db = FirebaseFirestore.instance;
    final auth = FirebaseAuth.instance;
    final user = db.collection("users").doc(auth.currentUser?.uid);
    final userMap = user.get();
    await userMap.then((map) {
      switch (map["userType"]) {
        case "customer":
          object = Customer.fromMap(map.data());
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => UserHomePage()));
          break;
        case "doctor":
          object = Doctor.fromMap(map.data());
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DoctorHomePage()));
          break;
        case "pharmacy":
          object = Pharmacy.fromMap(map.data());
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PharmacyHomePage()));
          break;
        case "admin":
          // object = Admin.fromMap(map.data());
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AdminPage()));
          break;
        case "lab":
          object = Lab.fromMap(map.data());
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LabsPage()));
          break;
      }
    });
  }
}
