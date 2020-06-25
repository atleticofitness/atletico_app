// This file has been generated by the reflectable package.
// https://github.com/dart-lang/reflectable.

import 'dart:core';
import 'package:atletico_app/endpoints/users/users.dart' as prefix1;
import 'package:dart_json_mapper/src/model/annotations.dart' as prefix0;

// ignore_for_file: prefer_adjacent_string_concatenation
// ignore_for_file: prefer_collection_literals
// ignore_for_file: unnecessary_const
// ignore_for_file: implementation_imports

// ignore:unused_import
import 'package:reflectable/mirrors.dart' as m;
// ignore:unused_import
import 'package:reflectable/src/reflectable_builder_based.dart' as r;
// ignore:unused_import
import 'package:reflectable/reflectable.dart' as r show Reflectable;

final _data = <r.Reflectable, r.ReflectorData>{
  const prefix0.JsonSerializable(): r.ReflectorData(
      <m.TypeMirror>[
        r.NonGenericClassMirrorImpl(
            r'User',
            r'.User',
            7,
            0,
            const prefix0.JsonSerializable(),
            const <int>[0, 1, 2, 3, 4, 5, 6, 7, 17],
            const <int>[18, 19, 20, 21, 22, 9, 10, 11, 12, 13, 14, 15, 16],
            const <int>[],
            -1,
            {},
            {},
            {
              r'': (b) => (
                      {id,
                      email,
                      username,
                      password,
                      firstName,
                      lastName,
                      dateOfBirth,
                      isActive}) =>
                  b
                      ? prefix1.User(
                          dateOfBirth: dateOfBirth,
                          email: email,
                          firstName: firstName,
                          id: id,
                          isActive: isActive,
                          lastName: lastName,
                          password: password,
                          username: username)
                      : null
            },
            -1,
            0,
            const <int>[],
            const <Object>[prefix0.jsonSerializable],
            null),
        r.NonGenericClassMirrorImpl(
            r'CheckEmail',
            r'.CheckEmail',
            7,
            1,
            const prefix0.JsonSerializable(),
            const <int>[8, 24],
            const <int>[18, 19, 20, 21, 22, 23],
            const <int>[],
            -1,
            {},
            {},
            {
              r'': (b) => ({validEmail}) =>
                  b ? prefix1.CheckEmail(validEmail: validEmail) : null
            },
            -1,
            1,
            const <int>[],
            const <Object>[prefix0.jsonSerializable],
            null)
      ],
      <m.DeclarationMirror>[
        r.VariableMirrorImpl(r'id', 33797, 0, const prefix0.JsonSerializable(),
            -1, 2, 2, const <int>[], const []),
        r.VariableMirrorImpl(
            r'email',
            33797,
            0,
            const prefix0.JsonSerializable(),
            -1,
            3,
            3, const <int>[], const []),
        r.VariableMirrorImpl(
            r'username',
            33797,
            0,
            const prefix0.JsonSerializable(),
            -1,
            3,
            3, const <int>[], const []),
        r.VariableMirrorImpl(
            r'password',
            33797,
            0,
            const prefix0.JsonSerializable(),
            -1,
            3,
            3, const <int>[], const []),
        r.VariableMirrorImpl(
            r'firstName',
            33797,
            0,
            const prefix0.JsonSerializable(),
            -1,
            3,
            3, const <int>[], const []),
        r.VariableMirrorImpl(
            r'lastName',
            33797,
            0,
            const prefix0.JsonSerializable(),
            -1,
            3,
            3, const <int>[], const []),
        r.VariableMirrorImpl(
            r'dateOfBirth',
            33797,
            0,
            const prefix0.JsonSerializable(),
            -1,
            4,
            4, const <int>[], const []),
        r.VariableMirrorImpl(
            r'isActive',
            33797,
            0,
            const prefix0.JsonSerializable(),
            -1,
            5,
            5, const <int>[], const []),
        r.VariableMirrorImpl(
            r'validEmail',
            33797,
            1,
            const prefix0.JsonSerializable(),
            -1,
            5,
            5, const <int>[], const []),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 0, 9),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 1, 10),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 2, 11),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 3, 12),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 4, 13),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 5, 14),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 6, 15),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 7, 16),
        r.MethodMirrorImpl(
            r'',
            0,
            0,
            -1,
            0,
            0,
            const <int>[],
            const <int>[0, 1, 2, 3, 4, 5, 6, 7],
            const prefix0.JsonSerializable(),
            const []),
        r.MethodMirrorImpl(r'==', 131074, null, -1, 5, 5, const <int>[],
            const <int>[8], const prefix0.JsonSerializable(), const []),
        r.MethodMirrorImpl(r'toString', 131074, null, -1, 3, 3, const <int>[],
            const <int>[], const prefix0.JsonSerializable(), const []),
        r.MethodMirrorImpl(
            r'noSuchMethod',
            65538,
            null,
            null,
            null,
            null,
            const <int>[],
            const <int>[9],
            const prefix0.JsonSerializable(),
            const []),
        r.MethodMirrorImpl(r'hashCode', 131075, null, -1, 2, 2, const <int>[],
            const <int>[], const prefix0.JsonSerializable(), const []),
        r.MethodMirrorImpl(
            r'runtimeType',
            131075,
            null,
            -1,
            6,
            6,
            const <int>[],
            const <int>[],
            const prefix0.JsonSerializable(),
            const []),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 8, 23),
        r.MethodMirrorImpl(r'', 0, 1, -1, 1, 1, const <int>[], const <int>[10],
            const prefix0.JsonSerializable(), const [])
      ],
      <m.ParameterMirror>[
        r.ParameterMirrorImpl(
            r'id',
            45062,
            17,
            const prefix0.JsonSerializable(),
            -1,
            2,
            2,
            const <int>[],
            const [],
            null,
            #id),
        r.ParameterMirrorImpl(
            r'email',
            45062,
            17,
            const prefix0.JsonSerializable(),
            -1,
            3,
            3,
            const <int>[],
            const [],
            null,
            #email),
        r.ParameterMirrorImpl(
            r'username',
            45062,
            17,
            const prefix0.JsonSerializable(),
            -1,
            3,
            3,
            const <int>[],
            const [],
            null,
            #username),
        r.ParameterMirrorImpl(
            r'password',
            45062,
            17,
            const prefix0.JsonSerializable(),
            -1,
            3,
            3,
            const <int>[],
            const [],
            null,
            #password),
        r.ParameterMirrorImpl(
            r'firstName',
            45062,
            17,
            const prefix0.JsonSerializable(),
            -1,
            3,
            3,
            const <int>[],
            const [],
            null,
            #firstName),
        r.ParameterMirrorImpl(
            r'lastName',
            45062,
            17,
            const prefix0.JsonSerializable(),
            -1,
            3,
            3,
            const <int>[],
            const [],
            null,
            #lastName),
        r.ParameterMirrorImpl(
            r'dateOfBirth',
            45062,
            17,
            const prefix0.JsonSerializable(),
            -1,
            4,
            4,
            const <int>[],
            const [],
            null,
            #dateOfBirth),
        r.ParameterMirrorImpl(
            r'isActive',
            45062,
            17,
            const prefix0.JsonSerializable(),
            -1,
            5,
            5,
            const <int>[],
            const [],
            null,
            #isActive),
        r.ParameterMirrorImpl(
            r'other',
            16390,
            18,
            const prefix0.JsonSerializable(),
            null,
            null,
            null,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'invocation',
            32774,
            20,
            const prefix0.JsonSerializable(),
            -1,
            7,
            7,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'validEmail',
            45062,
            24,
            const prefix0.JsonSerializable(),
            -1,
            5,
            5,
            const <int>[],
            const [],
            null,
            #validEmail)
      ],
      <Type>[
        prefix1.User,
        prefix1.CheckEmail,
        int,
        String,
        DateTime,
        bool,
        Type,
        Invocation
      ],
      2,
      {
        r'==': (dynamic instance) => (x) => instance == x,
        r'toString': (dynamic instance) => instance.toString,
        r'noSuchMethod': (dynamic instance) => instance.noSuchMethod,
        r'hashCode': (dynamic instance) => instance.hashCode,
        r'runtimeType': (dynamic instance) => instance.runtimeType,
        r'id': (dynamic instance) => instance.id,
        r'email': (dynamic instance) => instance.email,
        r'username': (dynamic instance) => instance.username,
        r'password': (dynamic instance) => instance.password,
        r'firstName': (dynamic instance) => instance.firstName,
        r'lastName': (dynamic instance) => instance.lastName,
        r'dateOfBirth': (dynamic instance) => instance.dateOfBirth,
        r'isActive': (dynamic instance) => instance.isActive,
        r'validEmail': (dynamic instance) => instance.validEmail
      },
      {},
      null,
      [])
};

final _memberSymbolMap = null;

void initializeReflectable() {
  r.data = _data;
  r.memberSymbolMap = _memberSymbolMap;
}
