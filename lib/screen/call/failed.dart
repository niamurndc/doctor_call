import 'package:flutter/material.dart';

class Failed extends StatelessWidget {
  const Failed({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Failed', 
          style: TextStyle(fontSize: 20.0, color: Colors.white)
        ),
        backgroundColor: Colors.green,
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          children: [
            const Text('Order Failed', style: TextStyle(fontSize: 35.0, color: Colors.red)),
            MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            }, 
            height: 50.0,
            textColor: Colors.white, 
            child: const Text('Try Again'), 
            color: Colors.red,
          ),
          ],
        ),
      ),
      
    );
  }
}