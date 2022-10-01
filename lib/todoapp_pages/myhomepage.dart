import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sign_in/todoapp_pages/database.dart';
import 'package:sign_in/todoapp_pages/todo.dart';
import 'package:draggable_fab/draggable_fab.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = TextEditingController();
  final _mybox = Hive.box('mybox');
  Database db = Database();

  @override
  void initState() {
    if (_mybox.get('key') == null) {
      db.createdata();
    } else {
      db.loaddata();
    }
    super.initState();
  }

  void onchange(bool? value, int index) {
    setState(() {
      db.todolist[index][1] = !db.todolist[index][1];
    });
    db.updatedata();
  }


  final currentuser = FirebaseAuth.instance.currentUser!;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(flex: 4, child: Text(currentuser.email!)),
              Expanded(
                child: MaterialButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                    child: Icon(Icons.logout)),
              ),
            ],
          ),
        ),
        floatingActionButton: DraggableFab(
          child: FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Colors.grey,
                      content: Container(
                        height: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextField(
                              controller: controller,
                              decoration: InputDecoration(
                                  hintText: 'Create a todo ',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RawMaterialButton(
                                  onPressed: () {
                                    setState(() {
                                      db.todolist.add([controller.text, false]);
                                      controller.clear();
                                    });
                                    db.updatedata();
                                    Navigator.pop(context);
                                  },
                                  child: Text('Save'),
                                  fillColor: Colors.white70,
                                ),
                                RawMaterialButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Delete'),
                                  fillColor: Colors.white70,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  });
            },
            child: Text(
              '+',
              style: TextStyle(fontSize: 30),
            ),
            backgroundColor: Colors.black87,
          ),
        ),
        body: ListView.builder(
            reverse: true,
            itemCount: db.todolist.length,
            itemBuilder: (context, index) {
              return Todo(
                  text: db.todolist[index][0],
                  value: db.todolist[index][1],
                  onChanged: (value) {
                    onchange(value, index);
                  },
                  delete: () {
                    setState(() {
                      db.todolist.removeAt(index);
                    });
                    db.updatedata();
                  });
            }));
  }
}
