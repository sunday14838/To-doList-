import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_in/forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  VoidCallback showregisterpage;

  LoginPage({required this.showregisterpage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Emailcontroller = TextEditingController();
  final Passwordcontroller = TextEditingController();

  // isLoading is used to call a progress indicator to show user an event is happening which is login in progress
  // the state value of isLoading will be set to true when user presses login using setState() method of StatefulWidget
  bool isLoading = false;

  Future Signin() async {
    try {
      // Set the state value of isLoding to true when this function is called; onPress of Login button
      setState(() {
        isLoading = true;
      });
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: Emailcontroller.text.trim(),
          password: Passwordcontroller.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(content: Text('Sign In Successfull'));
          });
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(content: Text(e.message.toString()));
          });
    } finally {
      // try-catch provides finally, no mater what happens, whenther the code fail or succed finall bloc will be called
      setState(() {
        // isLoading is set to false here to avoid unending loading
        isLoading = false;
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white60,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon(
            //   Icons.add_to_drive,
            //   size: 80,
            // ),
            // SizedBox(
            //   height: 50,
            // ),
            // Text(
            //   'HELLO AGAIN',
            //   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            SizedBox(
                height: height * 0.3,
                width: width,
                child: Image(
                  image: AssetImage('images/todo_cover.png'),
                  fit: BoxFit.fitHeight,
                )),
            Text(
              'Welcome back, Hope you were able to achieve your AIM',
              style: TextStyle(color: Colors.black54, fontSize: 14.0),
            ),
            SizedBox(height: 6.0),
            Text(
              'Never Give Up, You can do it',
              style: TextStyle(color: Colors.black54, fontSize: 14.0),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                //  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: Emailcontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    hintText: 'Email',
                  ),
                )),
            SizedBox(height: 20.0),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                // margin: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: TextField(
                  obscureText: true,
                  controller: Passwordcontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    hintText: 'Password',
                  ),
                )),
            TextButton(
              onPressed: Signin,
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
                              'Log In',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ))),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ForgotPassword();
                        }));
                      },
                      child: Text(
                        'Forgot Password?',
                        style:
                            TextStyle(fontSize: 14, color: Colors.deepPurple),
                      ))
                ],
              ),
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
                    style: TextStyle(color: Colors.deepPurple, fontSize: 24),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
