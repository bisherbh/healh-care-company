import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_draft/providers/medicines_in_cart.dart';
import 'package:graduation_project_draft/objects/e_form.dart';
import 'package:provider/provider.dart';
import '../../objects/customer.dart';
import '../../objects/medicine.dart';
import '../../providers/allPatients.dart';
import '../../providers/currentPatient.dart';
import '../../providers/currentUser.dart';
import 'new_e_pre.dart';

class EFormPage extends StatefulWidget {
  const EFormPage({Key? key}) : super(key: key);

  @override
  State<EFormPage> createState() => _EFormPageState();
}

class _EFormPageState extends State<EFormPage> {
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
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "New E_Form ",
          style: TextStyle(color: Color(0xffBCECE0), fontSize: 35),
        ),
      ),
      body: FormWidget(),
    );
  }
}

class FormWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<FormWidget> {
  // String patientName = "";
  DateTime date = DateTime.now();

  final description = TextEditingController();
  final notes = TextEditingController();

  Future<List<Customer?>> getList(String value) async {
    final db = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await db
        .collection("users")
        .where("userType", isEqualTo: "customer")
        .where("name".contains(value))
        .get();
    final list =
        querySnapshot.docs.map((doc) => doc.data() as Customer?).toList();
    // print(list[0]?.name);
    return list;
    // print(list[0][name]);
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildDate() {
    DateTime now = DateTime.now();
    date = DateTime(now.year, now.month, now.day);
    return TextFormField(
      decoration: InputDecoration(labelText: 'Date', border: InputBorder.none),
      readOnly: true,
      initialValue: date.toString(),
    );
  }

  Widget _buildDescription() {
    return TextFormField(
      // initialValue: "",
      decoration: InputDecoration(labelText: 'Description'),
      maxLines: 7,
      keyboardType: TextInputType.multiline,
      validator: (String? value) {
        if (value!.isEmpty) {
          return "**Description is Required";
        } else
          return null;
      },
      onChanged: (String? value) {
        description.text = value!;
        setState(() {});
      },
    );
  }

  Widget _buildNotes() {
    return TextFormField(
      // initialValue: "",
      decoration: InputDecoration(
        labelText: 'Notes',
      ),
      maxLines: 5,
      keyboardType: TextInputType.multiline,
      onChanged: (String value) {
        notes.text = value;
        setState(() {});
      },
    );
  }

  @override

  Widget build(BuildContext context) {
 
    return Scaffold(
      body: Container(
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100.0),
          child: Form(
            key: _formKey,
            child:
                // SingleChildScrollView(
                //   physics: ScrollPhysics(),
                //   child:
                Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AutocompleteBasicUserExample(),

                _buildDate(),

                _buildDescription(),
                _buildNotes(),
                SizedBox(height: 25),
                OutlinedButton.icon(
      style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.01,
              horizontal: MediaQuery.of(context).size.width * 0.3))),
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditMed(),
        ),
      ),
      icon: const Icon(
        Icons.add,
        size: 18.0,
        color: Colors.black,
      ),
      label: Text(
        'Add To Prescription',
        style: TextStyle(
          fontSize: 12,
          color: Color(0xffBCECE0),
        ),
      ),
    ),
                // SizedBox(height: 50),
                 Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        // physics: NeverScrollableScrollPhysics(),
       
        itemBuilder: (context, index) {
         
         
              return
          AddedItem(
              medicine: Provider.of<MedicinesInCart>(context)
                  .medicinesincart
                  .elementAt(index)
                  );
      
        },
        itemCount: Provider.of<MedicinesInCart>(context).medicinesincart.length,
      ),
    ),
                // SizedBox(height: 50),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Color(0xff18978F),
                    ),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Color(0xffBCECE0), fontSize: 16),
                  ),
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Check Required fields!!!!")));
                    } else if (_formKey.currentState!.validate()) {
                     // final auth = FirebaseAuth.instance.currentUser;
                      final db = FirebaseFirestore.instance;
                      await db.collection("eForms").doc().set((EForm(
                              doctorId: Provider.of<CurrentUser>(context,
                                  listen: false)
                                  .object!
                                  .name,
                              patientId: Provider.of<CurrentPatient>(context,
                                      listen: false)
                                  .object!
                                  .name,
                              description: description.text,
                              notes: notes.text,
                              prescription: Provider.of<MedicinesInCart>(
                                      context,
                                      listen: false)
                                  .medicinesincart,
                              date: null)
                          .toFirestore()));
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      //),
    );

  }

  
  
}

class AddToPrescription extends StatefulWidget {
  const AddToPrescription({Key? key}) : super(key: key);

  @override
  State<AddToPrescription> createState() => _AddToPrescriptionState();
}

class _AddToPrescriptionState extends State<AddToPrescription> {
  @override
  Widget build(BuildContext context) {
    return 
    OutlinedButton.icon(
      style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.01,
              horizontal: MediaQuery.of(context).size.width * 0.3))),
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditMed(),
        ),
      ),
      icon: const Icon(
        Icons.add,
        size: 18.0,
        color: Colors.black,
      ),
      label: Text(
        'Add To Prescription',
        style: TextStyle(
          fontSize: 12,
          color: Color(0xffBCECE0),
        ),
      ),
    );
  }
}
// class AddedMedicines extends StatelessWidget {
//   const AddedMedicines({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }



class AddedItem extends StatefulWidget {
    Medicine medicine;
  AddedItem({required this.medicine, Key? key}) : super(key: key);



  @override
  State<AddedItem> createState() => _AddedItemState();
}

class _AddedItemState extends State<AddedItem> {
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
          onPressed: () =>
              showDialog(
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.red),
                onPressed: () {
                
                    Provider.of<MedicinesInCart>(context, listen: false)
                        .removeMedicine(widget.medicine);
            
                },
                child: const Text('Delete'),
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

class AutocompleteBasicUserExample extends StatelessWidget {
  const AutocompleteBasicUserExample({Key? key}) : super(key: key);
  // static List<Customer> _userOptions = <Customer>[
  //   Customer(
  //       name: 'Alice In wonderland',
  //       userType: "customer",
  //       address: "amman",
  //       age: "19",
  //       phoneNumber: "0795777885"),
  //   Customer(
  //       name: 'Mohammad Omary',
  //       userType: "customer",
  //       address: "amman",
  //       age: "19",
  //       phoneNumber: "0795777885"),
  //   Customer(
  //       name: 'Maha Ismael',
  //       userType: "customer",
  //       address: "amman",
  //       age: "19",
  //       phoneNumber: "0795777885"),
  // ];
  static String _displayStringForOption(Customer option) => option.name;
  @override
  Widget build(BuildContext context) {
    Provider.of<AllPatients>(context).getFromDB();
    return Autocomplete<Customer>(
      initialValue: TextEditingValue(text: "Search User"),
      displayStringForOption: _displayStringForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<Customer>.empty();
        }
        return // _userOptions
            Provider.of<AllPatients>(context, listen: false)
                .allCustomers2
                .where((Customer option) {
          return option.name
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (Customer selection) {
        Provider.of<CurrentPatient>(context, listen: false).object = selection;
        debugPrint('You just selected ${_displayStringForOption(selection)}');
      },
    );
  }
}
