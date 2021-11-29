import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Profile extends StatefulWidget {
  const Profile(this.token);

  final String token;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  Map user = {};
  String password = '';

  void getProfileInfo() async {
    var dio = Dio();
    var response = await dio.get('https://amrdoctor.com/api/profile',
      options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept' : 'application/json',
          'Authorization' : 'Bearer ${widget.token}'
        })
    );

    if(response.statusCode == 200){
      setState(() {
        user = response.data;
      });
    }
  }

  void updateProfile() async {
    var dio = Dio();

    if(password == ''){
      Fluttertoast.showToast(msg: 'Password is required');
    }else{
      if(password.length < 6){
        Fluttertoast.showToast(msg: 'Password must be 6 digit');
      }else{
        var response = await dio.post('https://amrdoctor.com/api/profile/update',
          data: {
            'password' : password,
            'name' : user['name']
          },
          options: Options(headers: {
              'Content-Type': 'application/json',
              'Accept' : 'application/json',
              'Authorization' : 'Bearer ${widget.token}'
            })
        );

        if(response.statusCode == 200){
          Fluttertoast.showToast(
            msg: 'Profile Updated',
          );
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getProfileInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Profile',),
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
                      'Name: ${user['name']}',
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                    ),

                    const SizedBox(height: 10.0,),
                    Text(
                      'Phone: ${user['phone']}',
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                    ),

                    
                    const SizedBox(height: 20.0,),
                    const Text(
                      'Change Password',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),

                    const SizedBox(height: 10.0,),

                    TextField(
                      onChanged: (value) {
                        password = value;
                      },
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

                    const SizedBox(height: 20.0,),

                    MaterialButton(
                      onPressed: updateProfile,
                      height: 40.0,
                      textColor: Colors.white, 
                      child: const Text('Update Profile'), 
                      color: Colors.green,
                    )



                    
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