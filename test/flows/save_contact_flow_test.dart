import 'package:bytebank_app/database/dao/contact_dao.dart';
import 'package:bytebank_app/main.dart';
import 'package:bytebank_app/models/contact.dart';
import 'package:bytebank_app/screens/contact_form.dart';
import 'package:bytebank_app/screens/contacts_list.dart';
import 'package:bytebank_app/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../matchers.dart';
import 'save_contact_flow_test.mocks.dart';

@GenerateMocks([ContactDao])
void main() {
  testWidgets(
    'Should pass through the Save Contact Flow',
    (WidgetTester tester) async {
      final mockContactDao = MockContactDao();
      when(mockContactDao.findAll()).thenAnswer((_) async => <Contact>[]);
      when(mockContactDao.save(any)).thenAnswer((_) async => 1);

      await tester.pumpWidget(BytebankApp(
        contactDao: mockContactDao,
      ));

      final dash = find.byType(Dashboard);
      expect(dash, findsOneWidget);

      final transferFeatureItem = find.byWidgetPredicate((widget) =>
          featureItemMatcher(widget, 'Transfer', Icons.monetization_on));
      expect(transferFeatureItem, findsOneWidget);

      await tester.tap(transferFeatureItem);
      await tester.pumpAndSettle();

      final contactsListScreen = find.byType(ContactsList);
      expect(contactsListScreen, findsOneWidget);

      verify(mockContactDao.findAll()).called(1);

      final fapContactForm =
          find.widgetWithIcon(FloatingActionButton, Icons.add);
      expect(fapContactForm, findsWidgets);

      await tester.tap(fapContactForm);
      await tester.pumpAndSettle();

      final contactForm = find.byType(ContactForm);
      expect(contactForm, findsOneWidget);

      final nameTextField = find.byWidgetPredicate(
          (widget) => contactFormTextFieldMatcher(widget, 'Full name'));
      expect(nameTextField, findsOneWidget);
      await tester.enterText(nameTextField, 'Gabriel');

      final accountNumberTextField = find.byWidgetPredicate(
          (widget) => contactFormTextFieldMatcher(widget, 'Account number'));
      await tester.enterText(accountNumberTextField, '1649');

      final createContactButton = find.widgetWithText(ElevatedButton, 'Create');
      expect(createContactButton, findsOneWidget);
      await tester.tap(createContactButton);
      await tester.pumpAndSettle();

      verify(mockContactDao.save(any));

      final contactsListBack = find.byType(ContactsList);
      expect(contactsListBack, findsOneWidget);

      verify(mockContactDao.findAll()).called(1);
    },
  );
}
