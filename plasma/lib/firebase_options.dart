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
    apiKey: 'AIzaSyBvml80FRAarB-QkmgU_-izBwH-6TVwJBo',
    appId: '1:973008203665:web:c393ce7f4944bd215a3430',
    messagingSenderId: '973008203665',
    projectId: 'plasma-9a6ea',
    authDomain: 'plasma-9a6ea.firebaseapp.com',
    storageBucket: 'plasma-9a6ea.appspot.com',
    measurementId: 'G-GKYCZJ0V7C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC9f9sipe8CltGAmgjVGv7FCwqiQYRCMv0',
    appId: '1:973008203665:android:93274606906b25d15a3430',
    messagingSenderId: '973008203665',
    projectId: 'plasma-9a6ea',
    storageBucket: 'plasma-9a6ea.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCOdHEGOnU7dAkH5oKGBA0reF--ndNw_3w',
    appId: '1:973008203665:ios:0d017d9890a783195a3430',
    messagingSenderId: '973008203665',
    projectId: 'plasma-9a6ea',
    storageBucket: 'plasma-9a6ea.appspot.com',
    iosClientId: '973008203665-2s7u2f918569je2gr47r4iohk3t5f0m8.apps.googleusercontent.com',
    iosBundleId: 'com.example.plasma',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCOdHEGOnU7dAkH5oKGBA0reF--ndNw_3w',
    appId: '1:973008203665:ios:0d017d9890a783195a3430',
    messagingSenderId: '973008203665',
    projectId: 'plasma-9a6ea',
    storageBucket: 'plasma-9a6ea.appspot.com',
    iosClientId: '973008203665-2s7u2f918569je2gr47r4iohk3t5f0m8.apps.googleusercontent.com',
    iosBundleId: 'com.example.plasma',
  );
}
