import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sample_app/pages/admin/search_user.dart';
import 'package:sample_app/providers/currentUser.dart';
import 'package:provider/provider.dart';
import '../login/login.dart';
import '../search_user.dart';
import '../view_doctors_list.dart';
import 'package:sample_app/providers/eFormsList.dart';

import '../view_lab_list.dart';
import '../view_pharmacy_list.dart';
import '../view_user.dart';
import 'create_user.dart';
import 'edit_medicines_list.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);
  final String currentUserName = "Admin";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xff059DC0),
        automaticallyImplyLeading: false,
        centerTitle: false,
        toolbarHeight: MediaQuery.of(context).size.height * 0.2,
        title: Text(
          "Welcome \n $currentUserName",
          // textAlign: TextAlign.start,
          style: const TextStyle(color: Color(0xffBCECE0), fontSize: 45),
        ),
        actions: [
          TextButton(
            style: ButtonStyle(
              alignment: Alignment.topRight,
            ),
            child: const Text(
              "Log Out",
              style: TextStyle(color: Color(0xffBCECE0), fontSize: 20),
            ),
            onPressed: () {
              Provider.of<EFormsList>(context, listen: false).listOfEforms.clear();
              Provider.of<EFormsList>(context, listen: false).listOfEforms2.clear();
              Provider.of<CurrentUser>(context, listen: false).logOut();
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          )
        ],
      ),
      body: AdminBody(),
    );
  }
}

class AdminBody extends StatelessWidget {
  AdminBody({Key? key}) : super(key: key);

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
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 5,
        children: [
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: TextButton(
              onPressed: () async {

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchUser()));
              },
              style: TextButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width * 0.2,
                    MediaQuery.of(context).size.width * 0.2),
              ),
              child: Container(
                child: Center(
                  child: Text("View Patients",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      )),
                ),
                color: Color(0xff18978F),
                height: MediaQuery.of(context).size.width * 0.2,
                width: MediaQuery.of(context).size.width * 0.2,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: TextButton(
              onPressed: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ListOfDoctors()));
              },
              style: TextButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width * 0.2,
                    MediaQuery.of(context).size.width * 0.2),
              ),
              child: Container(
                child: Center(
                  child: Text(
                    "View Doctors",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                color: Color(0xff18978F),
                height: MediaQuery.of(context).size.width * 0.2,
                width: MediaQuery.of(context).size.width * 0.2,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: TextButton(
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListOfPharmacies()));
              },
              style: TextButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width * 0.2,
                    MediaQuery.of(context).size.width * 0.2),
              ),
              child: Container(
                child: Center(
                  child: Text("View Pharmacies",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      )),
                ),
                color: Color(0xff18978F),
                height: MediaQuery.of(context).size.width * 0.2,
                width: MediaQuery.of(context).size.width * 0.2,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: TextButton(
              onPressed: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ListOfLabs()));
              },
              style: TextButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width * 0.2,
                    MediaQuery.of(context).size.width * 0.2),
              ),
              child: Container(
                child: Center(
                  child: Text("View Labs",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      )),
                ),
                color: Color(0xff18978F),
                height: MediaQuery.of(context).size.width * 0.2,
                width: MediaQuery.of(context).size.width * 0.2,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditMedicines()));
              },
              style: TextButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width * 0.2,
                    MediaQuery.of(context).size.width * 0.2),
              ),
              child: Container(
                child: Center(
                  child: Text("Edit Medicines List",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      )),
                ),
                color: Color(0xff18978F),
                height: MediaQuery.of(context).size.width * 0.2,
                width: MediaQuery.of(context).size.width * 0.2,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateUser()));
              },
              style: TextButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width * 0.2,
                    MediaQuery.of(context).size.width * 0.2),
              ),
              child: Container(
                child: Center(
                  child: Text("Create User",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      )),
                ),
                color: Color(0xff18978F),
                height: MediaQuery.of(context).size.width * 0.2,
                width: MediaQuery.of(context).size.width * 0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
