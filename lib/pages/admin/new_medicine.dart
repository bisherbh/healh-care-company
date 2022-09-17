import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../objects/medicine.dart';
import 'edit_medicines_list.dart';

class NewMedicine extends StatelessWidget {
  const NewMedicine({Key? key}) : super(key: key);

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
            }),
        title: const Text(
          "Add Medicine",
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String dropdownValue = "Covered:";

  final name = TextEditingController();
  final scientificName = TextEditingController();
  final description = TextEditingController();
  final group = TextEditingController();
  final doseForAdults = TextEditingController();
  final doseForChildren = TextEditingController();
  final availableAs = TextEditingController();
  final price = TextEditingController();
  final discount = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    scientificName.dispose();
    // imageLink.dispose();
    description.dispose();
    group.dispose();
    doseForAdults.dispose();
    doseForChildren.dispose();
    availableAs.dispose();
    price.dispose();
    discount.dispose();
    super.dispose();
  }

  Widget _buildMedicineName() {
    return TextFormField(
      controller: name,
      decoration: InputDecoration(labelText: 'Medicine Name'),
      validator: (String? value) {
        if (value!.isEmpty) {
          return "**Medicine Name is Required";
        } else
          return null;
      },
    );
  }

  Widget _buildScientificName() {
    return TextFormField(
      controller: scientificName,
      decoration: InputDecoration(labelText: 'Scientific Name'),
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildDescription() {
    return TextFormField(
      controller: description,
      decoration: InputDecoration(labelText: 'Description'),
      keyboardType: TextInputType.number,
      validator: (String? value) {
        if (value!.isEmpty) {
          return "**Description is Required";
        } else
          return null;
      },
    );
  }

  Widget _buildGroup() {
    return TextFormField(
      controller: group,
      decoration: InputDecoration(labelText: 'Group'),
    );
  }

  Widget _buildDoseForAdults() {
    return TextFormField(
      controller: doseForAdults,
      decoration: InputDecoration(labelText: 'Dose For Adults'),
    );
  }

  Widget _buildDoseForChildren() {
    return TextFormField(
      controller: doseForChildren,
      decoration: InputDecoration(labelText: 'Dose For Children'),
    );
  }

  Widget _buildAvailableAs() {
    return TextFormField(
      controller: availableAs,
      decoration: InputDecoration(labelText: 'Available As'),
      validator: (String? value) {
        if (value!.isEmpty) {
          return "**Available As is Required";
        } else
          return null;
      },
    );
  }

  Widget _buildPrice() {
    return TextFormField(
      controller: price,
      decoration: InputDecoration(labelText: 'Price'),
      keyboardType: TextInputType.number,
      validator: (String? value) {
        if (value!.isEmpty) {
          return "**Price is Required";
        } else if (!RegExp(r'^\d+(.\d{1,2})?$').hasMatch(value)) {
          return "**Enter Correct Price (Numbers)!";
        } else
          return null;
      },
    );
  }

  Widget _buildCovered() {
    // padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
    return Row(
      children: [
        DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_drop_down_outlined),
          elevation: 16,
          style: const TextStyle(color: Colors.black),
          underline: SizedBox(),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: <String>[
            'Covered:',
            'Yes',
            'No',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDiscount() {
    return TextFormField(
      controller: discount,
      decoration: InputDecoration(labelText: 'Discount'),
      keyboardType: TextInputType.number,
      validator: (String? value) {
        if (value!.isEmpty) {
          return "**Discount is Required";
        } else if (!RegExp(r'^\d+(.\d{1,2})?$').hasMatch(value)) {
          return "**Enter Correct Discount (Numbers)!";
        } else
          return null;
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
          padding: const EdgeInsets.all(14.0),
          child: Form(
            key: _formKey,
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildMedicineName(),
                _buildScientificName(),
                // _buildImageLink(),
                _buildDescription(),
                _buildGroup(),
                _buildDoseForAdults(),
                _buildDoseForChildren(),
                _buildAvailableAs(),
                _buildPrice(),
                _buildCovered(),
                _buildDiscount(),
                SizedBox(height: 50),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Color(0xff18978F),
                    ),
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(color: Color(0xffBCECE0), fontSize: 16),
                  ),
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Check Required fields!!!!")));
                    } else if (_formKey.currentState!.validate()) {
                      final db = await FirebaseFirestore.instance;

                      db.collection("medicines").doc().set(Medicine(
                              name: name.text,
                              description: description.text,
                              availableAs: availableAs.text,
                              doseForAdults: doseForAdults.text,
                              doseForChildren: doseForChildren.text,
                              group: group.text,
                              discount: double.parse(discount.text),
                              // imageLink: imageLink.text,
                              price: double.parse(price.text),
                              scientificName: scientificName.text,
                              covered: (dropdownValue == "Yes") ? true : false)
                          .toFirestore());
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditMedicines()));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
