import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
// import 'package:todo_app2/todoapp_pages/main.dart';



class Database  {
  var box= Hive.openBox('mybox');
  final _mybox= Hive.box('mybox');
  List todolist=[];



  void createdata(){
    todolist=[
      ['Plan For My Future', false],
      ['Call My Sweet Mummy', false],
      ['Be a philanthropist', false],
      ['Dance in The Presence of GOD', false]
    ];
  }

  void loaddata(){
    todolist=_mybox.get('key');
  }

  void updatedata(){
    _mybox.put('key', todolist);
  }
}