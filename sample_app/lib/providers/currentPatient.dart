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

class CurrentPatient extends ChangeNotifier {
  // User? currentUser;
  var object;
}
