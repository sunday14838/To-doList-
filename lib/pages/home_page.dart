import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_in/todoapp_pages/main.dart';
import 'package:sign_in/todoapp_pages/myhomepage.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 final currentuser= FirebaseAuth.instance.currentUser!;

//
//   List docID = [];
//
//   Future getdocID() async {
//     await FirebaseFirestore.instance.collection('users').get().then((
//         snapshot) =>
//         snapshot.docs.forEach((document) {
//           print(document.reference);
//           docID.add(document.reference.id);
//         }));
//   }
// @override
//   void initState() {
//     getdocID();
//     super.initState();
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyApp1(),
    );
  }
}
