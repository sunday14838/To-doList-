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
    // Using MediaQuery to query device height and width property
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white60,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(flex: 4, child: Text(currentuser.email!)),
            Expanded(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: MaterialButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                    child: Icon(
                      Icons.logout,
                      color: Colors.pinkAccent,
                    )),
              ),
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
                    backgroundColor: Colors.white,
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
                                child: Text('Save',
                                    style: TextStyle(color: Colors.white)),
                                fillColor: Colors.deepPurple,
                              ),
                              RawMaterialButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.white),
                                ),
                                fillColor: Colors.deepPurple,
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
          backgroundColor: Colors.deepPurple,
        ),
      ),
      // remove dummy data and permit user to start the todoList afresh
      // check if todoList is empty to return a separate widget using ternary operator
      body: db.todolist.isEmpty
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'No ToDo Created Yet!',
                  style: TextStyle(fontSize: 16.0, color: Colors.pinkAccent),
                ),
                SizedBox(height: 8.0),
                SizedBox(
                  height: height * 0.4,
                  child: Image(
                    image: AssetImage('images/todo_cover.png'),
                  ),
                ),
              ],
            ))
          : ListView.builder(
              reverse: true,
              // User shrinkWrap to make the list align top
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: db.todolist.length,
              itemBuilder: (context, index) {
                // Fetch all todoList then reverse the list before being used in the builder
                List todoList = db.todolist;
                return Todo(
                    key: UniqueKey(),
                    text: todoList[index][0],
                    value: todoList[index][1],
                    onChanged: (value) {
                      onchange(value, index);
                    },
                    delete: () {
                      setState(() {
                        db.todolist.removeAt(index);
                      });
                      db.updatedata();
                    });
              }),
    );
  }
}
