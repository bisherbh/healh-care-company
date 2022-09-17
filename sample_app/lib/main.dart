import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sample_app/providers/allPatients.dart';
import 'package:sample_app/providers/currentPatient.dart';
import 'package:sample_app/providers/currentUser.dart';
import 'package:sample_app/providers/eFormsList.dart';
import 'package:sample_app/providers/firebaseInstance.dart';
import 'package:sample_app/providers/listOfMedicines.dart';
import 'package:sample_app/providers/medicines_in_cart.dart';
import 'package:sample_app/providers/user.dart';
import 'package:sample_app/utility/db_connection.dart';
import 'package:sample_app/pages/admin/adminpage.dart';
import 'package:sample_app/pages/doctor/doctor_homepage.dart';
import 'package:sample_app/pages/login/login.dart';
import 'package:provider/provider.dart';
import 'package:sample_app/pages/lab/labpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'objects/medicine.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final instance = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //   email: "aaaaj@gmail.com",
  //   password: "pswdweee@0S",
  // );

//   final db = FirebaseFirestore.instance;
//   final ref = db.collection("medicines").withConverter(
//         fromFirestore: Medicine.fromFirestore,
//         toFirestore: (Medicine medicine, _) => medicine.toFirestore(),
//       );
// //Medicine(name: "mebo",description: "Cream for skin burns", scientificName: "Sitosterol",group: "steroid",availableAs: "Cream",doseForAdults: "On Demand",doseForChildren: "On Demand",imageLink: "no image",price: 4.5,covered: true,discount: 0.2)
//   await ref.add(Medicine(
//       name: "mebo",
//       description: "Cream for skin burns",
//       scientificName: "Sitosterol",
//       group: "steroid",
//       availableAs: "Cream",
//       doseForAdults: "On Demand",
//       doseForChildren: "On Demand",
//       imageLink: "no image",
//       price: 4.5,
//       covered: true,
//       discount: 0.2));
//
//   final docSnap = await ref.get();
//   docSnap.docs.forEach((element) {
//     final medicine = element.data(); // Convert to City object
//     if (medicine != null) {
//       print(medicine.name);
//     } else {
//       print("No such document.");
//     }
//   });

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ListOfUsers()),
      ChangeNotifierProvider(create: (context) => ListOfMedicines()),
      ChangeNotifierProvider(create: (context) => FireBaseInstance(instance)),
      ChangeNotifierProvider(create: (context) => MedicinesInCart()),
      ChangeNotifierProvider(create: (context) => CurrentUser()),
      ChangeNotifierProvider(create: (context) => AllPatients()),
      ChangeNotifierProvider(create: (context) => CurrentPatient()),
      ChangeNotifierProvider(create: (context) => EFormsList()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    ),
  ));
}
