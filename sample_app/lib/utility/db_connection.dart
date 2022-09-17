// import 'dart:developer';
// import 'dart:io';
// import 'package:mongo_dart/mongo_dart.dart' show Db, DbCollection;
//
// import '../objects/doctor.dart';
// import '../objects/e_form.dart';
//
// const MONGO_CONN_URL =
//     "mongodb+srv://AbanAlSharah:5040302010Aa@database.ucbmjw1.mongodb.net/Insurance?retryWrites=true&w=";
// const COLLECTION_NAME = "forms";
//
// class DBConnection {
//   static var db;
//   static var collection;
//
//   static connect() async {
//     db = await Db.create(MONGO_CONN_URL);
//     await db.open();
//     inspect(db);
//     if (db.isConnected) print("foo");
//     collection = db.collection(COLLECTION_NAME);
//   }
//
//   static insertForm(EForm form) async {
//     print("Hi");
//     print(await collection.find().toList());
//
//     await collection.insertOne({
//       "patientId": "form.patientId",
//       "doctorId": "form.doctorId",
//       "date": "form.date.toString()",
//       "description": "form.description",
//       "prescription": "form.prescription",
//       "notes": "form.notes",
//     });
//   }
// }
