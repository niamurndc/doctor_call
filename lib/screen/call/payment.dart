import 'package:doctor_call/screen/call/failed.dart';
import 'package:doctor_call/screen/call/success.dart';
import 'package:flutter/material.dart';
import 'package:aamarpay/aamarpay.dart';

class PaymentPage extends StatefulWidget {
  String name;
  String phone;
  String age;
  String problem;
  String type;
  int fees;

  PaymentPage(this.name, this.phone, this.age, this.problem, this.type, this.fees);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool isLoading = false;

  var rnum = DateTime.now().millisecondsSinceEpoch ~/ 10000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AamarpayData(
            returnUrl: (url) {
              print('this is payment url: $url');
            },
            isLoading: (v) {
              setState(() {
                isLoading = v;
              });
            },
            paymentStatus: (status) {
              print('this is payment status: $status');
              if(status == 'success'){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Success(widget.name, widget.phone, widget.age, widget.problem, widget.type, widget.fees)));
              }else{
                
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Failed()));
              }
            },
            cancelUrl: "https://amrdoctor.com/payment/cancel",
            successUrl: "https://amrdoctor.com/payment/confirm",
            failUrl: "https://amrdoctor.com/payment/fail",
            customerEmail: "amrdoctorbd@gmail.com",
            customerMobile: widget.phone,
            customerName: widget.name,
            signature: "e4fff2de8adb299d9abff68abed616f9",
            storeID: "amrdoctor",
            transactionAmount: widget.fees,
            transactionID: "AD$rnum",
            description: "Payment for call",
            url: "https://secure.aamarpay.com",
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                  padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                    color: Colors.green,
                    height: 50,
                    child: const Center(
                        child: Text(
                      "Payment",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    )),
                  )),
      ),
    );
  }
}