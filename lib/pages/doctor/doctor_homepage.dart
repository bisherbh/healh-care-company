import 'package:flutter/material.dart';
import 'package:graduation_project_draft/pages/search_user.dart';
import 'package:graduation_project_draft/providers/eFormsList.dart';
import 'package:graduation_project_draft/providers/listOfMedicines.dart';
import 'package:provider/provider.dart';

import '../../providers/currentUser.dart';
import '../login/login.dart';
import 'e_form.dart';
import 'edit_doctor_info.dart';
import '../view_user.dart';

class DoctorHomePage extends StatelessWidget {
  const DoctorHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ListOfMedicines>(context, listen: false).getFromDB();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xff059DC0),
        automaticallyImplyLeading: false,
        centerTitle: false,
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
      body: DoctorBody(),
    );
  }
}

class DoctorBody extends StatelessWidget {
  const DoctorBody({Key? key}) : super(key: key);

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
        crossAxisSpacing: 25,
        mainAxisSpacing: 7,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EFormPage()));
              },
              style: TextButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width * 0.2,
                    MediaQuery.of(context).size.width * 0.2),
              ),
              child: Container(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "New E-Form",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
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
            padding: const EdgeInsets.all(10.0),
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "View Patient",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
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
            padding: const EdgeInsets.all(10.0),
            child: TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditDoctorInfo()));
              },
              style: TextButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width * 0.2,
                    MediaQuery.of(context).size.width * 0.2),
              ),
              child: Container(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Edit Account Info",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
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
