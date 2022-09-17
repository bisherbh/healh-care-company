import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/currentUser.dart';

class ViewPharmacyInfo extends StatelessWidget {
  const ViewPharmacyInfo({Key? key}) : super(key: key);

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
          "Pharmacy Info",
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
  // late String _pharmacyname;
  // late String _address;
  // late String _userType;
  // late String _phoneNumber;
  // late String _openHours;
  // late String _city;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? name;
  String? address;
  String? userType;
  String? phoneNumber;
  String? openHours;
  String? city;

  Widget _buildPharmacyName() {
    return TextFormField(
      initialValue: Provider.of<CurrentUser>(context,listen: false).object.name,
      readOnly: true,
      decoration:
      InputDecoration(labelText: 'Pharmacy Name', border: InputBorder.none),
      validator: (String? value) {
        if (value == null) {
          return 'Pharmacy Name is Required';
        }
        return null;
      },
    );
  }

  Widget _buildAddress() {
    return TextFormField(
      initialValue: Provider.of<CurrentUser>(context,listen: false).object.address,
      readOnly: true,
      decoration: InputDecoration(labelText: 'Address'),
      keyboardType: TextInputType.number,
      validator: (String? value) {
        if (value == null) {
          return 'Address is Required';
        }
        return null;
      },
    );
  }

  Widget _buildUserType() {
    return TextFormField(
      initialValue: Provider.of<CurrentUser>(context,listen: false).object.userType,
      readOnly: true,
      decoration:
      InputDecoration(labelText: 'User Type', border: InputBorder.none),
      keyboardType: TextInputType.number,
      validator: (String? value) {
        if (value == null) {
          return 'User Type is Required';
        }
        return null;
      },
    );
  }

  Widget _buildPhoneNumber() {
    return TextFormField(
      initialValue: Provider.of<CurrentUser>(context,listen: false).object.phoneNumber,
      readOnly: true,
      decoration: InputDecoration(labelText: 'Phone Number'),
      keyboardType: TextInputType.number,
      validator: (String? value) {
        if (value == null) {
          return 'Phone Number is Required';
        }
        return null;
      },
    );
  }

  Widget _buildOpenHours() {
    return TextFormField(
      initialValue: Provider.of<CurrentUser>(context,listen: false).object.openHours,
      readOnly: true,
      decoration: InputDecoration(labelText: 'Open Hours'),
      keyboardType: TextInputType.number,
      validator: (String? value) {
        if (value == null) {
          return 'Open Hours is Required';
        }
        return null;
      },
    );
  }

  Widget _buildCity() {
    return TextFormField(
      initialValue: Provider.of<CurrentUser>(context,listen: false).object.city,
      readOnly: true,
      decoration: InputDecoration(labelText: 'City'),
      keyboardType: TextInputType.number,
      validator: (String? value) {
        if (value == null) {
          return 'City is Required';
        }
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
                _buildPharmacyName(),
                _buildUserType(),
                _buildCity(),
                _buildAddress(),
                _buildOpenHours(),
                _buildPhoneNumber(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
