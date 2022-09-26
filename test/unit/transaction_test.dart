import 'package:bytebank_app/models/contact.dart';
import 'package:bytebank_app/models/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Should return transaction's value", () {
    final transaction = Transaction('null', 250, Contact(null, 'name', 0));
    expect(transaction.value, 250);
  });
  test('Should throw an error when create a transaction with negative value',
      (() {
    expect(() => Transaction('null', 0, Contact(null, 'name', 0)),
        throwsAssertionError);
  }));
}
