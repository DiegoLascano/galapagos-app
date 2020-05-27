import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:galapagos_touring/screens/auth/signin_screen.dart';
import 'package:galapagos_touring/screens/auth/signup_screen.dart';
import 'package:galapagos_touring/widgets/signin/signin_button.dart';
import 'package:galapagos_touring/widgets/signin/social_signin_button.dart';
import 'package:galapagos_touring/blocs/auth_bloc.dart';
import 'package:galapagos_touring/services/auth/auth_interface.dart';
import 'package:galapagos_touring/widgets/common/platform_exception_alert_dialog.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key key, @required this.bloc}) : super(key: key);
  final AuthBloc bloc;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthInterface>(context);
    return Provider<AuthBloc>(
      create: (_) => AuthBloc(auth: auth),
      dispose: (context, bloc) => bloc.dispose(),
      child: Consumer<AuthBloc>(
          builder: (context, bloc, _) => AuthScreen(bloc: bloc)),
    );
  }

  // TODO: implement in the next version release with Social Authentication
  // void _showSignInError(BuildContext context, PlatformException exception) {
  //   PlatformExceptionAlertDialog(
  //     title: 'Error al iniciar sesión',
  //     exception: exception,
  //   ).show(context);
  // }

  // TODO: implement in the next version release with Social Authentication
  // void _createUserWithEmail(BuildContext context) {
  //   Navigator.of(context).push(
  //     MaterialPageRoute<void>(
  //       fullscreenDialog: true,
  //       builder: (context) => SignUpScreen.create(context),
  //     ),
  //   );
  // }

  // TODO: implement in the next version release with Social Authentication
  // void _signInWithEmail(BuildContext context) {
  //   Navigator.of(context).push(
  //     MaterialPageRoute<void>(
  //       fullscreenDialog: true,
  //       builder: (context) => SignInScreen.create(context),
  //     ),
  //   );
  // }

  // TODO: implement in the next version release with Social Authentication
  // Future<void> _signInWithGoogle(BuildContext context) async {
  //   try {
  //     await bloc.signInWithGoogle();
  //   } on PlatformException catch (e) {
  //     if (e.code != 'ERROR_ABORTED_BY_USER') {
  //       _showSignInError(context, e);
  //     }
  //   }
  // }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await bloc.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: StreamBuilder(
            stream: bloc.isLoadingStream,
            initialData: false,
            builder: (context, snapshot) {
              final isLoading = snapshot.data;
              // if (isLoading) {
              //   return Center(
              //     child: CircularProgressIndicator(),
              //   );
              // } else {
              return Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      // TODO: implement in the next version release instead of SifezBox
                      // _createLoginButton(context),
                      SizedBox(height: 20.0),
                      Text('This is the title'),
                      SizedBox(height: 20.0),
                      Expanded(
                        child: _createCardSwiper(),
                      ),
                      SizedBox(height: 20.0),
                      _createRegisterButtons(context, isLoading),
                      SizedBox(height: 80.0),
                    ],
                  ),
                  (isLoading)
                      ? Stack(
                          children: <Widget>[
                            Opacity(
                              opacity: 0.3,
                              child: const ModalBarrier(
                                dismissible: false,
                                color: Colors.grey,
                              ),
                            ),
                            Center(child: CircularProgressIndicator()),
                          ],
                        )
                      : Container(),
                ],
              );
              // }
            },
          ),
        ),
      ),
    );
  }

  // TODO: implement in the next version release
  // Widget _createLoginButton(BuildContext context) {
  //   return Align(
  //     alignment: Alignment.centerRight,
  //     child: FlatButton(
  //       shape:
  //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
  //       child: Text(
  //         'Ingresar',
  //         style: TextStyle(color: Theme.of(context).primaryColor),
  //       ),
  //       onPressed: () => _signInWithEmail(context),
  //     ),
  //   );
  // }

  Widget _createCardSwiper() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: SvgPicture.asset(
        'assets/svg/through_the_park.svg',
        // color: Colors.purpleAccent,
        // colorBlendMode: BlendMode.darken,
      ),
    );
  }

  Widget _createRegisterButtons(BuildContext context, bool isLoading) {
    return Column(
      children: <Widget>[
        // TODO: implement in the next version release
        // Container(
        //   margin: EdgeInsets.symmetric(horizontal: 40.0),
        //   width: double.infinity,
        //   child: SignInButton(
        //     text: 'Registrar Nueva Cuenta',
        //     textColor: Colors.white,
        //     color: Theme.of(context).primaryColor,
        //     disabledColor: Theme.of(context).primaryColorLight,
        //     onPressed: isLoading ? null : () => _createUserWithEmail(context),
        //   ),
        // ),
        // TODO: verify a valid facebook package
        // SizedBox(height: 10.0),
        // Container(
        //   margin: EdgeInsets.symmetric(horizontal: 40.0),
        //   width: double.infinity,
        //   child: SocialSignInButton(
        //     text: 'Continuar con Facebook',
        //     color: Colors.grey[350],
        //     imagePath: 'assets/logos/facebook-logo.png',
        //     disabledColor: Theme.of(context).disabledColor,
        //     onPressed: isLoading ? null : () {},
        //   ),
        // ),
        // TODO: implement in the next version release
        // SizedBox(height: 10.0),
        // Container(
        //   margin: EdgeInsets.symmetric(horizontal: 40.0),
        //   width: double.infinity,
        //   child: SocialSignInButton(
        //     text: 'Continuar con Google',
        //     color: Colors.grey[350],
        //     imagePath: 'assets/logos/google-logo.png',
        //     disabledColor: Theme.of(context).disabledColor,
        //     onPressed: isLoading ? null : () => _signInWithGoogle(context),
        //   ),
        // ),
        // SizedBox(height: 10.0),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 40.0),
          width: double.infinity,
          child: SignInButton(
            text: 'Comencemos',
            textColor: Colors.white,
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorLight,
            onPressed: isLoading ? null : () => _signInAnonymously(context),
          ),
        ),
      ],
    );
  }
}
