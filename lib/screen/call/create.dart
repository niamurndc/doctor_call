import 'package:doctor_call/screen/call/confirm.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CreateCall extends StatefulWidget {

  CreateCall(this.type, this.fees);

  final String type;
  final int fees;

  @override
  _CreateCallState createState() => _CreateCallState();
}

class _CreateCallState extends State<CreateCall> {

  String _name = '';
  var _phone ;
  String _age = '';
  String _problem = '';

  @override
  void initState() {
    super.initState();
    getPhone();
  }

  void getPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _phone = prefs.getString('phone');
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Book Appointment',
          style: TextStyle(color: Colors.white, )
        ),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(

              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (widget.type == 'Live Chat') ? Icon(Icons.chat, color: Colors.green, size: 40.0,) : 
                    (widget.type == 'Audio Call') ? Icon(Icons.call, color: Colors.green, size: 40.0,) : 
                    Icon(Icons.video_call, color: Colors.green, size: 40.0,),


                    Text(
                      widget.type,
                      style: const TextStyle(
                        color: Colors.black, 
                        fontSize: 25.0,
                      ),
                    ),

                    Text('Visit: ${widget.fees}', style: TextStyle(fontSize: 35.0, color: Colors.green),)
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
            onChanged: (value){
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
            onChanged: (value){
              _age = value;
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Age',
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
              _problem = value;
            },
            decoration: InputDecoration(
              hintText: 'Problem',
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

          MaterialButton(
            onPressed: () {
              if(_name == '' || _age == '' || _problem == ''){
                Fluttertoast.showToast(msg: 'All are required');
              }else{
                Navigator.push(context,
                  MaterialPageRoute(builder: 
                    (context) => ConfirmPage(_name, _phone, _age, _problem, widget.type, widget.fees)
                  )
                );
              }
            }, 
            textColor: Colors.white, 
            child: const Text('Submit'), 
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}