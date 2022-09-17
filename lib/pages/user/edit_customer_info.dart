import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/currentUser.dart';

class EditCustomerInfo extends StatelessWidget {
  const EditCustomerInfo({Key? key}) : super(key: key);

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
          "Edit Info",
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
  // late String _username;
  // late String _address;
  // late String _userType;
  // late String _age;
  // late String _phoneNumber;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? name;
  String? address;
  String? userType;
  String? age;
  String? phoneNumber;

  Widget _buildUserName() {
    return TextFormField(
      initialValue:
          Provider.of<CurrentUser>(context, listen: false).object.name,
      readOnly: true,
      decoration: InputDecoration(labelText: 'Name', border: InputBorder.none),
    );
  }

  Widget _buildAddress() {
    return TextFormField(
      initialValue:
          Provider.of<CurrentUser>(context, listen: false).object.address,
      decoration: InputDecoration(labelText: 'Address'),
      onChanged: (String? value) {
        address = value!;
      },
    );
  }

  Widget _buildAge() {
    return TextFormField(
      initialValue: Provider.of<CurrentUser>(context, listen: false).object.age,
      decoration: InputDecoration(labelText: 'Age'),
      keyboardType: TextInputType.number,
      validator: (String? value) {
        if (value!.isEmpty) {
          return "**Age is Required";
        } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
          return "**Enter Age in Number!";
        } else
          return null;
      },
      onChanged: (String? value) {
        age = value!;
      },
    );
  }

  Widget _buildUserType() {
    return TextFormField(
      initialValue:
          Provider.of<CurrentUser>(context, listen: false).object.userType,
      readOnly: true,
      decoration:
          InputDecoration(labelText: 'User Type', border: InputBorder.none),
    );
  }

  Widget _buildPhoneNumber() {
    return TextFormField(
      initialValue:
          Provider.of<CurrentUser>(context, listen: false).object.phoneNumber,
      decoration: InputDecoration(labelText: 'Phone Number'),
      keyboardType: TextInputType.number,
      validator: (String? value) {
        if (value!.isEmpty) {
          return "**Phone Number is Required";
        } else if (!RegExp(r'^((079)|(078)|(077)){1}[0-9]{7}$')
            .hasMatch(value)) {
          //  r'^[0-9]{10}$' pattern plain match number with length 10
          return "**Enter Phone Number in 079xxxxxxx form!";
        } else
          return null;
      },
      onChanged: (String? value) {
        phoneNumber = value!;
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
                _buildUserType(),
                _buildUserName(),
                _buildAddress(),
                _buildAge(),
                _buildPhoneNumber(),
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
                      final auth = await FirebaseAuth.instance;
                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(auth.currentUser?.uid)
                          .update({
                        'address': (address == null)
                            ? Provider.of<CurrentUser>(context, listen: false)
                                .object
                                .address
                            : address,
                        'age': (age == null)
                            ? Provider.of<CurrentUser>(context, listen: false)
                                .object
                                .age
                            : age,
                        'phoneNumber': (phoneNumber == null)
                            ? Provider.of<CurrentUser>(context, listen: false)
                                .object
                                .phoneNumber
                            : phoneNumber,
                      });
                      Navigator.popUntil(context, (route) => route.isFirst);
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
