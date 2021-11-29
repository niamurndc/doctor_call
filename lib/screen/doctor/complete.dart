import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompleteOrder extends StatefulWidget {
  const CompleteOrder({ Key? key }) : super(key: key);

  @override
  _CompleteOrderState createState() => _CompleteOrderState();
}

class _CompleteOrderState extends State<CompleteOrder> {
  List allcalls = [];

  void getallcall() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var token = prefs.getString('token');
    
    var dio = Dio();
    var response = await dio.get(
      'https://amrdoctor.com/api/complete-calls',
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
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Orders'),
        elevation: 0.0,
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
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold
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
                              const SizedBox(height: 5.0,),
                              Text(
                                'Fees: ${data['fees']}', 
                                style: const TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              const SizedBox(height: 5.0,),
                              Text(
                                'Completed: ${data['updated_at']}', 
                                style: const TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              const SizedBox(height: 5.0,),
                              const Text(
                                'Prescription:', 
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                '${data['presc']}', 
                                style: const TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),

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