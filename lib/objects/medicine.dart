import 'package:cloud_firestore/cloud_firestore.dart';

class Medicine {
  String name;
  String scientificName;
  String description;
  String group;
  String doseForAdults;
  String doseForChildren;
  String availableAs;
  double price;
  bool covered;
  double discount;

  Medicine({
    required this.name,
    required this.description,
    required this.availableAs,
    required this.covered,
    required this.doseForAdults,
    required this.doseForChildren,
    required this.group,
    required this.discount,
    // required this.imageLink,
    required this.price,
    required this.scientificName,
  });

  factory Medicine.fromMap(Map<String, dynamic> map) {
    return Medicine(
      name: map['name'],
      scientificName: map['scientificName'],
      // imageLink: map['imageLink'],
      description: map['description'],
      group: map['group'],
      doseForAdults: map['doseForAdults'],
      doseForChildren: map['doseForChildren'],
      availableAs: map['availableAs'],
      price: map['price'],
      covered: map['covered'],
      discount: map['discount'],
    );
  }

  factory Medicine.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Medicine(
      name: data?['name'],
      scientificName: data?['scientificName'],
      // imageLink: data?['imageLink'],
      description: data?['description'],
      group: data?['group'],
      doseForAdults: data?['doseForAdults'],
      doseForChildren: data?['doseForChildren'],
      availableAs: data?['availableAs'],
      price: data?['price'],
      covered: data?['covered'],
      discount: data?['discount'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (scientificName != null) "scientificName": scientificName,
      if (description != null) "description": description,
      if (group != null) "group": group,
      if (doseForAdults != null) "doseForAdults": doseForAdults,
      if (doseForChildren != null) "doseForChildren": doseForChildren,
      if (availableAs != null) "availableAs": availableAs,
      if (price != null) "price": price,
      if (covered != null) "covered": covered,
      if (discount != null) "discount": discount,
    };
  }
}
