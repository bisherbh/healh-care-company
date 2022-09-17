import 'package:flutter/material.dart';
import 'package:graduation_project_draft/pages/admin/view_doctor.dart';
import 'package:graduation_project_draft/pages/view_user.dart';
import 'package:graduation_project_draft/providers/listOfMedicines.dart';
import 'package:provider/provider.dart';

import '../../objects/customer.dart';
import '../../providers/allPatients.dart';
import '../../providers/currentPatient.dart';
import '../../providers/eFormsList.dart';

class SearchUserInsurance extends StatefulWidget {
  SearchUserInsurance({Key? key}) : super(key: key);

  @override
  State<SearchUserInsurance> createState() => _SearchUserInsuranceState();
}

class _SearchUserInsuranceState extends State<SearchUserInsurance> {
  String dropdownValue = "Customer";


  Widget _buildUserType() {
    // padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.supervised_user_circle_outlined, color: Colors.black),
        SizedBox(width: 10),
        DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(
            Icons.arrow_drop_down_outlined,
            color: Color(0xff18978F),
          ),
          elevation: 16,
          style: const TextStyle(color: Colors.black),
          underline: SizedBox(),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: <String>['Customer', 'Doctor', 'Pharmacy', 'Laboratory']
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
          "Search User",
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
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _buildUserType(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'User Name',
                        hintText: 'Enter User Name'),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xff18978F)),
                  ),
                  child: Text(
                    'Search',
                    style: TextStyle(
                      color: Color(0xffBCECE0),
                    ),
                  ),
                  onPressed: () {
                    switch (dropdownValue) {
                      case "Customer":
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewPatientInfo()));
                        break;
                      case "Doctor":
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewDoctorInfo()));
                        break;
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

class AutocompleteSearch extends StatelessWidget {
  const AutocompleteSearch({Key? key}) : super(key: key);

  static String _displayStringForOption(Customer option) => option.name;
  @override
  Widget build(BuildContext context) {
    return Autocomplete<Customer>(
      displayStringForOption: _displayStringForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<Customer>.empty();
        }
        return // _userOptions
            Provider.of<AllPatients>(context, listen: false)
                .allCustomers2
                .where((Customer option) {
          return option.name
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (Customer selection) {
        Provider.of<CurrentPatient>(context, listen: false).object = selection;
        Provider.of<EFormsList>(context, listen: false).getFromDB(selection);
        debugPrint('You just selected ${_displayStringForOption(selection)}');
      },
    );
  }
}
