import 'package:flutter/material.dart';
import 'package:sign_in/login_page.dart';
import 'package:sign_in/register_page.dart';


class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  bool showloginpage=true;

  void toggleScreens(){
    setState(() {
      showloginpage=!showloginpage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showloginpage){
      return LoginPage(showregisterpage: toggleScreens);
    }else{
      return RegisterPage(showloginpage: toggleScreens);
    };
  }
}
