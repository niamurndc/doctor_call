import 'package:dio/dio.dart';
import 'package:doctor_call/screen/doctor/complete.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WritePrescription extends StatefulWidget {
  WritePrescription(this.callinfo);
  final Map callinfo;
  @override
  _WritePrescriptionState createState() => _WritePrescriptionState();
}

class _WritePrescriptionState extends State<WritePrescription> {
  
  var presc = '';
  void completeCall() async {
    // get token
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');


    var callId = widget.callinfo['id'];
    var dio = Dio();
    
    var response = await dio.post(
      'https://amrdoctor.com/api/call/complete/$callId', 
      data: {
      "presc" : presc
      }, 
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
      appBar: AppBar(title: const Text('Write Advice'),),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Call type: ${widget.callinfo['type']}',
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    const SizedBox(height: 10.0,),
                    Text(
                      'Patient name: ${widget.callinfo['name']}',
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                    ),

                    const SizedBox(height: 10.0,),

                    Text(
                      'Patient age: ${widget.callinfo['age']}',
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                    ),

                    const SizedBox(height: 10.0,),

                    Text(
                      'Problem: ${widget.callinfo['problem']}',
                      style: const TextStyle(
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

          const SizedBox(height: 30.0,),

          TextField(
            onChanged: (value) {
              presc = value;
            },
            decoration: InputDecoration(
              hintText: 'Give Advice and Medicine',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.green, width: 2)
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.green, width: 2)
              ),
            ),
            minLines: 5,
            maxLines: 20,

          ),

          const SizedBox(height: 30.0,),

          MaterialButton(
            onPressed: completeCall, 
            height: 50.0,
            textColor: Colors.white, 
            child: const Text('Complete Order'), 
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}