// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members, no_default_cases
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDW8umutsOGwYZPNDFbF2huW_mvGtGITfQ',
    appId: '1:443401904437:web:76dfdf3ad9f6d8e6cc6c7c',
    messagingSenderId: '443401904437',
    projectId: 'lifegoals-50b41',
    authDomain: 'lifegoals-50b41.firebaseapp.com',
    storageBucket: 'lifegoals-50b41.appspot.com',
    measurementId: 'G-B90J8PF6GB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCEFQ13txytxMo4lJMtfbISzwHxE6kcUPA',
    appId: '1:443401904437:android:a76bd1196d49347ccc6c7c',
    messagingSenderId: '443401904437',
    projectId: 'lifegoals-50b41',
    storageBucket: 'lifegoals-50b41.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBMX0GZ95SjacWtkRsCIrBOohfExRWLCzE',
    appId: '1:443401904437:ios:f7d63fd86355b99dcc6c7c',
    messagingSenderId: '443401904437',
    projectId: 'lifegoals-50b41',
    storageBucket: 'lifegoals-50b41.appspot.com',
    iosClientId:
        '443401904437-82dtg8jt158rgcbpcavaloh5cg0h8to1.apps.googleusercontent.com',
    iosBundleId: 'fi.nikkijuk.lifegoals.lifegoals',
  );
}
