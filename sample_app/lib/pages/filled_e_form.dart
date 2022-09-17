import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sample_app/providers/currentUser.dart';
import 'package:sample_app/providers/medicines_in_cart.dart';
import 'package:sample_app/utility/globals.dart';
import 'package:sample_app/objects/e_form.dart';
import 'package:provider/provider.dart';
import '../../objects/customer.dart';
import '../../objects/medicine.dart';
// import 'e_prescription.dart';
import '../../providers/allPatients.dart';
import '../../providers/currentPatient.dart';
import '../../utility/db_connection.dart';
import '../providers/eFormsList.dart';
// import '../../objects/e_prescription.dart';

class FilledEFormPage extends StatefulWidget {
  const FilledEFormPage({Key? key}) : super(key: key);
  @override
  State<FilledEFormPage> createState() => _FilledEFormPageState();
}

class _FilledEFormPageState extends State<FilledEFormPage> {
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
          "E-Form",
          style: TextStyle(color: Color(0xffBCECE0), fontSize: 35),
        ),
      ),
      body: FormWidget(),
    );
  }
}

class FormWidget extends StatefulWidget {
  const FormWidget({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<FormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildDate() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Date', border: InputBorder.none),
      readOnly: true,
      initialValue: Provider.of<EFormsList>(context, listen: false)
          .listOfEforms2[
              Provider.of<EFormsList>(context, listen: false).currentIndex]
          .date
          .toString(),
    );
  }

  Widget _buildDoctorId() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: 'Doctor Name:', border: InputBorder.none),
      readOnly: true,
      initialValue: Provider.of<EFormsList>(context, listen: false)
          .listOfEforms2[
              Provider.of<EFormsList>(context, listen: false).currentIndex]
          .doctorId
          .toString(),
    );
  }

  Widget _buildDescription() {
    return TextFormField(
      readOnly: true,
      initialValue: Provider.of<EFormsList>(context, listen: false)
          .listOfEforms2[
              Provider.of<EFormsList>(context, listen: false).currentIndex]
          .description,
      decoration: InputDecoration(labelText: 'Description'),
      maxLines: 7,
    );
  }

  Widget _buildNotes() {
    return TextFormField(
      readOnly: true,
      initialValue: Provider.of<EFormsList>(context, listen: false)
          .listOfEforms2[
              Provider.of<EFormsList>(context, listen: false).currentIndex]
          .notes,
      decoration: InputDecoration(
        labelText: 'Notes',
      ),
      maxLines: 5,
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
          padding:
              const EdgeInsets.symmetric(horizontal: 100.0, vertical: 100.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildDate(),
                  _buildDoctorId(),
                  _buildDescription(),
                  _buildNotes(),
                  SizedBox(height: 25),
                  AddedMedicines(),
                  SizedBox(height: 25),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AddedMedicines extends StatefulWidget {
  const AddedMedicines({Key? key}) : super(key: key);

  @override
  State<AddedMedicines> createState() => _AddedMedicinesState();
}

class _AddedMedicinesState extends State<AddedMedicines> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return AddedItem(
            /*************************/
            medicine: Provider.of<EFormsList>(context, listen: false)
                .listOfEforms2[Provider.of<EFormsList>(context, listen: false)
                    .currentIndex]
                .prescription[index]);
      },
      itemCount: Provider.of<EFormsList>(context, listen: false)
          .listOfEforms2[
              Provider.of<EFormsList>(context, listen: false).currentIndex]
          .prescription
          .length,
    );
  }
}

class AddedItem extends StatefulWidget {
  AddedItem({required this.medicine, Key? key}) : super(key: key);

  Medicine medicine;

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
