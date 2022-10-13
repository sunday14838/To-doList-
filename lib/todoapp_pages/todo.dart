import 'package:flutter/material.dart';
import 'package:sign_in/todoapp_pages/myhomepage.dart';

class Todo extends StatelessWidget {
  bool value;
  String text;
  Function(bool?) onChanged;
  Function() delete;


  Todo(
      {Key? key,
      required this.value,
      required this.text,
      required this.onChanged,required this.delete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(left: 20, right: 20, top: 10,bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white10,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Checkbox(value: value, onChanged: onChanged,activeColor: Colors.black26,),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 18.0,
                  decoration: value ? TextDecoration.lineThrough : null),
            ),
          ),
          Container(height: 35,width: 35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.redAccent),
            child: IconButton(
                onPressed:
                  delete,
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,size: 20,
                )),
          )
        ],
      ),
    );
  }
}
