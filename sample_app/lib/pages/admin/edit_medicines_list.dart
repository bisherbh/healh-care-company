import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sample_app/pages/admin/adminpage.dart';
import 'package:provider/provider.dart';
import '../../objects/medicine.dart';
import 'new_medicine.dart';

class EditMedicines extends StatefulWidget {
  const EditMedicines({Key? key}) : super(key: key);

  @override
  State<EditMedicines> createState() => _EditMedicinesState();
}

class _EditMedicinesState extends State<EditMedicines> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xff059DC0),
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new,
                color: Colors.white, size: 40),
            onPressed: () {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context)=>AdminPage()), ModalRoute.withName("/"));
            }),
        title: const Text(
          "Edit Medicines",
          style: TextStyle(color: Color(0xffBCECE0), fontSize: 35),
        ),
      ),
      body: MedicinesListWidget(),
    );
  }
}

class MedicinesListWidget extends StatefulWidget {
  const MedicinesListWidget({Key? key}) : super(key: key);

  @override
  _MedicinesListWidgetState createState() => _MedicinesListWidgetState();
}

class _MedicinesListWidgetState extends State<MedicinesListWidget> {
  Future<List> listOfMedicines() async {
    final db = FirebaseFirestore.instance;

    final docRef = db.collection("medicines");

    QuerySnapshot querySnapshot = await docRef.get();
    setState(() {

    });
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
              return Column(children: [
                  Expanded(
                    child: ListView.builder(

                    itemBuilder: (context, index) {

                return Item(
                      medicine: Medicine.fromMap(snapshot.data[index]));
                // Text(snapshot.data.toString());

              },

            // itemBuilder: (context, index) {
            //   return Item(medicine: Medicine.fromJson(snapshot.data[index]));
            //   // Text(snapshot.data.toString());
            // },
            itemCount: snapshot.data.length,
            ),
                  ),
              Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 8, horizontal: 195),
            child: OutlinedButton.icon(
            style: ButtonStyle(
            padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(
            vertical: MediaQuery.of(context)
                .size
                .height *
            0.01,
            horizontal:
            MediaQuery.of(context).size.width *
            0.3))),
            onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) => NewMedicine(),
            ),
            ),
            icon: const Icon(
            Icons.add,
            size: 18.0,
            color: Colors.black,
            ),
            label: Text(
            'Add New Medicine',
            style:
            TextStyle(fontSize: 12, color: Color(0xffBCECE0)),
            ),
            ),
            ),
              ],);
                
            
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
                style: ElevatedButton.styleFrom(primary: Colors.red),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text(
                        "Are You Sure?",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            color: Color(0xff18978F),
                            padding: const EdgeInsets.all(14),
                            child: const Text(
                              "No",
                              style: TextStyle(
                                color: Color(0xffBCECE0),
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            final db = await FirebaseFirestore.instance;
                            final elementsToDelete = await db
                                .collection('medicines')
                                .where('name', isEqualTo: widget.medicine.name)
                                .get();
                              elementsToDelete.docs.forEach((element) {
                                element.reference.delete();
                            });

                            Navigator.of(context).pop();
                          },
                          child: Container(
                            color: Color(0xff18978F),
                            padding: const EdgeInsets.all(14),
                            child: const Text(
                              "Yes",
                              style: TextStyle(
                                color: Color(0xffBCECE0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ); // deleteData(index);
                },
                child: const Text(
                  'Delete',
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
