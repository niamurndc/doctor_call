import 'package:doctor_call/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Signup extends StatefulWidget {

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  
  String _name = '';
  String _phone = '';
  String _password = '';


  void createUser() async {
    var dio = Dio();

    if(_name == '' || _phone == '' || _password == ''){
      Fluttertoast.showToast(msg: 'All are required');
    }else{

      if(_phone.length != 11){
        Fluttertoast.showToast(msg: 'Phone must be 11 digit');  
      }else{

        if(_password.length < 6){
          Fluttertoast.showToast(msg: 'Password minimum 6 digit');  
        }else{
          var response = await dio.post('https://amrdoctor.com/api/register', data: {
            "name" : _name,
            "phone" : _phone,
            "password" : _password,
          });

          if(response.statusCode == 200){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
          }
        }
      }
    }
    
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          children: [

            Image.asset(
              'images/logo.png',
              height: 200,
              width: 200,
            ),
            

            const Text('Registration',
              style: TextStyle(color: Colors.green, fontSize: 30.0, fontWeight: FontWeight.bold,),
            ),


            const SizedBox(height: 30.0,),

            TextField(
              onChanged: (value) {
                _name = value;
              },
              decoration: InputDecoration(
                hintText: 'Name',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.green, width: 2)
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.green, width: 2)
                ),
              ),
            ),

            const SizedBox(height: 30.0,),

            TextField(
              onChanged: (value) {
                _phone = value;
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'phone',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.green, width: 2)
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.green, width: 2)
                ),
              ),
            ),

            const SizedBox(height: 30.0,),

            TextField(
              onChanged: (value) {
                _password = value;
              },
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.green, width: 2)
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.green, width: 2)
                ),
              ),
            ),

            const SizedBox(height: 40.0,),

            MaterialButton(
              onPressed: createUser, 
              textColor: Colors.white, 
              child: const Text('Register'), 
              color: Colors.green,
            ),
            
            MaterialButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
              }, 
              textColor: Colors.green, 
              child: const Text('Login'), 
              color: Colors.white,
            ),
          ],
        ),
        )
    );
  }
}