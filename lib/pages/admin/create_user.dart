import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:graduation_project_draft/objects/doctor.dart';
import 'package:graduation_project_draft/objects/pharmacy.dart';
import 'package:graduation_project_draft/providers/firebaseInstance.dart';
import 'package:provider/provider.dart';
import '../../objects/customer.dart';
import '../../objects/lab.dart';
import '../login/login.dart';
import 'package:random_password_generator/random_password_generator.dart';

import 'adminpage.dart';

class CreateUser extends StatefulWidget {
  CreateUser({Key? key}) : super(key: key);

  @override
  State<CreateUser> createState() => _CreateUserState();
}

//we need password controller, and provider on create

class _CreateUserState extends State<CreateUser> {
  final greenColor = Color.fromARGB(255, 1, 186, 118);
  final greyColor = Color.fromARGB(255, 232, 232, 232);
  String password = "password";

  // RandomPasswordGenerator().randomPassword(
  //     uppercase: true, numbers: true, specialChar: true, passwordLength: 6);

  // String? newPassword = null;
  // String name = "";
  // String email = "";
  // String phone = "";
  String dropdownValue = "Customer";

  // void generatePassword() {
  //   initState() {
  //     password = RandomPasswordGenerator()
  //         .randomPassword(
  //             letters: true,
  //             uppercase: true,
  //             numbers: true,
  //             specialChar: true,
  //             passwordLength: 6)
  //         .toString();
  //   }
  //
  //   ;
  // }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();

  // final userType = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    super.dispose();
  }

  Widget _buildName() {
    // padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
    return TextFormField(
      controller: name,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        border: InputBorder.none,
        labelStyle: TextStyle(color: Colors.black),
        labelText: 'Name',
        prefixIcon: Icon(
          Icons.supervised_user_circle,
          color: Colors.black,
        ),
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return "**Name is Required";
        } else
          return null;
      },
      // onFieldSubmitted: (String? value) {
      //   name = value!;
      // },
    );
  }

  Widget _buildUserType() {
    // padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
    return Row(
      children: [
        Icon(
          Icons.supervised_user_circle_outlined,
          color: Colors.black,
        ),
        SizedBox(width: 10),
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
          items: <String>['Customer', 'Doctor', 'Pharmacy', 'Lab']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildEmail() {
    // padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
    return TextFormField(
      controller: email,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        border: InputBorder.none,
        labelStyle: TextStyle(color: Colors.black),
        labelText: 'Email',
        prefixIcon: Icon(
          Icons.email_outlined,
          color: Colors.black,
        ),
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return "**Email is Required";
        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
            .hasMatch(value)) {
          return "**Enter Correct Email Address!";
        } else
          return null;
      },
      // onFieldSubmitted: (String? value) {
      //   email = value!;
      // },
    );
  }

  Widget _buildPhone() {
    // padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
    return TextFormField(
      controller: phone,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        border: InputBorder.none,
        labelStyle: TextStyle(color: Colors.black),
        labelText: 'Phone',
        prefixIcon: Icon(
          Icons.phone_android,
          color: Colors.black,
        ),
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return "**Phone Number is Required";
        } else if (!RegExp(r'^((09)|(099)|(099)){1}[0-9]{7}$')
            .hasMatch(value)) {
          //  r'^[0-9]{10}$' pattern plain match number with length 10
          return "**Enter Phone Number in 079xxxxxxx form!";
        } else
          return null;
      },
      // onFieldSubmitted: (String? value) {
      //   phone = value!;
      // },
    );
  }

  // Widget _buildPassword() {
  //   //use provider here with newpassword to update the test form filed
  //   // generatePassword();
  //   // padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
  //   return TextFormField(
  //     initialValue: password,
  //     readOnly: true,
  //     style: TextStyle(color: Colors.black),
  //     decoration: InputDecoration(
  //       labelStyle: TextStyle(color: Colors.black),
  //       border: InputBorder.none,
  //       labelText: 'Password',
  //       prefixIcon: Icon(
  //         Icons.lock_outline_rounded,
  //         color: Colors.black,
  //       ),
  //     ),
  //   );
  // }

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
          "Create New User",
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
        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: Form(
          key: _formKey,
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildName(),
              _buildUserType(),
              _buildEmail(),
              _buildPhone(),
              // _buildPassword(),
              SizedBox(height: 25),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                      primary: Color(0xff18978F),
                      minimumSize: const Size.fromHeight(50),
                      padding: EdgeInsets.fromLTRB(30, 20, 30, 20)),
                  child: Text(
                    'Create Account',
                    style: TextStyle(color: Color(0xffBCECE0), fontSize: 16),
                  ),
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Check Required fields!!!!")));
                    } else if (_formKey.currentState!.validate()) {
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: email.text,
                        password: "password",
                      );
                      //*/password shouldnt be this string
                      if (dropdownValue.toLowerCase() == "customer") {
                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(credential.user?.uid)
                            .set(Customer(
                                    name: name.text,
                                    userType: dropdownValue.toLowerCase(),
                                    address: '',
                                    phoneNumber: phone.text,
                                    age: '')
                                .toFirestore());
                      } else if (dropdownValue.toLowerCase() == "doctor") {
                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(credential.user?.uid)
                            .set(Doctor(
                                    name: name.text,
                                    userType: dropdownValue.toLowerCase(),
                                    specialty: '',
                                    city: '',
                                    address: '',
                                    openHours: '',
                                    phoneNumber: phone.text)
                                .toFirestore());
                      } else if (dropdownValue.toLowerCase() == "pharmacy") {
                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(credential.user?.uid)
                            .set(Pharmacy(
                                    name: name.text,
                                    userType: dropdownValue.toLowerCase(),
                                    city: '',
                                    address: '',
                                    openHours: '',
                                    phoneNumber: phone.text)
                                .toFirestore());
                      } else if (dropdownValue.toLowerCase() == "lab") {
                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(credential.user?.uid)
                            .set(Lab(
                                    name: name.text,
                                    userType: dropdownValue.toLowerCase(),
                                    city: '',
                                    address: '',
                                    openHours: '',
                                    phoneNumber: phone.text)
                                .toFirestore());
                      }

                      // } on FirebaseAuthException catch (e) {
                      //   if (e.code == 'weak-password') {
                      //     print('The password provided is too weak.');
                      //   } else if (e.code == 'email-already-in-use') {
                      //     print('The account already exists for that email.');
                      //   }
                      // } catch (e) {
                      //   print(e);
                      // }

                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text(
                            "Please Send This Message To The New User!",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          content: Text(
                            "Hello ${name.text},\nThis is your password: \"$password\" for your e-mail address: ${email.text}.\nPlease Change your password as soon as possible using Reset Password in the login Page",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AdminPage()));
                              },
                              child: Container(
                                color: Color(0xff18978F),
                                padding: const EdgeInsets.all(14),
                                child: const Text(
                                  "Ok",
                                  style: TextStyle(
                                    color: Color(0xffBCECE0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  onLogin() {}
}
