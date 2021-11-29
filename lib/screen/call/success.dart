import 'package:dio/dio.dart';
import 'package:doctor_call/screen/call/failed.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Success extends StatefulWidget {
  String name;
  String phone;
  String age;
  String problem;
  String type;
  int fees;

  Success(this.name, this.phone, this.age, this.problem, this.type, this.fees);

  @override
  _SuccessState createState() => _SuccessState();
}

class _SuccessState extends State<Success> {

  var uid = '';
  var token ;
  var isload = true;

  @override
  void initState() {
    super.initState();
    getPhone();

  }

  void getPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
    });
    createNewCall();
  }



  void createNewCall() async {
    var dio = Dio();

    var response = await dio.post(
      "https://amrdoctor.com/api/call/create",
      data: {
        'name' : widget.name,
        'phone' : widget.phone,
        'age' : widget.age,
        'problem' : widget.problem,
        'type' : widget.type,
        'fees' : widget.fees
      },
      options: Options(headers: {
        'Content-Type': 'application/json',
        'Accept' : 'application/json',
        'Authorization' : 'Bearer $token'
      })
    );

    if(response.statusCode == 200){

      setState(() {
        isload = false;
      });
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Failed()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Success', 
          style: TextStyle(fontSize: 20.0, color: Colors.white)
        ),
        backgroundColor: Colors.green,
        elevation: 0.0,
      ),
      body: isload ? 
      const Center(child: CircularProgressIndicator(),) : 
      Center(
        child: Column(
          children: const [
            SizedBox(height: 70.0,),
            Text('আপনার অর্ডার টি সফল হয়েছে', textAlign: TextAlign.center, style: TextStyle(fontSize: 35.0, color: Colors.green)),
            Text('অনুগ্রহ করে অপেক্ষা করুন, কিচ্ছুক্ষন পর আপনি ডাক্তার কে দেখতে পাবেন, কল শেষ না হওয়া পর্যন্ত এই স্ক্রিন থেকে যাবেন না।', textAlign: TextAlign.center, style: TextStyle(fontSize: 16.0, color: Colors.red)),
            SizedBox(height: 40.0,), 
            Text('অনুগ্রহ করে অপেক্ষা করুন', textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}