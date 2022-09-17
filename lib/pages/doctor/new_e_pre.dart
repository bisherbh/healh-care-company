import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../objects/medicine.dart';
import '../../providers/listOfMedicines.dart';
import '../../providers/medicines_in_cart.dart';
import '../admin/new_medicine.dart';

class EditMed extends StatefulWidget {
  const EditMed({Key? key}) : super(key: key);

  @override
  State<EditMed> createState() => _EditMedState();
}

class _EditMedState extends State<EditMed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xff059DC0),
        title: const Text(
          "Medicines List",
          style: TextStyle(color: Color(0xffBCECE0), fontSize: 35),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: StudentSearch());
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: MedicinesList(),
    );
  }
}

class MedicinesList extends StatefulWidget {
  const MedicinesList({Key? key}) : super(key: key);

  @override
  _MedicinesListState createState() => _MedicinesListState();
}

class _MedicinesListState extends State<MedicinesList> {
  Future<List> listOfMedicines() async {
    final db = FirebaseFirestore.instance;

    final docRef = db.collection("medicines");

    QuerySnapshot querySnapshot = await docRef.get();

    final list = querySnapshot.docs.map((doc) => doc.data()).toList();
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: FutureBuilder(
          initialData: [],
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.none ||
                snapshot.hasData == null) {
              return CircularProgressIndicator();
            } else {
              return ListView.builder(
                itemBuilder: (context, index) {
                  if (index == snapshot.data.length) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 195),
                    );
                  } else {
                    return Item(
                        medicine: Medicine.fromMap(snapshot.data[index]));
                    // Text(snapshot.data.toString());
                  }
                },

                // itemBuilder: (context, index) {
                //   return Item(medicine: Medicine.fromJson(snapshot.data[index]));
                //   // Text(snapshot.data.toString());
                // },
                itemCount: snapshot.data.length + 1,
              );
            }
          },
          future: listOfMedicines(),
        ));
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
                  text: 'Discount: ',
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff059DC0),
                ),
                onPressed: () {
                  setState(() {
                    Provider.of<MedicinesInCart>(context, listen: false)
                        .addMedicine(widget.medicine);
                  });
                  Navigator.pop(context);
                },
                child: const Text(
                  'Add to cart',
                  style: TextStyle(
                    color: Color(0xffBCECE0),
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

class StudentSearch extends SearchDelegate<Medicine> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(Icons.navigate_before),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final listItems = query.isEmpty
        ? Provider.of<ListOfMedicines>(context).listOfMedicines
        : Provider.of<ListOfMedicines>(context)
            .listOfMedicines
            .where((element) => element.name
                .toLowerCase()
                .contains(query.toLowerCase().toString()))
            .toList();

    // final listItems = ();
    print(listItems.length);
    return listItems.isEmpty
        ? Center(child: Text("No Data Found!"))
        : ListView.builder(
            itemCount: listItems.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.1),
                child: Card(
                  // color: Colors.blueGrey.shade200,
                  elevation: 5.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blueGrey.shade200),
                    onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(listItems[index].name),
                            content: Column(children: [
                              Text("Description: " +
                                  listItems[index].description),
                              Text("Available As: " +
                                  listItems[index].availableAs),
                              Text("Scientific Name: " +
                                  listItems[index].scientificName),
                              Text("Group: " + listItems[index].group),
                              Text("Dose For Adults: " +
                                  listItems[index].doseForAdults),
                              Text("Dose for Children: " +
                                  listItems[index].doseForChildren),
                              if (listItems[index].covered) ...[
                                Text(
                                  "Covered: Yes",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text("Discount: " +
                                    listItems[index].discount.toString()),
                              ] else ...[
                                Text(
                                  'Covered: No',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                              Text("Price: " +
                                  listItems[index].price.toString() +
                                  "JD"),
                            ]),
                            scrollable: true,
                          );
                        }),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        RichText(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          text: TextSpan(
                              text: 'Name: ',
                              style: TextStyle(
                                  color: Colors.blueGrey.shade800,
                                  fontSize: 16.0),
                              children: [
                                TextSpan(
                                    text: listItems[index].name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ]),
                        ),
                        RichText(
                          maxLines: 1,
                          text: TextSpan(
                            text: 'Covered: ',
                            style: TextStyle(
                                color: Colors.blueGrey.shade800,
                                fontSize: 16.0),
                            children: [
                              if (listItems[index].covered) ...[
                                TextSpan(
                                    text: 'Yes',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ] else ...[
                                TextSpan(
                                    text: 'No',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ]
                            ],
                          ),
                        ),
                        RichText(
                          maxLines: 1,
                          text: TextSpan(
                            text: 'Price: ' r"$",
                            style: TextStyle(
                                color: Colors.blueGrey.shade800,
                                fontSize: 16.0),
                            children: [
                              TextSpan(
                                  text: listItems[index].price.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        RichText(
                          maxLines: 1,
                          text: TextSpan(
                            text: 'Discount: ',
                            style: TextStyle(
                                color: Colors.blueGrey.shade800,
                                fontSize: 16.0),
                            children: [
                              if (listItems[index].covered) ...[
                                TextSpan(
                                  text: listItems[index].discount.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ] else ...[
                                TextSpan(
                                  text: 'Not Covered',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ]
                            ],
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff059DC0),
                          ),
                          onPressed: () {
                            Provider.of<MedicinesInCart>(context, listen: false)
                                .addMedicine(listItems[index]);
                          },
                          child: const Text(
                            'Add to cart',
                            style: TextStyle(
                              color: Color(0xffBCECE0),
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
            });
  }
}
