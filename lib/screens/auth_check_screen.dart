/// This widget/page has no UI. It only evaluates if the user is signed in or not,
/// and based on that, redirects to the corresponding page, Home or SignIn

import 'package:flutter/material.dart';
import 'package:galapagos_touring/screens/auth/auth_screen.dart';
import 'package:galapagos_touring/screens/navigation/home_screen.dart';
import 'package:galapagos_touring/services/auth/auth_interface.dart';
import 'package:galapagos_touring/services/auth/user.dart';
import 'package:galapagos_touring/services/database/database_interface.dart';
import 'package:galapagos_touring/services/database/database_service.dart';

import 'package:provider/provider.dart';

class AuthCheckScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthInterface>(context, listen: false);

    return StreamBuilder<User>(
      stream: auth.onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return AuthScreen.create(context);
          } else {
            return Provider<Database>(
              create: (_) => FirestoreDatabase(uid: user.uid),
              child: HomeScreen(),
            );
          }
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
