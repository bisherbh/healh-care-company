import 'package:graduation_project_draft/objects/patient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Pharmacy {
  String name;
  String userType;
  String city;
  String address;
  String openHours;
  String phoneNumber;

  Pharmacy({
    required this.name,
    required this.userType,
    required this.city,
    required this.address,
    required this.openHours,
    required this.phoneNumber,
  });

  factory Pharmacy.fromMap(Map<String, dynamic>? map) {
    return Pharmacy(
      name: map?['name'],
      userType: map?['userType'],
      city: map?['city'],
      address: map?['address'],
      openHours: map?['openHours'],
      phoneNumber: map?['phoneNumber'],
    );
  }

  factory Pharmacy.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Pharmacy(
      name: data?['name'],
      userType: data?['userType'],
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
      if (city != null) "city": city,
      if (address != null) "address": address,
      if (openHours != null) "openHours": openHours,
      if (phoneNumber != null) "phoneNumber": phoneNumber,
    };
  }
}
