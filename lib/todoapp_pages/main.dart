import 'package:flutter/material.dart';
import 'package:sign_in/todoapp_pages/myhomepage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:sign_in/todoapp_pages/database.dart';
import 'package:async/async.dart';


void main1() async{
  await Hive.initFlutter();

  var box=await Hive.openBox('mybox');
  runApp(const MyApp1());
}

class MyApp1 extends StatelessWidget {
  const MyApp1({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(),
    );
  }
}