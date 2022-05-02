import 'dart:io';

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
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
    // fir-fir-mono project
    clientId: !kIsWeb && (Platform.isIOS || Platform.isMacOS)
        ? '411503049546-4gfgu18j1b16t2i11682ida12n90lm3t.apps.googleusercontent.com'
        : '411503049546-hh9ncrvidn4pvi07leu61mdvoqib0fkl.apps.googleusercontent.com',
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
      body: ElevatedButton(
        onPressed: () async {
          if (account == null) {
            _account = await _googleSignIn.signIn();
          } else {
            await _googleSignIn.signOut();
            _account = null;
          }
          setState(() {});
        },
        child: Text(account == null ? 'Sign Out' : 'Sign In'),
      ),
    );
  }
}
