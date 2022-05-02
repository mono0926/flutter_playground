import 'dart:io';

import 'package:desktop_webview_auth/desktop_webview_auth.dart';
import 'package:desktop_webview_auth/google.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: (!kIsWeb && Platform.isMacOS)
          ? const _HomePageForMac()
          : const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

const _webClientId =
    '411503049546-hh9ncrvidn4pvi07leu61mdvoqib0fkl.apps.googleusercontent.com';

class _HomePageState extends State<HomePage> {
  final _googleSignIn = GoogleSignIn(
    scopes: ['email'],
    // fir-fir-mono project
    clientId: !kIsWeb && Platform.isIOS
        ? '411503049546-4gfgu18j1b16t2i11682ida12n90lm3t.apps.googleusercontent.com'
        : _webClientId,
  );
  GoogleSignInAccount? _account;
  @override
  Widget build(BuildContext context) {
    final account = _account;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          account == null ? 'Signed out' : 'Name: ${account.displayName}',
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ElevatedButton(
          onPressed: () async {
            if (account == null) {
              _account = await _googleSignIn.signIn();
            } else {
              await _googleSignIn.signOut();
              _account = null;
            }
            setState(() {});
          },
          child: Text(account == null ? 'Sign In' : 'Sign Out'),
        ),
      ),
    );
  }
}

class _HomePageForMac extends StatefulWidget {
  const _HomePageForMac({Key? key}) : super(key: key);
  @override
  __HomePageForMacState createState() => __HomePageForMacState();
}

class __HomePageForMacState extends State<_HomePageForMac> {
  String? _token;
  @override
  Widget build(BuildContext context) {
    final token = _token;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          token == null ? 'Signed out' : 'Token: $token',
          overflow: TextOverflow.fade,
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ElevatedButton(
          onPressed: () async {
            if (_token == null) {
              final result = await DesktopWebviewAuth.signIn(
                GoogleSignInArgs(
                  clientId: _webClientId,
                  redirectUri:
                      'https://fir-fir-mono.firebaseapp.com/__/auth/handler',
                  scope: 'email',
                ),
              );
              if (result != null) {
                setState(() {
                  _token = result.idToken;
                });
              }
            } else {
              _token = null;
            }
            setState(() {});
          },
          child: Text(token == null ? 'Sign In' : 'Sign Out'),
        ),
      ),
    );
  }
}
