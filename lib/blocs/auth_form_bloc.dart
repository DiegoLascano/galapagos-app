import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/foundation.dart';

import 'package:galapagos_touring/services/auth/user.dart';
import 'package:galapagos_touring/services/auth/auth_interface.dart';
import 'package:galapagos_touring/blocs/validators.dart';

class AuthFormBloc with Validators {
  AuthFormBloc({@required this.auth});

  final AuthInterface auth;
  // Stream controllers changed to BehaviorSubject in order to use rxdart combine2
  final _nameController = BehaviorSubject<String>();
  final _lastNameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _signingController = BehaviorSubject<bool>.seeded(false);

  // Fetch data from stream
  Stream<String> get nameStream =>
      _nameController.stream.transform(validateName);
  Stream<String> get lastNameStream =>
      _lastNameController.stream.transform(validateLastName);
  Stream<String> get emailStream =>
      _emailController.stream.transform(validateEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validatePassword);
  Stream<bool> get signingStream => _signingController.stream;

  // Combine streams
  Stream<bool> get loginValidStream =>
      Rx.combineLatest3(emailStream, passwordStream, signingStream, (e, p, s) {
        return (s == true) ? false : true;
      });
  Stream<bool> get registerValidStream => Rx.combineLatest4(nameStream,
      lastNameStream, emailStream, passwordStream, (n, l, e, p) => true);

  // Insert values to the stream
  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeLastName => _lastNameController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(bool) get changeIsSigning => _signingController.sink.add;

  // Get last value of the streams
  String get name => _nameController.value;
  String get lastName => _lastNameController.value;
  String get email => _emailController.value;
  String get password => _passwordController.value;
  bool get isSigning => _signingController.value;

  Future<User> _authenticate(Future<User> Function() authMethod) async {
    try {
      changeIsSigning(true);
      return await authMethod();
    } catch (e) {
      changeIsSigning(false);
      rethrow;
    }
  }

  Future<User> signInWithEmailAndPassword() async => await _authenticate(
      () => auth.signInWithEmailAndPassword(email, password));
  Future<User> createUserWithEmailAndPassword() async => await _authenticate(
      () => auth.createUserWithEmailAndPassword(email, password));

  void dispose() {
    _nameController?.close();
    _lastNameController?.close();
    _emailController?.close();
    _passwordController?.close();
    _signingController?.close();
  }
}
