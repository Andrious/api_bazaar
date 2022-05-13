// import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
//
// import 'package:firebase_database/firebase_database.dart' show FirebaseDatabase;
//
// class UserManagement {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   FirebaseDatabase database = FirebaseDatabase.instance;
//
//   void createUser(String uid, Map data) {
//     database
//         .reference()
//         .child('users/$uid')
//         .push()
//         .set(data)
//         .catchError((e) => print(e.toString()));
//   }
//
//   // here user.uid triggers an id inside the user which should match id of the user document
//   // createUser(Map data) {
//   //   firestore.collection("users").document(data["userId"]).setData(data);
//   // }
// }
