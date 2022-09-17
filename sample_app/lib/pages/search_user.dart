import 'package:flutter/material.dart';
import 'package:sample_app/pages/view_user.dart';
import 'package:sample_app/providers/listOfMedicines.dart';
import 'package:provider/provider.dart';

import '../objects/customer.dart';
import '../providers/allPatients.dart';
import '../providers/currentPatient.dart';
import '../providers/eFormsList.dart';
import '../providers/medicines_in_cart.dart';

class SearchUser extends StatelessWidget {
  const SearchUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<AllPatients>(context).getFromDB();
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
          "Search Patient",
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: AutocompleteSearch(),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Color(0xff18978F),
                    ),
                  ),
                  child: Text(
                    'Search',
                    style: TextStyle(
                      color: Color(0xffBCECE0),
                    ),
                  ),
                  onPressed: () {
                    // Provider.of<EFormsList>(context, listen: false).getFromDB(
                    //     Provider.of<CurrentPatient>(context, listen: false)
                    //         .object);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewPatientInfo()));
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
        if (textEditingValue.text.isEmpty) {
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
