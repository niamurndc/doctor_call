import 'package:dio/dio.dart';
import 'package:doctor_call/auth/login.dart';
import 'package:doctor_call/screen/call/create.dart';
import 'package:doctor_call/screen/comming_soon.dart';
import 'package:doctor_call/screen/prescription.dart';
import 'package:doctor_call/screen/profile.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:doctor_call/screen/order.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var token;
  var role;

  void getPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
      role = prefs.getInt('role');

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

    FirebaseMessaging.instance.getToken().then((value) => setAppToken(value));
  }

  void setAppToken(appToken) async {
    var dio = Dio();
    var response = await dio.post('https://amrdoctor.com/api/profile/update',
      data: {
        'app_token' : appToken
      },
      options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept' : 'application/json',
          'Authorization' : 'Bearer $token'
        })
    );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AMR Doctor'),
        backgroundColor: Colors.green,
        elevation: 0.0,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AMR Doctor',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ],
                ),
              ) ,
              decoration: const BoxDecoration(
                color: Colors.green
              ),
            ),
            ListTile(
              title: const Text(
                  'Orders',
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => OrderAll(token)));
              },
            ),
            ListTile(
              title: const Text(
                  'Prescriptions',
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Prescription(token)));
              },
            ),
            ListTile(
              title: const Text(
                        'Profile',
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(token)));
              },
            ),
            ListTile(
              title: const Text(
                        'Logout',
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
              onTap: logout,
            ),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        children: [
          const SizedBox(height: 50.0,),

          const Text(
            'Our Online Services',
            style: TextStyle(color: Colors.black, fontSize: 26.0),
          ),

          const SizedBox(height: 10.0,),

          Row(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CommingSoon()));
                },
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(Icons.chat, color: Colors.green,),
                        Text(
                          'Live Caht', 
                          style: TextStyle(
                            color: Colors.black, 
                            fontSize: 20.0,
                          ),
                        ),
                    ],),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.green,
                      width: 2.0
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CommingSoon()));
                },
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(Icons.call, color: Colors.green,),
                        Text(
                          'Audio Call', 
                          style: TextStyle(
                            color: Colors.black, 
                            fontSize: 20.0,
                          ),
                        ),
                    ],),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.green,
                      width: 2.0
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CreateCall('Video Call', 99)));
                },
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const[
                        Icon(Icons.video_call, color: Colors.green,),
                        Text(
                          'Video Call', 
                          style: TextStyle(
                            color: Colors.black, 
                            fontSize: 20.0,
                          ),
                        ),
                    ],),
                  ),
                  decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.green,
                    width: 2.0
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                ),
              ),
            ),
          ],),

          const SizedBox(height: 40.0,),
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(

              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 6.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.health_and_safety, color: Colors.white,),
                    Text(
                      'Get Our Offline Doctor', 
                      style: TextStyle(
                        color: Colors.white, 
                        fontSize: 20.0,
                      ),
                    ),
                ],),
              ),
              decoration: BoxDecoration(
                color: Colors.green,
                border: Border.all(
                  color: Colors.green,
                  width: 2.0
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),

          const SizedBox(height: 20.0,),
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(

              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 6.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const[
                    Icon(Icons.medication_rounded, color: Colors.white,),
                    Text(
                      'Get medicin in your home', 
                      style: TextStyle(
                        color: Colors.white, 
                        fontSize: 20.0,
                      ),
                    ),
                ],),
              ),
              decoration: BoxDecoration(
                color: Colors.green,
                border: Border.all(
                  color: Colors.green,
                  width: 2.0
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),

          
        ],
      ),
    );
  }
}