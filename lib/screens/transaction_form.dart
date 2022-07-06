import 'dart:async';

import 'package:bytebank_app/components/progress.dart';
import 'package:bytebank_app/components/response_dialog.dart';
import 'package:bytebank_app/components/transaction_auth_dialog.dart';
import 'package:bytebank_app/http/webclients/transaction_webclient.dart';
import 'package:bytebank_app/models/contact.dart';
import 'package:bytebank_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  TransactionForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionWebClient _webClient = TransactionWebClient();
  final String transactionId = Uuid().v4();
  bool _sending = false;

  @override
  Widget build(BuildContext context) {
    print(transactionId);
    return Scaffold(
      appBar: AppBar(
        title: Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.contact.name,
                style: const TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: const TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Value'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: Text('Transfer'),
                    onPressed: () {
                      double? value = double.tryParse(_valueController.text);
                      if (value == null) {
                        showDialog(
                            context: context,
                            builder: (contextDialog) {
                              return FailureDialog("Value can't be null");
                            });
                      } else {
                        final transactionCreated = Transaction(
                          transactionId,
                          value,
                          widget.contact,
                        );
                        showDialog(
                            context: context,
                            builder: (contextDialog) {
                              return TransactionAuthDialog(
                                onClick: (String password) {
                                  _save(transactionCreated, password, context);
                                },
                              );
                            });
                      }
                    },
                  ),
                ),
              ),
              Visibility(
                visible: _sending,
                child: Progress(
                  message: 'Sending...',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _save(
    Transaction transactionCreated,
    String password,
    BuildContext context,
  ) async {
    setState(() {
      _sending = true;
    });
    final Transaction transaction =
        await _webClient.save(transactionCreated, password).catchError((e) {
      _showFailureMessage(context, message: e.message);
    }, test: (e) => e is HttpException).catchError((e) {
      _showFailureMessage(context,
          message: 'Timeout submitting the transaction.');
    }, test: (e) => e is TimeoutException).catchError((e) {
      _showFailureMessage(context);
    }, test: (e) => e is Exception).whenComplete(() {
      setState(() {
        _sending = false;
      });
    });

    _showSuccessfulMessage(transaction, context);
  }

  void _showSuccessfulMessage(
      Transaction transaction, BuildContext context) async {
    if (transaction != null) {
      await showDialog(
          context: context,
          builder: (contextDialog) {
            return SuccessDialog('Successful transaction');
          });

      Navigator.pop(context);
    }
  }

  void _showFailureMessage(BuildContext context,
      {String message = 'Unknown error.'}) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog(message);
        });
  }
}
