import 'package:doctor_call/auth/register.dart';
import 'package:doctor_call/doctowrapper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String _phone = '';
  String _password = '';

  Future<void> loginUser() async {
    if(_phone == '' || _password == ''){
      Fluttertoast.showToast(msg: 'Phone & Password is required');
    }else{

      if(_phone.length != 11){
        Fluttertoast.showToast(msg: 'Phone must be 11 digit');  
      }else{

        if(_password.length < 6){
          Fluttertoast.showToast(msg: 'Password minimum 6 digit');  
        }else{

          SharedPreferences prefs = await SharedPreferences.getInstance();
          var dio = Dio();
          var response = await dio.post('https://amrdoctor.com/api/login', data: {
            "phone" : _phone,
            "password" : _password,
          });

          if(response.statusCode == 200){
            if(response.data['message'] != null){
              // wrong data
              Fluttertoast.showToast(msg: response.data['message']);
            }else{
              // correct data
              var data = response.data;
              var user = data['user'];
              prefs.setString('token', data['token']);
              prefs.setString('phone', user['phone']);
              prefs.setInt('role', user['role']);
              prefs.setInt('uid', user['id']);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const DoctorWrapper()));
            }
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
            

            const Text('Login',
              style: TextStyle(color: Colors.green, fontSize: 30.0, fontWeight: FontWeight.bold,),
            ),


            const SizedBox(height: 30.0,),

            TextField(
              onChanged: (value) {
                _phone = value;
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Phone',
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
              onChanged: (value){
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

            MaterialButton(onPressed: loginUser, textColor: Colors.white, child: Text('Login'), color: Colors.green,),
            MaterialButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Signup()));
              }, 
              textColor: Colors.green, 
              child: const Text('Sign Up'), 
              color: Colors.white,
            ),
          ],
        ),
        )
    );
  }
}