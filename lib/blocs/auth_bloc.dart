import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:galapagos_touring/services/auth/auth_interface.dart';
import 'package:galapagos_touring/services/auth/user.dart';

class AuthBloc {
  AuthBloc({@required this.auth});
  final AuthInterface auth;

  final StreamController<bool> _isLoadingController = StreamController<bool>();

  Stream<bool> get isLoadingStream => _isLoadingController.stream;
  void _setIsLoading(bool isLoading) => _isLoadingController.add(isLoading);

  Future<User> _authenticate(Future<User> Function() authMethod) async {
    try {
      _setIsLoading(true);
      return await authMethod();
    } catch (e) {
      _setIsLoading(false);
      rethrow;
    }
  }

  Future<User> signInAnonymously() async =>
      await _authenticate(auth.signInAnonymously);
  Future<User> signInWithGoogle() async =>
      await _authenticate(auth.signInWithGoogle);

  void dispose() {
    _isLoadingController.close();
  }
}
