import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';


class ForgotPassword extends StatefulWidget {


  ForgotPassword({Key? key,}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final Emailcontroller=TextEditingController();

  @override
  void dispose() {
   Emailcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(backgroundColor: Colors.grey,
      appBar: AppBar(elevation:0,actions: [Icon(Icons.arrow_back_ios_sharp,size: 20,),],title: Text('PASSWORD RESET'),),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Enter your email to reset Password',style: TextStyle(fontSize: 20),),
              SizedBox(height: 15,),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: TextField(
                    controller: Emailcontroller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email',
                    ),
                  )),
              SizedBox(height: 20,),
              MaterialButton(color:Colors.deepPurple,onPressed: ()async{
                try {
                  await FirebaseAuth.instance.sendPasswordResetEmail(
                      email: Emailcontroller.text.trim());
                  showDialog(context: context, builder: (context){
                    return AlertDialog(content: Text('Check the provided email, password reset has been sent'));
                  });
                }on FirebaseAuthException catch(e){
                  showDialog(context: context, builder: (context){
                    return AlertDialog(content: Text(e.message.toString()));
                  });
                }
              },
              child: Text('Reset Password'),),

             ],

          ),
        ),
      ),
    );
  }
}
