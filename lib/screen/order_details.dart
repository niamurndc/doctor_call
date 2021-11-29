import 'package:dio/dio.dart';
import 'package:doctor_call/screen/video_chat.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatefulWidget {
  final Map data ;
  
  OrderDetails(this.data);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  String token = '';
  String channel = '';
  String appId = '';


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

  @override
  void initState() {
    super.initState();
    getSomeKey();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details', 
          style: TextStyle(fontSize: 20.0, color: Colors.white)
        ),
        backgroundColor: Colors.green,
        elevation: 0.0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
        children: <Widget>[
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
                      'Call type: ${widget.data['type']}',
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    const SizedBox(height: 10.0,),
                    Text(
                      'Fees: ${widget.data['fees']}',
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    const SizedBox(height: 10.0,),
                    Text(
                      'Patient name: ${widget.data['name']}',
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                    ),

                    const SizedBox(height: 10.0,),

                    Text(
                      'Patient age: ${widget.data['age']}',
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                    ),

                    const SizedBox(height: 10.0,),

                    Text(
                      'Phone No.: ${widget.data['phone']}',
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                    ),

                    const SizedBox(height: 10.0,),

                    Text(
                      'Problem: ${widget.data['problem']}',
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                    ),

                    const SizedBox(height: 20.0,),

                    (widget.data['status'] == 1) ? MaterialButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => VideoCaht(token, channel)));
                      },
                      height: 50.0,
                      textColor: Colors.white, 
                      child: Text(widget.data['type']), 
                      color: Colors.green,
                    ) : (widget.data['status'] == 0) ? 
                    const Text(
                      'Status: Not Accepted',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.red,
                      ),
                    ) : 
                    const Text(
                      'Status: Complete',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.green,
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

        ],
      ),
    );
  }
}