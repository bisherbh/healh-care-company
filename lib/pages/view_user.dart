// import 'package:flutter/material.dart';
// import 'package:graduation_project_draft/providers/user.dart';
// import 'package:provider/provider.dart';
//
// import '../../objects/patient.dart';
// import '../list_of_eforms.dart';
//
// class ViewUser extends StatelessWidget {
//   const ViewUser({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     Patient user = Patient(
//         name: "Aban",
//         email: "cus0111",
//         password: "0111",
//         userType: "cus",
//         phoneNumber: "0795777885",
//         address: 'Amman, Jordan');
//     Provider.of<ListOfUsers>(context, listen: false).addUser(user);
//     print(Provider.of<ListOfUsers>(context, listen: false).listOfUsers[0].name);
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0.0,
//         backgroundColor: Color(0xff059DC0),
//         centerTitle: true,
//         toolbarHeight: MediaQuery.of(context).size.height * 0.1,
//         leading: IconButton(
//             icon: const Icon(Icons.arrow_back_ios_new,
//                 color: Colors.white, size: 40),
//             onPressed: () {
//               Navigator.pop(context);
//             }),
//         title: const Text(
//           "View User",
//           style: TextStyle(color: Color(0xffBCECE0), fontSize: 35),
//         ),
//       ),
//       body: ViewUserPage(),
//     );
//   }
// }
//
// class ViewUserPage extends StatelessWidget {
//   const ViewUserPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: <Color>[
//               Color(0xff6efaee),
//               Color(0xff5fe5e2),
//               Color(0xff53d0d4),
//               Color(0xff49bbc5),
//               Color(0xff42a6b5),
//               Color(0xff3d92a4),
//               Color(0xff387f91),
//               Color(0xff346c7f),
//               Color(0xff2f5a6b),
//               Color(0xff2a4858),
//             ],
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(14.0),
//           child: Form(
//             child: ListView(
//               children: [
//                 TextFormField(
//                   readOnly: true,
//                   initialValue: Provider.of<ListOfUsers>(context, listen: false)
//                       .listOfUsers[0]
//                       .name,
//                   decoration: InputDecoration(labelText: 'Name: '),
//                 ),
//                 TextFormField(
//                   readOnly: true,
//                   decoration: InputDecoration(labelText: 'E-mail: '),
//                 ),
//                 TextFormField(
//                   readOnly: true,
//                   initialValue: Provider.of<ListOfUsers>(context, listen: false)
//                       .listOfUsers[0]
//                       .phoneNumber,
//                   decoration: InputDecoration(labelText: 'Phone Number: '),
//                 ),
//                 TextFormField(
//                   readOnly: true,
//                   decoration: InputDecoration(labelText: 'Address: '),
//                 ),
//                 SizedBox(height: 50),
//                 ElevatedButton(
//                   style: ButtonStyle(
//                     backgroundColor:
//                     MaterialStateProperty.all(Color(0xff18978F),),
//                   ),
//                   child: Text(
//                     'View e-Forms',
//                     style: TextStyle(color: Color(0xffBCECE0), fontSize: 16),
//                   ),
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => ListOfeForms()));
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // body:  {Consumer<ListOfUsers>(builder: (context, instance, child)
// // return Text(instance.listOfUsers[0].userType);},

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../objects/customer.dart';
import '../providers/currentPatient.dart';
import '../providers/currentUser.dart';
import '../providers/eFormsList.dart';
import 'filled_e_form.dart';
import 'list_of_eforms.dart';

class ViewPatientInfo extends StatelessWidget {
  const ViewPatientInfo({Key? key}) : super(key: key);

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
              Provider.of<EFormsList>(context, listen: false)
                  .listOfEforms
                  .clear();
              Navigator.pop(context);
            }),
        title: const Text(
          "Patient Info",
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
  String? name;
  String? address;
  String? userType;
  String? age;
  String? phoneNumber;

  Widget _buildUserName() {
    return TextFormField(
      initialValue:
          Provider.of<CurrentPatient>(context, listen: false).object.name,
      readOnly: true,
      decoration: InputDecoration(labelText: 'Name', border: InputBorder.none),
    );
  }

  Widget _buildAddress() {
    return TextFormField(
      initialValue:
          Provider.of<CurrentPatient>(context, listen: false).object.address,
      readOnly: true,
      decoration: InputDecoration(labelText: 'Address'),
    );
  }

  Widget _buildAge() {
    return TextFormField(
      initialValue:
          Provider.of<CurrentPatient>(context, listen: false).object.age,
      readOnly: true,
      decoration: InputDecoration(labelText: 'Age'),
    );
  }

  Widget _buildUserType() {
    return TextFormField(
      initialValue:
          Provider.of<CurrentPatient>(context, listen: false).object.userType,
      readOnly: true,
      decoration:
          InputDecoration(labelText: 'User Type', border: InputBorder.none),
    );
  }

  Widget _buildPhoneNumber() {
    return TextFormField(
      initialValue: Provider.of<CurrentPatient>(context, listen: false)
          .object
          .phoneNumber,
      readOnly: true,
      decoration: InputDecoration(labelText: 'Phone Number'),
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
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildUserName(),
                  _buildUserType(),
                  _buildAddress(),
                  _buildAge(),
                  _buildPhoneNumber(),
                  // ListOfEforms(),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color(0xff18978F),
                      ),
                    ),
                    child: Text(
                      'View E-Forms',
                      style: TextStyle(color: Color(0xffBCECE0), fontSize: 16),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListOfeForms(),
                          ));
                    },
                  ),
                  SizedBox(
                    height: 600,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//
// class ListOfEforms extends StatefulWidget {
//   const ListOfEforms({Key? key}) : super(key: key);
//
//   @override
//   _ListOfEformsState createState() => _ListOfEformsState();
// }
//
// class _ListOfEformsState extends State<ListOfEforms> {
//   @override
//   Widget build(BuildContext context) {
//     print(Provider.of<EFormsList>(context).listOfEforms.length);
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       itemBuilder: (context, index) {
//         return AddedForm(
//             customer: Provider.of<EFormsList>(context, listen: false)
//                 .listOfEforms[index]);
//         // Text(snapshot.data.toString());
//       },
//       itemCount:
//           Provider.of<EFormsList>(context, listen: false).listOfEforms.length,
//     );
//   }
// }
//
// class AddedForm extends StatefulWidget {
//   AddedForm({required this.customer, Key? key}) : super(key: key);
//   Customer customer;
//
//   @override
//   _AddedFormState createState() => _AddedFormState();
// }
//
// class _AddedFormState extends State<AddedForm> {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       // color: Colors.blueGrey.shade200,
//       elevation: 5.0,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(primary: Colors.blueGrey.shade200),
//         onPressed: () {
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context) => FilledEFormPage()));
//
//           ///should to be changed
//         },
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             RichText(
//               overflow: TextOverflow.ellipsis,
//               maxLines: 1,
//               text: TextSpan(
//                 text: 'E-Form Date: ',
//                 style:
//                     TextStyle(color: Colors.blueGrey.shade800, fontSize: 16.0),
//                 children: [
//                   TextSpan(style: const TextStyle(fontWeight: FontWeight.bold)),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 5.0,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
