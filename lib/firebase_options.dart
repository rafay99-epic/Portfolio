// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBStUH7MVMjr9btBvT4eOBanEIL84FhcvQ',
    appId: '1:182119041017:web:6c0c32d628d904621f9f28',
    messagingSenderId: '182119041017',
    projectId: 'portfolio-f4698',
    authDomain: 'portfolio-f4698.firebaseapp.com',
    storageBucket: 'portfolio-f4698.appspot.com',
    measurementId: 'G-EYJ05RYC30',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBcjcQIrhz9PZgfCbAmbQxIkcWnvTEXRqY',
    appId: '1:182119041017:android:aa9133cfe60af28a1f9f28',
    messagingSenderId: '182119041017',
    projectId: 'portfolio-f4698',
    storageBucket: 'portfolio-f4698.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAelU-txvJ8C2q-ZGdF73irn3h1jjcYG6Q',
    appId: '1:182119041017:ios:86991cc4398ecb7c1f9f28',
    messagingSenderId: '182119041017',
    projectId: 'portfolio-f4698',
    storageBucket: 'portfolio-f4698.appspot.com',
    iosBundleId: 'com.example.rafay_portfolio',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAelU-txvJ8C2q-ZGdF73irn3h1jjcYG6Q',
    appId: '1:182119041017:ios:8b228eeb980cb7b21f9f28',
    messagingSenderId: '182119041017',
    projectId: 'portfolio-f4698',
    storageBucket: 'portfolio-f4698.appspot.com',
    iosBundleId: 'com.example.rafay_portfolio.RunnerTests',
  );
}
