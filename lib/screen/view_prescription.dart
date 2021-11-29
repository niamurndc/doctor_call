import 'package:flutter/material.dart';

class ViewPrescription extends StatelessWidget {
  final Map data ;
  
  ViewPrescription(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prescription Details', 
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
                      'Call type: ${data['type']}',
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                    ),

                    const SizedBox(height: 10.0,),
                    Text(
                      'Patient name: ${data['name']}',
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                    ),

                    const SizedBox(height: 10.0,),

                    Text(
                      'Patient age: ${data['age']}',
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                    ),

                    const SizedBox(height: 10.0,),

                    Text(
                      'Problem: ${data['problem']}',
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                    ),

                    const SizedBox(height: 20.0,),

                    const Text(
                      'Prescriptions',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),

                    Text(
                      '${data['presc']}',
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

        ],
      ),
    );
  }
}