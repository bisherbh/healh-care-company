import 'package:sample_app/objects/patient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Lab {
  String name;
  String userType;
  String city;
  String address;
  String openHours;
  String phoneNumber;

  Lab({
    required this.name,
    required this.userType,
    required this.city,
    required this.address,
    required this.openHours,
    required this.phoneNumber,
  });

  factory Lab.fromMap(Map<String, dynamic>? map) {
    return Lab(
      name: map?['name'],
      userType: map?['userType'],
      city: map?['city'],
      address: map?['address'],
      openHours: map?['openHours'],
      phoneNumber: map?['phoneNumber'],
    );
  }

  factory Lab.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Lab(
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
