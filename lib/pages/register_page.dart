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
  final Firstnamecontroller = TextEditingController();
  final Lastnamecontroller = TextEditingController();

  // Reducing form fields
  // final Agecontroller = TextEditingController();
  // final Statecontroller = TextEditingController();
  // final Phonenumbercontroller = TextEditingController();

  // isLoading is used to call a progress indicator to show user an event is happening which is signup in progress
  // the state value of isLoading will be set to true when user presses login using setState() method of StatefulWidget
  bool isLoading = false;

  Future Signup() async {
    if (confirmpassword()) {
      try {
        // Set the state value of isLoding to true when this function is called; onPress of Signup button
        setState(() {
          isLoading = true;
        });
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: Emailcontroller.text.trim(),
            password: Passwordcontroller.text.trim());

        addDetails(
            Firstnamecontroller.text.trim(),
            Lastnamecontroller.text.trim(),
            //  int.parse(Agecontroller.text.trim()),
            // int.parse(Phonenumbercontroller.text.trim()),
            // Statecontroller.text.trim(),
            Emailcontroller.text.trim());
      } on FirebaseAuthException catch (e) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(e.message.toString()),
              );
            });
      } finally {
        // try-catch provides finally, no mater what happens, whenther the code fail or succed finall bloc will be called

        setState(() {
          // isLoading is set to false here to avoid unending loading
          isLoading = false;
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

  Future addDetails(String firstname, String lastname, String email) async {
    await FirebaseFirestore.instance.collection('users').add({
      'first name': firstname,
      'last name': lastname,
      'email': email,
      //   'age': age,
      // 'phone number': phonenumber,
      //  'state': state,
    });
  }

  @override
  void dispose() {
    Emailcontroller.dispose();
    Passwordcontroller.dispose();
    ComfirmPasswordcontroller.dispose();
    Firstnamecontroller.dispose();
    Lastnamecontroller.dispose();
    // Agecontroller.dispose();
    // Statecontroller.dispose();
    // Phonenumbercontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.list_alt,
                    size: 60,
                    color: Colors.purple,
                  ),
                  Text(
                    'PLAN YOUR TODO',
                    style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple),
                  ),
                ],
              ),
              SizedBox(
                height: 4.0,
              ),
              Text('Good to have you onboard'),
              SizedBox(
                height: 20,
              ),
              Details(
                controller: Firstnamecontroller,
                hintText: 'First Name',
                obscuretext: false,
              ),
              Details(
                controller: Lastnamecontroller,
                hintText: 'Last Name',
                obscuretext: false,
              ),
              // Details(
              //   controller: Agecontroller,
              //   hintText: 'Age',
              //   obscuretext: false,
              // ),
              // Details(
              //   controller: Phonenumbercontroller,
              //   hintText: 'Phone Number',
              //   obscuretext: false,
              // ),

              // Details(
              //   controller: Statecontroller,
              //   hintText: 'State',
              //   obscuretext: false,
              // ),
              Details(
                controller: Emailcontroller,
                hintText: 'Email',
                obscuretext: false,
              ),
              Details(
                controller: Passwordcontroller,
                hintText: 'Password',
                obscuretext: true,
              ),
              Details(
                controller: ComfirmPasswordcontroller,
                hintText: 'Confirm Password',
                obscuretext: true,
              ),
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
                        child: isLoading == true
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white),
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
                      style: TextStyle(color: Colors.deepPurple, fontSize: 24),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Details extends StatelessWidget {
  const Details(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.obscuretext})
      : super(key: key);

  final TextEditingController controller;
  final hintText;
  final obscuretext;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
        // margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: TextField(
          obscureText: obscuretext,
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(color: Colors.grey),
            ),
            hintText: hintText,
          ),
        ));
  }
}
