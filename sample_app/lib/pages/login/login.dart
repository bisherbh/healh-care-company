import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:sample_app/pages/admin/create_user.dart';
import 'package:sample_app/providers/allPatients.dart';
import 'package:sample_app/providers/currentUser.dart';
import 'package:provider/provider.dart';
import '../../providers/listOfMedicines.dart';
import '../admin/adminpage.dart';
import '../doctor/doctor_homepage.dart';
import '../lab/labpage.dart';
import '../pharmacy/pharmacy_homepage.dart';
import '../user/customer_pages.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController modelEmail = TextEditingController();
  final TextEditingController modelPassword = TextEditingController();

  bool isLoading = false;
  bool _obscureText = true;

  void _togglePasswordStatus() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }


  @override
  Widget build(BuildContext context) {

    // Provider.of<ListOfMedicines>(context, listen: false).getFromDB();

    // Provider.of<AllPatients>(context).getFromDB();
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("login page"),
      //   backgroundColor: barColor,
      // ),
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
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/dna.png'),
                    fit: BoxFit.fill,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2.2,
                      height: MediaQuery.of(context).size.height,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 75, top: 85),
                        child: Text(
                          'Health Insurance \n Management System',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 45),
                        ),
                      ),
                    ),
                    Center(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text(
                                  "Contact Us: ",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                content: const Text(
                                  "Phone Number: +962796574967 \nE-mail Address: admin@gmail.com \nAddress: Bu.4, Khaleel Alsaket St, Jubahia, Amman, Jordan",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
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
                          },
                          child: Text(
                            "Contact Us",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.2,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              padding: EdgeInsets.fromLTRB(20, 100, 20, 0),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Text(
                                'Welcome Back',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 28),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Text(
                                'Sign to continue',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xffBCECE0),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                              child: TextField(
                                controller: modelEmail,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                  labelText: 'E-mail ',
                                  prefixIcon: Icon(
                                    Icons.account_box_rounded,
                                    color: Colors.black,
                                  ),
                                ),

                                // onSubmitted: (value) => userType = value,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                              child: TextField(
                                controller: modelPassword,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: _togglePasswordStatus,
                                    color: Colors.black,
                                  ),
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                  border: InputBorder.none,
                                  labelText: 'Password ',
                                  prefixIcon: Icon(
                                    Icons.lock_outline_rounded,
                                    color: Colors.black,
                                  ),
                                ),
                                obscureText: _obscureText,
                                // onChanged: (val) {
                                //   setState(() {});
                                // },
                              ),
                            ),
                            Container(
                              child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent,
                                  ),
                                  elevation: MaterialStateProperty.all(0.0),
                                ),
                                onPressed: () {
                                  final emailController =
                                      TextEditingController();
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text(
                                        "Are You Sure?",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                      content: TextField(
                                        onChanged: (value) {},
                                        controller: emailController,
                                        decoration: InputDecoration(
                                            labelText: "Enter your e-mail",
                                            hintText:
                                                "*A reset link will be sent to you"),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Container(
                                            color: Color(0xff18978F),
                                            padding: const EdgeInsets.all(14),
                                            child: const Text(
                                              "No",
                                              style: TextStyle(
                                                color: Color(0xffBCECE0),
                                              ),
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            final auth =  FirebaseAuth.instance
                                                .sendPasswordResetEmail(
                                                    email:
                                                        emailController.text);
                                          print(auth);

                                            Navigator.of(context).pop();
                                          },
                                          child: Container(
                                            color: Color(0xff18978F),
                                            padding: const EdgeInsets.all(14),
                                            child: const Text(
                                              "Yes",
                                              style: TextStyle(
                                                color: Color(0xffBCECE0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Reset Password",
                                  style: TextStyle(
                                    color: Color(0xffBCECE0),
                                  ),
                                ),
                                // margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
                                // child: Text(
                                //   'Forgot Password?',
                                //   textAlign: TextAlign.left,
                                //   style: const TextStyle(
                                //     color: Color(0xffBCECE0),
                                //   ),
                                // ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.20,
                                child: ElevatedButton(
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(
                                        color: Color(0xffBCECE0),
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        textStyle:
                                            const TextStyle(fontSize: 20),
                                        primary: Color(0xff18978F),
                                        minimumSize: const Size.fromHeight(50),
                                        padding: EdgeInsets.fromLTRB(
                                            30, 20, 30, 20)),
                                    onPressed: () async {
                                      setState(() {
                                        isLoading = true;
                                      });

                                      await signInUsingEmailPassword(
                                          email: modelEmail.text,
                                          password: modelPassword.text,
                                          context: context);
                                     //  print(currentUser?.email);
                                      Provider.of<CurrentUser>(context,
                                              listen: false)
                                          .determineUser(context);
                                      await Future.delayed(Duration(seconds: 5))
                                          .then((_) => setState(() {
                                                isLoading = false;
                                              }));
                                    }),
                              ),
                            ),
                            // Container(
                            //     padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                            //     width: double.infinity,
                            //     child: RichText(
                            //       textAlign: TextAlign.right,
                            //       text: TextSpan(
                            //         style: TextStyle(color: Colors.black, fontSize: 14),
                            //         children: <TextSpan>[
                            //           TextSpan(
                            //               text: "Don't have an account? ",
                            //               style: TextStyle(
                            //                 color: Colors.black,
                            //               )),
                            //           TextSpan(
                            //               text: 'create a new account ',
                            //               style: TextStyle(color: greenColor)),
                            //         ],
                            //       ),
                            //     )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  // void redirection(){
  //   final currentUser=FirebaseAuth.instance.currentUser;
  //
  //   final db = FirebaseFirestore.instance;
  //   final docRef = db.collection("users").doc(currentUser?.uid);
  //   var userType;
  //
  //   final currentUserType;
  //   if(currentUserType=="doctor"){
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => DoctorHomePage()));
  //   }else if(currentUserType==)
  // }

  Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
    }

    return user;
  }
}

// void onLogin() {
//   if (modelEmail == "admin" && modelPassword == "admin") {
//     AlertDialog alert = AlertDialog(
//       title: Text("Login Berhasil"),
//       content: Container(
//         child: Text("Selamat Anda Berhasil login"),
//       ),
//       actions: [
//         TextButton(
//           child: Text('Ok'),
//           onPressed: () => Navigator.push(
//               context, MaterialPageRoute(builder: (context) => Register())),
//         ),
//       ],
//     );
//   }
// }
