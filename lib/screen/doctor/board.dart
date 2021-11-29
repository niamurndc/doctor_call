import 'package:doctor_call/screen/doctor/complete.dart';
import 'package:doctor_call/screen/doctor/write_prescription.dart';
import 'package:doctor_call/screen/video_chat.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({ Key? key }) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  List allcalls = [];

  String token = '';
  String channel = '';
  String appId = '';

  void getallcall() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var token = prefs.getString('token');
    
    var dio = Dio();
    var response = await dio.get(
      'https://amrdoctor.com/api/accepdet-calls',
      options: Options(headers: {
        'Content-Type': 'application/json',
        'Accept' : 'application/json',
        'Authorization' : 'Bearer $token'
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
    getSomeKey();
  }

  void getSomeKey() async {
    var dio = Dio();
    var response = await dio.get('https://amrdoctor.com/api/settings');

    if(response.statusCode == 200){
      var info = response.data;
      setState(() {
        token = info['token_no'];
        channel = info['channel_name'];
      });
    }
  }

  Future<void> completeCall(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var token = prefs.getString('token');

    var dio = Dio();
    var response = await dio.get(
      'https://amrdoctor.com/api/call/complete/$id',
      options: Options(headers: {
        'Content-Type': 'application/json',
        'Accept' : 'application/json',
        'Authorization' : 'Bearer $token'
      })
      );

    if(response.statusCode == 200){
      Navigator.push(context, MaterialPageRoute(builder: (context) => const CompleteOrder()));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accepted Orders'),
        elevation: 0.0,
      ),
      body: ListView.builder(
        itemCount: allcalls.length,
        itemBuilder: (BuildContext context, index){
          var data = allcalls[index];

          Map callinfo = {
            "name" : data['name'],
            "age" : data['age'],
            "problem" : data['problem'],
            "type" : data['type'],
            "id" : data['id'],
          };

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
                            (data['type']) == 'Audio Call' ?
                            Icons.call : (data['type']) == 'Video Call' ? Icons.video_call : Icons.chat, 
                            
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
                              const SizedBox(height: 10.0,),

                              Text(
                                'Age: ${data['age']}', 
                                style: const TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),

                              const SizedBox(height: 10.0,),

                              Text(
                                'Problem: ${data['problem']}', 
                                style: const TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),

                              const SizedBox(height: 20.0,),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  MaterialButton(
                                    onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => VideoCaht(token, channel)));
                                    },
                                    height: 40.0,
                                    textColor: Colors.white, 
                                    child: const Text('Call Patient'), 
                                    color: Colors.green,
                                  ),
                                  const SizedBox(width: 10.0,),
                                  MaterialButton(
                                    onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => WritePrescription(callinfo)));
                                    },
                                    height: 40.0,
                                    textColor: Colors.green, 
                                    child: const Text('Complete Order'), 
                                    color: Colors.white,
                                  )
                                ],
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