
import 'package:doctor_call/screen/call/payment.dart';
import 'package:flutter/material.dart';


class ConfirmPage extends StatefulWidget {

  String name;
  String phone;
  String age;
  String problem;
  String type;
  int fees;

  ConfirmPage(this.name, this.phone, this.age, this.problem, this.type, this.fees);

  
  @override
  _ConfirmPageState createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Order', 
          style: TextStyle(fontSize: 20.0, color: Colors.white)
        ),
        backgroundColor: Colors.green,
        elevation: 0.0,
      ),
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
                      'Call type: ${widget.type}',
                      style: const TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                    const SizedBox(height: 10.0,),
                    Text(
                      'Fees: ${widget.fees}',
                      style: const TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                    const SizedBox(height: 10.0,),
                    Text(
                      'Patient name: ${widget.name}',
                      style: const TextStyle(
                        fontSize: 25.0,
                      ),
                    ),

                    const SizedBox(height: 10.0,),

                    Text(
                      'Patient age: ${widget.age}',
                      style: const TextStyle(
                        fontSize: 25.0,
                      ),
                    ),

                    const SizedBox(height: 10.0,),

                    Text(
                      'Phone No.: ${widget.phone}',
                      style: const TextStyle(
                        fontSize: 25.0,
                      ),
                    ),

                    const SizedBox(height: 10.0,),

                    Text(
                      'Problem: ${widget.problem}',
                      style: const TextStyle(
                        fontSize: 25.0,
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

          MaterialButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage(widget.name, widget.phone, widget.age, widget.problem, widget.type, widget.fees)));
            }, 
            height: 50.0,
            textColor: Colors.white, 
            child: const Text('Confirm Order'), 
            color: Colors.green,
          ),

          const SizedBox(height: 20.0,),

          const Text(
            'Please Check and Confirm order', 
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.red
            ),
          ),
        ],
      ),
    );
  }
}