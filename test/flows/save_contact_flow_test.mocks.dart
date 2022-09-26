// Mocks generated by Mockito 5.3.2 from annotations
// in bytebank_app/test/flows/save_contact_flow_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:bytebank_app/database/dao/contact_dao.dart' as _i2;
import 'package:bytebank_app/models/contact.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [ContactDao].
///
/// See the documentation for Mockito's code generation for more information.
class MockContactDao extends _i1.Mock implements _i2.ContactDao {
  MockContactDao() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<int> save(_i4.Contact? contact) => (super.noSuchMethod(
        Invocation.method(
          #save,
          [contact],
        ),
        returnValue: _i3.Future<int>.value(0),
      ) as _i3.Future<int>);
  @override
  _i3.Future<List<_i4.Contact>> findAll() => (super.noSuchMethod(
        Invocation.method(
          #findAll,
          [],
        ),
        returnValue: _i3.Future<List<_i4.Contact>>.value(<_i4.Contact>[]),
      ) as _i3.Future<List<_i4.Contact>>);
}
