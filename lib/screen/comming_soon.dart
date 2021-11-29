import 'package:flutter/material.dart';

class CommingSoon extends StatelessWidget {
  const CommingSoon({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coming Soon', ),
        backgroundColor: Colors.green,
        elevation: 0.0,
      ),
      body: const Center(
        child: Text('Comming Soon...', style: TextStyle(fontSize: 35.0, color: Colors.grey)),
      ),
      
    );
  }
}