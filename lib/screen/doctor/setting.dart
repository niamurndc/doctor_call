import 'package:dio/dio.dart';
import 'package:doctor_call/auth/login.dart';
import 'package:doctor_call/screen/profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DoctorSetting extends StatefulWidget {
  const DoctorSetting({ Key? key }) : super(key: key);

  @override
  _DoctorSettingState createState() => _DoctorSettingState();
}

class _DoctorSettingState extends State<DoctorSetting> {
  var token ;

  void getPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
    });
    
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var dio = Dio();

    var response = await dio.post(
      'https://amrdoctor.com/api/logout',
      options: Options(headers: {
        'Content-Type': 'application/json',
        'Accept' : 'application/json',
        'Authorization' : 'Bearer $token'
      })
    );
    prefs.remove('token');
    Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
  }

  @override
  void initState() {
    super.initState();
    getPhone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
        elevation: 0.0,
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          ListTile(
            title: Text('Profile'),
            leading: Icon(Icons.people),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(token)));
            },
          ),
          ListTile(
            title: const Text('Logout'),
            leading: const Icon(Icons.logout),
            onTap: logout,
          )
        ],
      ),

    );
  }
}