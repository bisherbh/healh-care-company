import 'package:graduation_project_draft/objects/patient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Doctor {
  String name;
  String userType;
  String specialty;
  String city;
  String address;
  String openHours;
  String phoneNumber;

  Doctor({
    required this.name,
    required this.userType,
    required this.specialty,
    required this.city,
    required this.address,
    required this.openHours,
    required this.phoneNumber,
  });

  factory Doctor.fromMap(Map<String, dynamic>? map) {
    return Doctor(
      name: map?['name'],
      userType: map?['userType'],
      specialty: map?['specialty'],
      city: map?['city'],
      address: map?['address'],
      openHours: map?['openHours'],
      phoneNumber: map?['phoneNumber'],
    );
  }

  factory Doctor.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Doctor(
      name: data?['name'],
      userType: data?['userType'],
      specialty: data?['specialty'],
      city: data?['city'],
      address: data?['address'],
      openHours: data?['openHours'],
      phoneNumber: data?['phoneNumber'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (userType != null) "userType": userType,
      if (specialty != null) "specialty": specialty,
      if (city != null) "city": city,
      if (address != null) "address": address,
      if (openHours != null) "openHours": openHours,
      if (phoneNumber != null) "phoneNumber": phoneNumber,
    };
  }
}
