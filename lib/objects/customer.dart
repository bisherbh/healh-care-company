import 'package:graduation_project_draft/objects/patient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  String name;
  String userType;
  String address;
  String age;
  String phoneNumber;

  Customer({
    required this.name,
    required this.userType,
    required this.address,
    required this.age,
    required this.phoneNumber,
  });

  factory Customer.fromMap(Map<String, dynamic>? map) {
    return Customer(
      name: map?['name'],
      userType: map?['userType'],
      address: map?['address'],
      phoneNumber: map?['phoneNumber'],
      age: map?['age'],
    );
  }

  factory Customer.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Customer(
      name: data?['name'],
      userType: data?['userType'],
      address: data?['address'],
      age: data?['age'],
      phoneNumber: data?['phoneNumber'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (userType != null) "userType": userType,
      if (address != null) "address": address,
      if (age != null) "age": age,
      if (phoneNumber != null) "phoneNumber": phoneNumber,
    };
  }

  @override
  String toString() {
    return '$name';
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Customer && other.name == name;
  }

  @override
  int get hashCode => Object.hash(userType, name);

  // String getUserName() {
  //   return name;
  // }
}
