import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_in/Forgetpassword_page.dart';


class LoginPage extends StatefulWidget {

  VoidCallback showregisterpage;

  LoginPage({required this.showregisterpage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Emailcontroller=TextEditingController();
  final Passwordcontroller=TextEditingController();


  Future Signin()async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: Emailcontroller.text.trim(),
          password: Passwordcontroller.text.trim());
      showDialog(context: context, builder: (context){
        return AlertDialog(content: Text('Sign In Successfull'));
      });
    }on FirebaseAuthException catch(e){
      showDialog(context: context, builder: (context){
        return AlertDialog(content: Text(e.message.toString()));
      });
    }
    }

  @override
  void dispose() {
    Emailcontroller.dispose();
    Passwordcontroller.dispose();
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
                Icons.add_to_drive,
                size: 80,
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                'HELLO AGAIN',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text('Welcome back, Hope you were able to achieve your AIM'),
              Text('Never Give Up, You can do it'),
              SizedBox(
                height: 30,
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: TextField(obscureText: true,
                    controller: Passwordcontroller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                    ),
                  )),
              SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                  GestureDetector(
                      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context){
                        return ForgotPassword();
                      }));},
                      child: Text('Forgot Password?',style: TextStyle(fontSize: 20,color: Colors.deepPurple),))
                ],),
              ),
              
              TextButton(onPressed: Signin,
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
                          'Log In',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ))),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Not a member?'),
                  SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: widget.showregisterpage,
                    child: Text(
                      'Register Now',
                      style: TextStyle(color: Colors.deepPurple,fontSize: 25),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
