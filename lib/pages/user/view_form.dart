import 'dart:html';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../objects/e_form.dart';
import '../../providers/currentPatient.dart';
import '../../providers/currentUser.dart';
import '../../providers/eFormsList.dart';
import '../filled_e_form.dart';

class ListOfeForms extends StatelessWidget {
  const ListOfeForms({Key? key}) : super(key: key);

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
              // Provider.of<EFormsList>(context, listen: false)
              //     .listOfEforms
              //     .clear();

              Navigator.pop(context);
            }),
        title: const Text(
          "E-Forms List",
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
        child: Column(
          children: [
            // FloatingActionButton(onPressed: (){
            //   Provider.of<EFormsList>(context, listen: false).listOfEforms2.clear();
            // }),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.1),
                child: ListView.builder(
                  // shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blueGrey.shade200),
                          onPressed: () {
                            Provider.of<EFormsList>(context, listen: false)
                                .currentIndex = index;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FilledEFormPage()));
                          },
                          child: AddedForm(
                              eform: Provider.of<EFormsList>(context, listen: false)
                                  .listOfEforms2[index])),
                    );
                  },
                  itemCount: Provider.of<EFormsList>(context, listen: false)
                      .listOfEforms2
                      .length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddedForm extends StatefulWidget {
  AddedForm({required this.eform, Key? key}) : super(key: key);
  EForm eform;

  @override
  _AddedFormState createState() => _AddedFormState();
}

class _AddedFormState extends State<AddedForm> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey.shade200,
      elevation: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          RichText(
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            text: TextSpan(
              text: 'E-Form Date: ${widget.eform.date}',
              style: TextStyle(color: Colors.blueGrey.shade800, fontSize: 16.0),
              children: [
                TextSpan(style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
        ],
      ),
    );
  }
}
