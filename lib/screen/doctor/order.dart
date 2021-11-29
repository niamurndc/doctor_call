import 'package:doctor_call/screen/doctor/board.dart';
import 'package:doctor_call/screen/doctor/complete.dart';
import 'package:doctor_call/screen/doctor/setting.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';


class DoctorOrder extends StatefulWidget {
  DoctorOrder(this.token);

  final token;

  @override
  _DoctorOrderState createState() => _DoctorOrderState();
}

class _DoctorOrderState extends State<DoctorOrder> {

  String token1 = '';

  List allcalls = [];

  void getallcall() async{
    var dio = Dio();
    var response = await dio.get(
          'https://amrdoctor.com/api/doctor-calls',
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept' : 'application/json',
            'Authorization' : 'Bearer ${widget.token}'
          })
      );

    if(response.statusCode == 200){
      setState(() {
        allcalls = response.data;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getallcall();
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
          'Authorization' : 'Bearer ${widget.token}'
        })
    );

  }

  void acceptCall(id) async {
    var dio = Dio();
    var response = await dio.get(
      'https://amrdoctor.com/api/call/accept/$id',
      options: Options(headers: {
        'Content-Type': 'application/json',
        'Accept' : 'application/json',
        'Authorization' : 'Bearer ${widget.token}'
      })
    );

    if(response.statusCode == 200){
      Navigator.push(context, MaterialPageRoute(builder: (context) => const DashBoard()));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Orders'),
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
                      'Doctor Panel',
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
                  'Accepted Orders',
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const DashBoard()));
              },
            ),
            ListTile(
              title: const Text(
                  'Complete Orders',
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CompleteOrder()));
              },
            ),
            ListTile(
              title: const Text(
                        'Setting',
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const DoctorSetting()));
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: allcalls.length,
        itemBuilder: (BuildContext context, index){
          var data = allcalls[index];

          return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [

                          Icon(
                            (data['dtype']) == 'Audio Call' ?
                            Icons.call : (data['dtype']) == 'Video Call' ? Icons.video_call : Icons.chat, 
                            
                            color: Colors.green,
                          ),
                          const SizedBox(width: 16.0,),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name: ${data['name']}', 
                                style: const TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                              const SizedBox(height: 5.0,),

                              Text(
                                'Age: ${data['age']}', 
                                style: const TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),

                              const SizedBox(height: 5.0,),

                              Text(
                                'Problem: ${data['problem']}', 
                                style: const TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),

                              SizedBox(height: 10.0,),

                              MaterialButton(
                                onPressed: (){
                                  acceptCall(data['id']);
                                },
                                height: 30.0,
                                textColor: Colors.white, 
                                child: const Text('Accept'), 
                                color: Colors.green,
                              )

                            ],
                          )
                        ],)
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
              );
        }
      ),
    );
  }
}