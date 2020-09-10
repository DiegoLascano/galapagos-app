import 'package:flutter/material.dart';
import 'package:galapagos_touring/color_swatches.dart';
import 'package:galapagos_touring/screens/auth_check_screen.dart';
import 'package:galapagos_touring/services/auth/auth_interface.dart';
import 'package:galapagos_touring/services/auth/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthInterface>(
      create: (_) => Auth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: AuthCheckScreen(),
        theme: ThemeData(
          // brightness: Brightness.light,
          textTheme: GoogleFonts.sourceSansProTextTheme(),
          primarySwatch: tealVividSwatch,
          // accentColor: yellowVividSwatch[600],
        ),
      ),
    );
  }
}
