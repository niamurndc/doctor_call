import 'package:doctor_call/auth/login.dart';
import 'package:doctor_call/doctowrapper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Wrapper extends StatefulWidget {
  const Wrapper({ Key? key }) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  var login = false;

  @override
  void initState() {
    super.initState();
    checklogin();
  }

  void checklogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var role = prefs.getInt('role');



    if(token != null){

        setState(() {
          login = true;
        });
  }
  }


  @override
  Widget build(BuildContext context) {
    return login ? const DoctorWrapper() : const Login();
  }
}