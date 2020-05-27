import 'package:flutter/material.dart';
import 'package:galapagos_touring/screens/auth_check_screen.dart';
import 'package:galapagos_touring/services/auth/auth_interface.dart';
import 'package:galapagos_touring/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final MaterialColor tealVividSwatch = const MaterialColor(
    0xFF079A82,
    const <int, Color>{
      50: const Color(0xFFF0FCF9),
      100: const Color(0xFFC6F7E9),
      200: const Color(0xFF8EEDD1),
      300: const Color(0xFF5FE3C0),
      400: const Color(0xFF2DCCA7),
      500: const Color(0xFF17B897),
      600: const Color(0xFF079A82),
      700: const Color(0xFF048271),
      800: const Color(0xFF016457),
      900: const Color(0xFF004440),
    },
  );

  @override
  Widget build(BuildContext context) {
    return Provider<AuthInterface>(
      create: (_) => Auth(),
      child: MaterialApp(
        title: 'Material App',
        home: AuthCheckScreen(),
        theme: ThemeData(
          primarySwatch: tealVividSwatch,
        ),
      ),
    );
  }
}
