import 'package:flutter/material.dart';

class TransactionAuthDialog extends StatefulWidget {
  TransactionAuthDialog({Key? key, required this.onClick}) : super(key: key);

  final Function(String password) onClick;

  @override
  State<TransactionAuthDialog> createState() => _TransactionAuthDialogState();
}

class _TransactionAuthDialogState extends State<TransactionAuthDialog> {
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Authenticate'),
      content: TextField(
        obscureText: true,
        maxLength: 4,
        controller: passwordController,
        decoration: const InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: const TextStyle(
          fontSize: 64,
          letterSpacing: 20,
        ),
      ),
      actions: [
        TextButton(
          onPressed: (() {
            Navigator.pop(context);
          }),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: (() {
            widget.onClick(passwordController.text);
            Navigator.pop(context);
          }),
          child: Text('Confirm'),
        ),
      ],
    );
  }
}
