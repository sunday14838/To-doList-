import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:io/io.dart';

class RegisterPage extends StatefulWidget {
  VoidCallback showloginpage;

  RegisterPage({required this.showloginpage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final Emailcontroller = TextEditingController();
  final Passwordcontroller = TextEditingController();
  final ComfirmPasswordcontroller = TextEditingController();
  final Firstnamecontroller=TextEditingController();
  final Lastnamecontroller=TextEditingController();
  final Agecontroller=TextEditingController();
  final Statecontroller=TextEditingController();
  final Phonenumbercontroller=TextEditingController();

  Future Signup() async {
   if(confirmpassword()){
     try {
       await FirebaseAuth.instance.createUserWithEmailAndPassword(
           email: Emailcontroller.text.trim(),
           password: Passwordcontroller.text.trim());

       addDetails(
         Firstnamecontroller.text.trim(),
         Lastnamecontroller.text.trim(),
         int.parse(Agecontroller.text.trim()),
         int.parse(Phonenumbercontroller.text.trim()),
         Statecontroller.text.trim(),
         Emailcontroller.text.trim()
       );
     }on FirebaseAuthException catch (e){
       showDialog(context: context, builder: (context){
         return AlertDialog(content: Text(e.message.toString()),);
       });
     }
   }
  }

  bool confirmpassword() {
    if (ComfirmPasswordcontroller.text.trim() ==
        Passwordcontroller.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  Future addDetails(String firstname,String lastname,int age,int phonenumber, String state,String email)async{
    await FirebaseFirestore.instance.collection('users').add({
      'first name':firstname,
      'last name':lastname,
      'age':age,
      'phone number':phonenumber,
      'state':state,
      'email':email,
    });
  }

  @override
  void dispose() {
    Emailcontroller.dispose();
    Passwordcontroller.dispose();
    ComfirmPasswordcontroller.dispose();
    Firstnamecontroller.dispose();
    Lastnamecontroller.dispose();
    Agecontroller.dispose();
    Statecontroller.dispose();
    Phonenumbercontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.list_alt,
                size: 80,
              ),
              Text(
                'PLAN YOUR TODO',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Good to have you onboard'),
              SizedBox(
                height: 20,
              ),
              Details(controller: Firstnamecontroller, hinttext: 'First Name',obscuretext: false,),
              Details(controller: Lastnamecontroller, hinttext: 'Last Name',obscuretext: false,),
              Details(controller: Agecontroller, hinttext: 'Age',obscuretext: false,),
              Details(controller: Phonenumbercontroller, hinttext: 'Phone Number',obscuretext: false,),
              Details(controller: Statecontroller, hinttext: 'State',obscuretext: false,),
              Details(controller: Emailcontroller,hinttext: 'Email',obscuretext: false,),
              Details(controller: Passwordcontroller, hinttext: 'Password',obscuretext: true,),
              Details(controller: ComfirmPasswordcontroller, hinttext: 'Confirm Password',obscuretext: true,),

              TextButton(
                onPressed: Signup,
                child: Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.deepPurple,
                    ),
                    child: Center(
                        child: Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ))),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already a member?'),
                  SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: widget.showloginpage,
                    child: Text(
                      'Login here',
                      style: TextStyle(color: Colors.deepPurple,fontSize: 25),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50,)
            ],
          ),
        ),
      ),
    );
  }
}

class Details extends StatelessWidget {
  const Details({
    Key? key,
    required this.controller,required this.hinttext,this.obscuretext
  }) : super(key: key);

  final TextEditingController controller;
  final hinttext;
  final obscuretext;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: TextField(obscureText: obscuretext,
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hinttext,
          ),
        ));
  }
}
