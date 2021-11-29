import 'package:doctor_call/screen/view_prescription.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Prescription extends StatefulWidget {
  Prescription(this.token);
  final token;

  @override
  _PrescriptionState createState() => _PrescriptionState();
}

class _PrescriptionState extends State<Prescription> {

  List allcalls = [];
  var token ;

  void getallcall() async{
    var dio = Dio();
    var response = await dio.get(
        'https://amrdoctor.com/api/prescs',
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
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Prescriptions'),
        elevation: 0.0,
      ),
      body:ListView.builder(
        itemCount: allcalls.length,
        itemBuilder: (BuildContext context, index){
          var data = allcalls[index];

            Map calldata = {
              'name' : data['name'],
              'age' : data['age'],
              'type' : data['type'],
              'presc' : data['presc'],
              'problem' : data['problem'],
              'id' : data['id'],
            };

          return Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPrescription(calldata)));
                  },
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

                                (data['status'] == 0) ? 
                                const Text(
                                  'Status: Not Reviced', 
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16.0,
                                  ),
                                ) : (data['status'] == 1) ?
                                const Text(
                                  'Status: Accepted', 
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16.0,
                                  ),
                                )
                                : 
                                const Text(
                                  'Status: Complete', 
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 16.0,
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
                ),
              );
        }
      )
               
    );
  }
}

