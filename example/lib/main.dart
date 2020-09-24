import 'package:flutter/material.dart';
import 'package:flutter_momo/flutter_momo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _result = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('MoMo Example'),
        ),
        body: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                RaisedButton(
                    onPressed: () async {
                      final paymentInfo = PaymentInfo(
                          merchantCode: '',
                          merchantName: '',
                          partnerCode: '',
                          amount: 1,
                          appScheme: '',
                          description: '',
                          isTestMode: true,
                          orderId: '');
                      final paymentResponse =
                          await FlutterMomo.requestPayment(paymentInfo);
                      setState(() {
                        _result = paymentResponse.toString();
                      });
                    },
                    child: Text('REQUEST PAYMENT',
                        style: TextStyle(fontSize: 17))),
                SizedBox(height: 24),
                Text('Payment Response:\n$_result')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
