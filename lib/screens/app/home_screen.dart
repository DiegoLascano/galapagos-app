import 'package:flutter/material.dart';
import 'package:galapagos_touring/services/auth/auth_interface.dart';
import 'package:galapagos_touring/widgets/common/platform_alert_dialog.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthInterface>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final _signOutComfirmed = await PlatformAlertDialog(
      title: 'Cerrar sesión',
      content: 'Seguro que quieres cerrar sesión',
      defaultActionText: 'Cerrar Sesión',
      cancelActionText: 'Cancelar',
    ).show(context);
    if (_signOutComfirmed) _signOut(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          FlatButton(
            disabledTextColor: Colors.white60,
            textColor: Colors.white,
            onPressed: () => _confirmSignOut(context),
            child: Text(
              'Logout',
            ),
          )
        ],
      ),
    );
  }
}
