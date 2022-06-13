import 'package:bytebank_app/components/transaction_auth_dialog.dart';
import 'package:bytebank_app/screens/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BytebankApp());
}

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green[900],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green[900],
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.green[900],
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: Dashboard(),
    );
  }
}
