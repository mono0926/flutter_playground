// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAjXjl92rq2LrMpJAOV_LYnX-4p2sqlcHk',
    appId: '1:411503049546:web:5ef7383ef1f06bcb38dfb3',
    messagingSenderId: '411503049546',
    projectId: 'fir-fir-mono',
    authDomain: 'fir-fir-mono.firebaseapp.com',
    databaseURL: 'https://fir-fir-mono.firebaseio.com',
    storageBucket: 'fir-fir-mono.appspot.com',
    measurementId: 'G-MPDFTMR9WH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC68jwLKzJ8E61j40yCwRQeGeVIm4nO0kk',
    appId: '1:411503049546:android:0781670387fc62b838dfb3',
    messagingSenderId: '411503049546',
    projectId: 'fir-fir-mono',
    databaseURL: 'https://fir-fir-mono.firebaseio.com',
    storageBucket: 'fir-fir-mono.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC1cRlErkR2IFkaHdfhjFPARNQC02XCefU',
    appId: '1:411503049546:ios:8b4bd97f1d67264438dfb3',
    messagingSenderId: '411503049546',
    projectId: 'fir-fir-mono',
    databaseURL: 'https://fir-fir-mono.firebaseio.com',
    storageBucket: 'fir-fir-mono.appspot.com',
    androidClientId:
        '411503049546-fdeqtjv1jl7cjkkvn8sgi02limetqjh5.apps.googleusercontent.com',
    iosClientId:
        '411503049546-qru48i8knf4qj5kuuscqbpfh3geh5nkl.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterPlayground',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC1cRlErkR2IFkaHdfhjFPARNQC02XCefU',
    appId: '1:411503049546:ios:8b4bd97f1d67264438dfb3',
    messagingSenderId: '411503049546',
    projectId: 'fir-fir-mono',
    databaseURL: 'https://fir-fir-mono.firebaseio.com',
    storageBucket: 'fir-fir-mono.appspot.com',
    androidClientId:
        '411503049546-fdeqtjv1jl7cjkkvn8sgi02limetqjh5.apps.googleusercontent.com',
    iosClientId:
        '411503049546-qru48i8knf4qj5kuuscqbpfh3geh5nkl.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterPlayground',
  );
}
