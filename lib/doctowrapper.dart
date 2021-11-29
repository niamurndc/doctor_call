import 'package:dio/dio.dart';
import 'package:doctor_call/auth/login.dart';
import 'package:doctor_call/screen/doctor/order.dart';
import 'package:doctor_call/screen/home.dart';
import 'package:doctor_call/screen/video_chat.dart';
import 'package:doctor_call/services/show_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DoctorWrapper extends StatefulWidget {
  const DoctorWrapper({ Key? key }) : super(key: key);

  @override
  _DoctorWrapperState createState() => _DoctorWrapperState();
}

class _DoctorWrapperState extends State<DoctorWrapper> {

  var doctor = false;
  
  var token1;
  var call_token;
  var channel;

  @override
  void initState() {
    super.initState();
    checklogin();
    getSomeKey();

    ShowNotification.initialize(context);

    FirebaseMessaging.instance.getInitialMessage().then((message) {});

    FirebaseMessaging.onMessage.listen((message) {
      if(message.notification != null){
        ShowNotification.display(message);
        if(message.notification!.title == 'Call accepted'){
          Navigator.push(context, MaterialPageRoute(builder: (context) => VideoCaht(call_token, channel)));
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {});

    
  }

  void getSomeKey() async {
    var dio = Dio();
    var response = await dio.get('https://amrdoctor.com/api/settings');

    if(response.statusCode == 200){
      var info = response.data;
      setState(() {
        call_token = info['token_no'];
        channel = info['channel_name'];
      });
    }
  }

  void checklogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var role = prefs.getInt('role');

    if(token == null){
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
    }else{
      if(role == 1){
        setState(() {
          doctor = true;
          token1 = token;
        });

      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return doctor ? DoctorOrder(token1) : const Home();
  }
}