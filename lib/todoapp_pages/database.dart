import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
// import 'package:todo_app2/todoapp_pages/main.dart';

class Database {
  var box = Hive.openBox('mybox');
  final _mybox = Hive.box('mybox');
  List todolist = [].reversed.toList();

  void createdata() {
    todolist = [];
  }

  void loaddata() {
    todolist = _mybox.get('key');
  }

  void updatedata() {
    _mybox.put('key', todolist);
  }
}
