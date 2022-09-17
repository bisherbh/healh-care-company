import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/currentUser.dart';
import '../search_user.dart';
import 'package:sample_app/providers/eFormsList.dart';

import 'edit_pharmacy_info.dart';

class PharmacyHomePage extends StatelessWidget {
  const PharmacyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xff059DC0),
        centerTitle: false,
        automaticallyImplyLeading: false,
        toolbarHeight: MediaQuery.of(context).size.height * 0.2,
        title: Text(
          "Welcome \n ${Provider.of<CurrentUser>(context).object.name}",
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
      body: Container(
        child: PharmacyBody(),
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
}

class PharmacyBody extends StatelessWidget {
  const PharmacyBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 25,
      mainAxisSpacing: 7,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchUser()));
            },
            style: TextButton.styleFrom(
              fixedSize: Size(MediaQuery.of(context).size.width * 0.2,
                  MediaQuery.of(context).size.width * 0.2),
            ),
            child: Container(
              child: Center(
                child: Text("View Patient",
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
          padding: const EdgeInsets.all(5.0),
          child: TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditPharmacyInfo()));
            },
            style: TextButton.styleFrom(
              fixedSize: Size(MediaQuery.of(context).size.width * 0.2,
                  MediaQuery.of(context).size.width * 0.2),
            ),
            child: Container(
              child: Center(
                child: Text("Edit Account Info",
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
    );
  }
}
