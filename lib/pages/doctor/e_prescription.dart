import 'dart:js_util';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'package:graduation_project_draft/pages/doctor/e_form.dart';
import 'package:graduation_project_draft/utility/globals.dart';
import 'package:graduation_project_draft/objects/e_form.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

import '../../objects/medicine.dart';
import '../../providers/listOfMedicines.dart';
import '../../providers/medicines_in_cart.dart';
import '../../utility/db_connection.dart';
import '../../objects/e_prescription.dart';

class EPrescription extends StatefulWidget {
  const EPrescription({Key? key}) : super(key: key);

  @override
  State<EPrescription> createState() => _EPrescriptionState();
}

class _EPrescriptionState extends State<EPrescription> {
  List newList = [];

  // @override
  // initState() {
  //   medicinesList = Provider.of<ListOfMedicines>(context).listOfMedicines;
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    List medicinesList = Provider.of<ListOfMedicines>(context).listOfMedicines;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xff059DC0),
        // The search area here
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search...',
                  border: InputBorder.none),
              onChanged: (text) {
                medicinesList =
                    Provider.of<MedicinesInCart>(context, listen: false)
                        .medicinesincart
                        .where((element) =>
                            element.name.contains(text) ||
                            element.scientificName.contains(text)) as List;
              },
            ),
          ),
        ),
      ),
      body: Container(
        child: MedicinesListWidget(medicinesList),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Color(0xff6efaee),
              Color(0xff5fe5e2),
              Color(0xff53d0d4),
              Color(0xff49bbc5),
              Color(0xff42a6b5),
              Color(0xff3d92a4),
              Color(0xff387f91),
              Color(0xff346c7f),
              Color(0xff2f5a6b),
              Color(0xff2a4858),
            ],
          ),
        ),
      ),
    );
  }

  // Widget filteredMedicines() {
  //   return FutureBuilder(
  //     initialData: [],
  //     builder: (context, AsyncSnapshot snapshot) {
  //       if (snapshot.connectionState == ConnectionState.none ||
  //           snapshot.hasData == null) {
  //         return CircularProgressIndicator();
  //       } else
  //         return ListView.builder(
  //           itemBuilder: (context, index) {
  //             return Item(medicine: Medicine.fromMap(snapshot.data[index]));
  //             // Text(snapshot.data.toString());
  //           },
  //           itemCount: snapshot.data.length,
  //         );
  //     },
  //     future: listOfMedicines(),
  //   );
  // }

  Widget MedicinesListWidget(List list) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Item(medicine: list[index]);
      },
      itemCount: list.length,
    );
  }
}

class Item extends StatefulWidget {
  Item({required this.medicine, Key? key}) : super(key: key);

  Medicine medicine;

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1),
      child: Card(
        // color: Colors.blueGrey.shade200,
        elevation: 5.0,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.blueGrey.shade200),
          onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(widget.medicine.name),
                  content: Column(children: [
                    Text("Description: " + widget.medicine.description),
                    Text("Available As: " + widget.medicine.availableAs),
                    Text("Scientific Name: " + widget.medicine.scientificName),
                    Text("Group: " + widget.medicine.group),
                    Text("Dose For Adults: " + widget.medicine.doseForAdults),
                    Text("Dose for Children: " +
                        widget.medicine.doseForChildren),
                    if (widget.medicine.covered) ...[
                      Text(
                        "Covered: Yes",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("Discount: " + widget.medicine.discount.toString()),
                    ] else ...[
                      Text(
                        'Covered: No',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                    Text("Price: " + widget.medicine.price.toString() + "JD"),
                  ]),
                  scrollable: true,
                );
              }),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              // Image(
              //   height: 80,
              //   width: 80,
              //   image: NetworkImage(widget.medicine.imageLink),
              // ),
              RichText(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                text: TextSpan(
                    text: 'Name: ',
                    style: TextStyle(
                        color: Colors.blueGrey.shade800, fontSize: 16.0),
                    children: [
                      TextSpan(
                          text: widget.medicine.name,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ]),
              ),
              RichText(
                maxLines: 1,
                text: TextSpan(
                  text: 'Covered: ',
                  style: TextStyle(
                      color: Colors.blueGrey.shade800, fontSize: 16.0),
                  children: [
                    if (widget.medicine.covered) ...[
                      TextSpan(
                          text: 'Yes',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ] else ...[
                      TextSpan(
                          text: 'No',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ]
                  ],
                ),
              ),
              RichText(
                maxLines: 1,
                text: TextSpan(
                  text: 'Price: ' r"$",
                  style: TextStyle(
                      color: Colors.blueGrey.shade800, fontSize: 16.0),
                  children: [
                    TextSpan(
                        text: widget.medicine.price.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              RichText(
                maxLines: 1,
                text: TextSpan(
                  text: 'Discount:',
                  style: TextStyle(
                      color: Colors.blueGrey.shade800, fontSize: 16.0),
                  children: [
                    if (widget.medicine.covered) ...[
                      TextSpan(
                        text: widget.medicine.discount.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ] else ...[
                      TextSpan(
                        text: 'Not Covered',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ]
                  ],
                ),
              ),
              Container(
                height: 21,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    primary: Color(0xff18978F),
                  ),
                  onPressed: () {
                    setState(() {
                      Provider.of<MedicinesInCart>(context)
                          .addMedicine(widget.medicine);
                    });
                    // print(Provider.of<MedicinesInCart>(context,listen: false).medicinesincart);
                  },
                  child: const Text(
                    'Add to Cart',
                    style: TextStyle(
                      color: Color(0xffBCECE0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}