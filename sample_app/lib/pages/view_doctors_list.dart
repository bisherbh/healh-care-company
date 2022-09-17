import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../objects/doctor.dart';

class ListOfDoctors extends StatelessWidget {
  ListOfDoctors({Key? key}) : super(key: key);
  // String city="amman";
  // String specialty="dentistry";

  Future<List> listOfDoctors() async {
    final db = FirebaseFirestore.instance;

    final docRef = await db.collection("users").where("userType",isEqualTo: "doctor");

    QuerySnapshot querySnapshot = await docRef.get();

    // Get data from docs and convert map to List
    final list = querySnapshot.docs.map((doc) => doc.data()).toList();
    return list;
  }

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
          "Doctor List",
          style: TextStyle(color: Color(0xffBCECE0), fontSize: 35),
        ),
      ),
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
                    return Item(doctor: Doctor.fromMap(snapshot.data[index]));
                    // Text(snapshot.data.toString());
                  }
                },

                itemCount: snapshot.data.length + 1,
              );
            }
          },
          future: listOfDoctors(),
        ),
      ),
    );
  }
}

class Item extends StatefulWidget {
  Item({required this.doctor, Key? key}) : super(key: key);

  Doctor doctor;

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
                title: Text("Doctor Details"),
                content: Column(
                  children: [
                    Text("Doctor Name: " + widget.doctor.name),
                    Text("Specialty: " + widget.doctor.specialty),
                    Text("City: " + widget.doctor.city),
                    Text("Address: " + widget.doctor.address),
                    Text("Open Hours: " + widget.doctor.openHours),
                    Text("Phone Number: " + widget.doctor.phoneNumber),
                  ],
                ),
                scrollable: true,
              );
            },
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              RichText(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                text: TextSpan(
                  text: 'Doctor Name: ',
                  style: TextStyle(
                      color: Colors.blueGrey.shade800, fontSize: 16.0),
                  children: [
                    TextSpan(
                        text: widget.doctor.name,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              RichText(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                text: TextSpan(
                  text: 'Specialty: ',
                  style: TextStyle(
                      color: Colors.blueGrey.shade800, fontSize: 16.0),
                  children: [
                    TextSpan(
                        text: widget.doctor.specialty,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              RichText(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                text: TextSpan(
                  text: 'City: ',
                  style: TextStyle(
                      color: Colors.blueGrey.shade800, fontSize: 16.0),
                  children: [
                    TextSpan(
                        text: widget.doctor.city,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
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
